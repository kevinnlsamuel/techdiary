---
title: misunderstood libvirt storage
description: >
    of course i can't just attach preextisting partitions as partitions
---

my big idea was to create lvm logical volumes and to attach each one separately
into the virtual machine. the lvs would live on top of a vdo pool and save me a
lot of space; so clever!

except there was no way i could push a single partition into a vm. `virt-install`
only has a `--disk` flag. the other option is `--filesystem`. but i suspect most
typical OS installers wouldn't accept installing to a preexisting filesystem that
is exposed as just a directory (Arch might btw)

i think i should just start writing image files like a normal person. those are the
sane defaults and that should get the work done a lot faster

but i do wonder if vdo can dedupe blocks inside of an image file. i don't really know
very much about vdo or deduping. but that's for another day

so the plan now

1. i have a vdo pool
2. i have a few thin lvs on those pools
3. wait- i don't actually need them to be thin

hmmm. i made thin lvs because i wanted multiple lvs to share the same vdo pool. but now
i won't be using lvs. i'll be using `.qcow2` most probably. sooo a single vdo pool. a single
volume on the pool. keeping things simple is obviously better

i'll recreate the volume then

```console
# lvcreate --type vdo \
    --name land \
    --size 128G \
    --virtualsize 256G \
    --compression y --deduplication y \
    --vdo-pool vdo \
    waste
# mkfs -t ext4 /dev/mapper/waste-land
```

in fairness `--vdo-pool vdo` isn't necessary. but i hate the automatic names

then now that i have a volume i need to define it as a pool under libvirt. since i'm just going to
dump `.qcow2` files. this would be a `dir` pool… but then i would also need to define a mountpoint
in fstab. that's not enticing. good thing the `vol` pool type exists so i can let libvirt handle it

```console
$ virsh -c qemu:///system pool-create-as wasteland vol \
    --source-dev /dev/mapper/waste-land \
    --target-path /var/lib/libvirt/pools/wasteland
```

now libvirt should mount the device whenever the pool is called upon

so now i should be able to just do

```console
$ virt-install --disk wasteland/fedora43 [...]
```

testing this out will be for another time
