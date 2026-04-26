---
image:
  path: https://upload.wikimedia.org/wikipedia/commons/f/fd/Wikipedia_Rabbit_Hole.jpg
  alt: >
    illustrative graphic of wiki rabbit hole that loops
    over various monuments, phenomena and objects indicating
    topics that one traverses in such journeys
  credit: >
    Glenn Newcomer.
    [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0)
    via [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Wikipedia_Rabbit_Hole.jpg)

description: I go down a rabbit hole starting at Twitter and ending at Wikipedia... ending?
---

## It always seems to start on Twitter

I suppose that is an indication of the amount of time
I spend there. What else do I do while waiting for an
update to finish downloading?!


## A lot of slides!

<p>
<blockquote class="not-twitter-tweet"
style="margin:auto;"
data-theme="dark">
<p lang="en" dir="ltr">
Last week, I gave a talk that had 373 slides. I had 45 minutes,
so it was a slide change every 7 seconds, on average. <br><br>
ama
</p> &mdash; Marcin Wichary (@mwichary)
<a href="https://twitter.com/mwichary/status/1536446839775498241?ref_src=twsrc%5Etfw">June 13, 2022</a></blockquote>
</p>
This seemed quite interesting, so I was reading through
the thread and found a link to
[a recording of an older edition](https://youtu.be/kVD-sjtFoEI)
of the talk.

While I had gone looking for the slides that moved so quickly
I had been quite engrossed in the content too. I found it so
interesting that I decided I would check out
[Figma](https://figma.com) and possibly use it for my next
illustration.

## &hellip; burnt pizza?

<p>
<blockquote class="twitter-tweet" data-theme="dark">
<p lang="en" dir="ltr">
obsessed with the person who forgot their frozen pizza
in the oven for four hours and then took a photo of its
charred remains for the wikipedia article &quot;pyrolysis&quot;
<a href="https://t.co/Xr6BaO6Lrg">pic.twitter.com/Xr6BaO6Lrg</a></p>
&mdash; depths of wikipedia (@depthsofwiki)
<a href="https://twitter.com/depthsofwiki/status/1536488146602536960?ref_src=twsrc%5Etfw">June 13, 2022</a></blockquote>
</p>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

HAHA this was just funny. And thinking this page might be interesting, I
decided to follow the page. The bio mentioned the person managing
the page. Going to their twitter profile I ended up...

## Wanting to download Wikipedia

&hellip; because they had recently tweeted about an piece
they had published on the [Slate](https://slate.com). It was about the
[whole of Wikipedia being download in Russian](https://slate.com/technology/2022/03/russia-wikipedia-download-kiwix.html)
more frequently of late. And also about other instances of Wikipedia
being downloaded.

So now I want to have my own copy of offline Wikipedia too.

## That ends the journey

Was there not a term for this? "Going down a rabbit hole" or
something to that tune? Where you go looking for something
and are eventually learning how to feed giraffes.

&hellip;

Ah it's called a
[wiki rabbit hole](https://en.wikipedia.org/wiki/Wiki_rabbit_hole).

Oh look there's an xkcd!

&hellip;

![single panel comic showing progress from reading about a bridge to a list of miscellaneous topics with three hours of excited clicking between them](https://imgs.xkcd.com/comics/the_problem_with_wikipedia.png)

Well I have come out of that rabbit hole now, right? &hellip;right? <strong>RIGHT???</strong>

## DING DING DING

That is a very misleading title. I just installed
[DING](https://extensions.gnome.org/extension/2087/desktop-icons-ng-ding/)
&mdash; Desktop Icons New Generation. An extension to the GNOME desktop
environment that I love and use to add desktop icons.

To be fair, I really do not look at my desktop very often&mdash;almost
never. But I am nonetheless used to being able to just plonk files to
my "Desktop folder" which is not as easy to select in the Files (nautilus)
graphical interfaces.

I had hoped DING would offer a solution, but no. It does not. DING does only
what DING is supposed to. Generate icons on the Desktop.

## Blog things

Wow I could fill pages with just this topic. But I don't want tooo!

### added a helper script to edit "today's" post

So now I don't have to type `vim _posts/202-ugh-what-day-is-it` and then
realise I missed the `.md`

Now I can just run `./post` and if there is a file with today's date, it
is opened using `${EDITOR:-vi}`. Else a prompt asks for a slug and creates
and opens the file. It's a
[surprisingly uncomplicated script](https://github.com/kevinnlsamuel/techdiary/blob/main/post)
for something that _**I**_ wrote.

Even in creating the helper, I had a lot of _hurdles_.
If you would like, see the
[commit history](https://github.com/kevinnlsamuel/techdiary/commits/main/post)

I had too many cycles of "yay it works" moments followd by "oh this does not work"
realisations after pushing.

Notably, `find` exits with `0`&mdash;the exit code indicating success even when
it has found no files. Well, that was intuitive.

## Jekyll SEO

Jekyll, the lovely static site generator used by GitHub pages, and hence this blog
comes with a plugin to handle most SEO.

But I was not sure how to use it. So of course I checked the documentation. And
adding an image and description that will be used in Twitter cards is very easy!
Just add the `image:` and `description:` tags to the top of the page's frontmatter.

But I was not sure about handling the base_url (i.e the root path of the
blog&mdash;`/bitesyzedtechdiary). Turns out it was handled internally by the plugin.
I only had to specify the url relative to project root. Noice.

## CENTERING!!!

I finally managed to center images and embedded tweets!

Apparently I could not just use the `img` selector because Jekyll placed
them inside `<p>` tags.

<style>
    p:has(>img) {
	text-align: center;
    }
</style>
So I used :drum:

&hellip;wait a second&hellip; what is going on?

Oh wait, you probably cannot see it yet.

I used the [`:has()` CSS selector](https://developer.mozilla.org/en-US/docs/Web/CSS/:has)
and there isn't full browser support yet. I enabled a flag on Chrome to see it.

But `p:has(> img)` clashes with emoji inserted using jemoji. Guess I need
`p:has(> img):not(.emoji)` is that even valid syntax&hellip;? It is!
Just not the one I need. The one I need is

```css
p:has(> img:not(.emoji)
```

But if I update my stylesheet, I would lose that dramatic effect. So yes, I
have internal style on this page. :stuck_out_tongue:

Oh Twitter embeds was a whole different matter however. Those are not images.
I tried adding inline styles to the embed, but it did not work. I think
the twitter script works by replacing the element on the DOM. My presumption
is backed by the fact that it works fine when I add it to external styles.

