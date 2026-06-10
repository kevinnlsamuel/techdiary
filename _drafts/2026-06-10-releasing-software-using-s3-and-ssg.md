---
title: Releasing Software using S3 and an SSG
description: 11ty + Linode Object Storage + rsync + just
# image:
  # path:
  # alt:
---

one fine day i decided i wanted a page that went like `releases.kevinnlsamuel.com` for
releasing software.

i was mainly thinking about a spreadsheet that i was preparing for
the office. it wasn't really in my job description. but i love solving tech problems
and this was a tech problem to solve. so i made a new spreadsheet for a particular process
at the office. now how do i keep it up and available somewhere even if they accidentally
delete the file? what if i'm no longer working there for them to come ask me for the original file?
how do i add new features? and how do i update them when there are new
features?

oh right! a website. so cool!

now websites come with maintenance overhead. and software files while not typically so, can become
large… both of which i think can be sorted out by using object storage

but object storage only supports static websites. so i need a static website. which is actually what
i prefer anyway. so now i just need an SSG. the only one i'm familiar with is 11ty so ofc i will use it


<!--
- vim: spell spelllang=en
-->
