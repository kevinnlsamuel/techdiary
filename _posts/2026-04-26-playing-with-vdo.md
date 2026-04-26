---
title: playing with lvmvdo
description: >
    trying out the virtual data optimizer in lvm
---

long time no post. also this isn't really a post. there won't be any more posts.
this website will henceforth be a bunch of unedited "scribbles" for my own reference

***

# what is vdo?
virtual data optimizer. it adds deduplication support to logical volumes created using lvm.
well not vdo itself, but a sort of plugin for lvm that exploits the `dm_vdo` kernel module

# why dedupe?
i want to play around with [libvirt](https://www.libvirt.org) and install a bunch of vms
but i don't want to waste storage space

# will this work?
honestly, no clue. i don't think so. i think while lvmvdo is cool, libvirt doesn't support
using predefined lvm logical volumes as libvirt storage volumes. i saw there was a way to
define an lvm volume group as a libvirt storage pool. and then libvirt is supposed to create
logical volumes from said libvirt pool/lvm volume group as needed

but for all this vdo to work, i need to define the volumes outside of libvirt. can i tell libvirt
to use a specifc lvm logical volume? actually yes. i don't **need** to define the storage medium
as a libvirt volume hmmm. ok but that's for another day

# how does lvmvdo work?
uses a "pool" a vdo pool to store the actual data, and the volume group that's available as a block
device for writing a filesystem onto is a sort of thin volume. so applications see the filesystem on
a virtual block device. the virtual block device is writing data to the "pool" and the pool is deduping
and also compressing as it receives data

# how do i want to use it?
i want a single vdo pool to be shared across multiple thin volumes

## why would i want that?
vms would have similar data. duh

# how do i do that?
at first i was looking at the docs on `lvmvdo(7)` but that was confusing. turns out the instructions on
`lvmthin(1)` are simpler

```console
# lvcreate --type thin-pool -n <poolname> -L <size> --pooldatavdo y <vg>
```
so this automatically create a vdo pool on \<vg\> a then a thin pool on the vdo pool

## another thing
the automatically created vdo pool is called `vpool`. so that ends up being confusing because now i see `vpool0_vpool`
in the output of `lsblk`. so just for my convenience
```console
# lvrename <vg>/vpool0 vdo
```

## creating the thin volumes
well almost all everything is done, i still need to create thin volumes that can be used as block devices

```console
# lvcreate --type thin --thin-pool <poolname> [-n <thinvolname>] -V <virtualsize> <vg>
```

leaving out the `-n <thinvolname>` gives me a logical volume called `lvolN` where `N` is
the next number in the sequence of logical volumes. not bad, but not ideal. i should use the `-n` flag

# using thin volume that's on a thin pool that's on a vdo pool
create a filesystem

```console
# mkfs /dev/mapper/<vg>-<thinvolname>
```

and then do whatever. it's not apparent to me/you nor the applications that there
are so many layers of abstraction under this virtual block device called \<thinvolname\>.

\<thinvolname\> has its blocks allocated dynamically from a thin pool. and the thin pool in turn
is sitting on a vdo pool that's deduplicating and compressing the blocks written to it

max space savings hopefully. next step is figuring out how to actually use this with libvirt
