---
---

### Oops, I did it again?

I haven't been very regular. So that's another blog that got stuck. But
it's not that I haven't been working. Just that I didn't write about it.

It is because the current workflow is a tedious pain.

> A convenient CMS is not something to be undermined.

### vim

Serrendipitously I found out that vim registers persist across sessions.
Even on completely different files. Tested on all the Linux environments
I had access to.

### `kbd` styling

This is something I had wanted to do back on
[19 Feb 2022]({{ site.baseurl }}{%post_url 2022-02-19-return-from-vacay%}).
Styling the `<kbd>` tags. Funny, I forgot it was a
[native HTML5 tag](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/kbd)

Anyway, I found
[another blog post](https://bskinn.github.io/Custom-kbd-Style/)
about custom styling for `kbd`. A lot of Jekyll resources are very easy to
find, eh?

I was about to follow the tutorial _exactly_. I think I actually tried,
but it didn't work. Then I remembered! I'm using Minima's master branch.

Anyway, some day in between I followed the instructions for Minima and
[did some custom styling](https://github.com/kevinnlsamuel/techdiary/commit/e2ffb21e8478acef0f51b295f631c4d8030c03fb).

> Wow, I am very bad at CSS.

At the moment of writing, minima's custom styling is done in

```
/_sass/minima/custom-styles.scss
```

### [StackEdit.io](//stackedit.io)

I came across StackEdit in the [bskinn blog](//bskinn.github.io). The
footer said the page was written with StackEdit. Curious, and hopefull that
it would be a CMS I could use, I took a look.

But it wasn't working with GitHub's API at the moment. It isn't working now
either. Seems quite good. Not sure how it works with GitHub since it's
based on git and needs commits. Might be a system similar to GitDoc, maybe?

I'll know some other day I suppose.

### Releasing space in WSL2 `ext4.vhdx`

I do not like things using space in my persistent storage. The fact that
my current machine uses and SSD amplifies my desire to keep it clutterfree.
So I had already trimmed out a bunch of unnecessary packages and files from
my Debian installation under the Windows Subsystem for Linux.

But the virtual disk was still much larger than the output of `df -h /`?
**MUCH** larger.

Turns out the free space isn't automatically released from the [harddisk
file](https://github.com/microsoft/WSL/issues/4699). But gotta love the
community for giving you
[a solution](https://github.com/microsoft/WSL/issues/4699#issuecomment-627133168)
all the time :heart:

```
wsl --shutdown
diskpart
# open window Diskpart
select vdisk file="C:\…\ext4.vhdx"
attach vdisk readonly
compact vdisk
detach vdisk
exit
```

I suppose those instructions are for an older version of WSL though.
My `ext4.vhdx` is in
`C:\Users\username\AppData\Local\Packagaes\TheDebian...\LocalState\ext4.vhdx`

### SSHFS in Windows... again

Nextcloud is cool and all, but I ended up wanting to grab a file from my
phone wirelessly after all. Even using adb over tcp would not work
consistently because I need to restart the daemon in tcp mode each time I
reboot the phone, **and** keep track of whether I had rebooted. Bleh.

SSH is a lot cooler. A simple `sshd` running in [Termux][//termux.com/] on
my phone and `sshfs` in WSL2 to mount the folder. But even I want a gui at
times. This was one of those. I was looking for image files from my camera
folder.

And so, I tried opening the mountpoint in Windows Explorer. But permission
got deined. Hm.

It's back to the top rated sshfs solution for Windows
[sshfs-win](https://github.com/winfsp/sshfs-win).
It worked surprising well. So all's well that ends well!

If I have any complaint, it's that only `~/.ssh/id_rsa` can be used for
key-based authentication. I prefer `ed25519` keys in places where I cannot
use my gpg-keyring for ssh auth -- but oh well :shrug:

### Messing with `pinentry`

As someone who has most of my `$HOME` checked into version control I find
it unsettling that I have just ONE system that needs its own
`gpg-agent.conf` that cannot be used on others. I tried messing around with
update-alternatives. But that's not a user level solution, so I didn't
really like it.

In the end I had settled for a script that used the non-standard pinentry
executable if it existed and fell back to more standard ones.
But I had not realised that pinentry worked on _stdin_ rather than cli
args. So that was a flop and I had to revert my changes.

### Messing with `git` _hooks_

I dabbled a bit with
[Git hooks](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks).
It was a yakshaving trip, but I decided it
wasn't a very practical solution and ditched it.

Interesting stuff though. I went the vanilla route. Doesn't seem like there
are ways to apply the hooks to all distributed copies of a repo. Or I
didn't shave the yak enough. Haha, what a funny thing to say.

### Windows 11 activated BitLocker in Home edition

After one of the updates, Windows encrypted my drives with BitLocker again.
I had lost encryption when I did a fresh install trying to solve driver
issues. The funny thing is that the night before I realised my drives
were encrypted I had actually been thinking of upgrading to Windows Pro
just so I could get BitLocker encryption. My laptop had originally been
encrypted by the OEM, but I overwrote that with my fresh install. Now
Windows redid it for me just as I was about to pay them so I could do it
myself. Heh. A loss for Windows. Probably not, but let's say it was.

### BSTD complaints :shrug:

Apart from the lack of CMS.
Not all emoji haven't been working even after I
[enabled](https://github.com/kevinnlsamuel/techdiary/commit/84b716406c4acdd27ddbf7ed1123f0b7e563b97a)
[`jemoji`](//rubygems.org/gems/jemoji). And with the current styling
the links would appear as one even though each word is a different
hyperlink. There's another complaint right there!
