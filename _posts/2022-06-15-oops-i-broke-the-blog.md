---
description: Blog Breaking Build
image:
  path: /assets/post-img/2022/06/15-000-broken.png
  alt: "screencap showing blog without styling. just plain ol' html. but still accessible! wink wink"
  style: "object-fit: scale-down;"
---

[yesterday]: {%- post_url 2022-06-14-wikipedia-journey-in-your-pocket -%}#added-a-helper-script-to-edit-todays-post

## Exclusion causes confusion

Yesterday, I [created a helper script][yesterday] to simplify
my work of opening the file to edit for each day's post.

And I named the script `post` just cause :shrug:. I did not
want to call it `post.sh`. So it was just `post`.

But any file in the source directory is copied over
statically by Jekyll to the final build. So downloading my
script would be as easy as going to
~~<https://kevinnlsamuel.com/bitesyzedtechdiary/post>.~~
<https://blog.kevinnlsamuel.com/techdiary/post>.

Now this is not a problem. My source code is public anyway.
But it is unneccesary and does not need to be on my website.
Likewise for `docker-compose.yml`.

Sooo, I
[excluded them in `_config.yml`](https://github.com/kevinnlsamuel/techdiary/commit/cbeed25dce473f2e98dd6006e6e22510cd7cd781)

And it made sense because I was not using any glob characters
but nope, the `post` layout in my theme ended up being excluded
somehow, and all the posts were broken. There was no `<html>`
no `<head>` no `<body>`. Just `<article>`. It did look nice
to me to be honest.

Anyway, removing that entry to the exclude array fixed my
blog. But I still don't see how that happened. It should not
have happened, right?

At first, I thought it was a bug where globbing took place
regardless. But after trying to peruse the source code for
Jekyll and understanding nothing&hellip;

> I thought Ruby was supposed to be human readable.
>
> &hellip;
>
> WHERE???

I wonder if the idea is similar to `.gitignore`s pattern
matching. And any file with the name `post` got excluded.
So that would be a theme file without an extension.

And what if
[instead I used `/post`](https://github.com/kevinnlsamuel/techdiary/commit/11071a6432c892fc881b17179da540a018b83fde)
to indicate that only the file named post at the root
should be excluded?

Nope. No go. That was not the solution.

Well that's not today's problem.
But that's it for today's post.

