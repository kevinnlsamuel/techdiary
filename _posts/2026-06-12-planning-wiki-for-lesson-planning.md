---
description: 
# image:
  # path:
  # alt:
---

the idea of a static website+CMS is something i've had running on my mind for a while now. and
by chance i came across the idea of a wiki and now i'm really into it.

if you don't know me irl, i'm currently a teacher. shocker! also if you don't know me irl, how
did you even stumble upon this blog? not even people i know read this.

so this line of thought was birthed early on when i was just starting to teach. my superior was telling
me that i need to plan out my lessons marking the objectives of each activity done in class. and
i had to also keep track of the time it would take/that i could dedicate to the activity

i wanted a nice format for these "metadata" that wouldn't be so in my face, but still be there.
i realised i'd need a nice custom template to achieve that. i was thinking about SSGs like 11ty
and the metadata block… kinda complicated but i could extend the format any way i wanted

i mostly "carry" my notes as websites on my domain running on my server. i don't go around with
a pendrive (actually i do. i just don't use it most of the time). so i was thinking it would be
neat to also edit my notes on the go. so i'd want a CMS… but i cannot type without vim. i type
with vim more than i do without. i prefer typing with vim in fact. i feel ideas flowing a lot more
easily this way 🤷 i'm hardly thinking about the other actions i make such as
moving around or saving the file, almost all of it is muscle memory

but i'm not skilled enough to just create a CMS at a moment's notice. and i would also need a lot
of time to build the templates. so this whole plan was just put on hold. i was typing my notes in
markdown in a rather ugly format with each activity being a separate heading. it was just asdfasdf
the sections didn't get separated as cleanly as i would've liked

in an effort to increase the time i spent on reading, i was perusing a blog
entry by Veronica Explains on her laptop dedicated for note-taking. with my short-form-video-addled brain's
low attention span i stopped reading it pretty quickly and went to the homepage of the blog and started
scrolling through (ok. that's kinda ironic now that i think about it. is it? is it not?). another entry
caught my eye: ["How I setup vimwiki for notetaking"](https://veronicaexplains.net/vimwiki-101/). i perused
through that article and thought this could just work for me! sure i don't actually need most of the vimwiki
features. but the possibility of converting the notes to html did catch my eye and also made me think
of how wikis come with a CMS that's easy and intuitive

i went through a few options, but i think i'll be settling on MediaWiki just 'cause. i noticed
[someone went through a bunch of reasoning](https://blog.concannon.tech/tech-talk/wiki/)
(that i haven't paid attention to) and settled on Wiki.JS. but i'm not really a fan of running too much JS
and MediaWiki has been around for a long time. i suppose the drawback would be that MediaWiki uses a database
while Wiki.JS could support plaintext. i should actually read the blog and decide if that's something that matters
to me

---

anyway organising my notes had been the hardest part of the original plan, but now that i started thinking of it as
a wiki of many many interconnected pages, i think it's become a bit easier. originally i was thinking of a Wordpress-style
block editor that would "magically search for and find existing block descriptions of activities" (max complexity?). but
now that i'm thinking of a wiki i think i have a much better idea

each activity has its own wiki page with all the metadata: time, objectives and what not. for each course i teach, i
create a new "collection" and each day/session is a separate page. and the session page is composed of links and previews to
activities. that's it. i'm done!

this somehow feels more simple in theory, but idek how i'll get around to implementing it. a lot of research pending

---

but in the meantime, i thought i'll start using [vimwiki](https://github.com/vimwiki/vimwiki), build HTML and push it to
my existing site. i could probably start arranging it in a similar fashion

---

installing vimwiki is easy enough. i just added a new file `~/.config/nvim/lua/plugins/vimwiki.lua` (because that's how
i can add local changes. the others are version controlled using git. gotta test before i commit to applying this setting
onto every single device i use)

```lua
return {
	{
		"vimwiki/vimwiki",
		init = function()
			vim.g.vimwiki_syntax = 'media'
			vim.g.vimwiki_key_mappings = {
				lists = 0,
			}
		end,
	}
}
```

the global vim setting sets the syntax to mediawiki, duh. and the second one disables a bunch of keymaps
that vimwiki adds. the keymaps all start with the key sequence <kbd>g</kbd><kbd>l</kbd> which interferes
with my existing keymap that jumps to the end of a line (sth i stole from helix). this `gl` keymap is
essential for me because i use an alternate keyboard layout professionally and `$` is always a pain to find
<code class="language-plaintext highlighter-rouge">&#x0060;</code> even more so.

and speaking of alt keyboard layouts, i should probably also remap the leader. `\` is also hard to find/type.
i thought i had already remapped `<Leader>`, but apparently not. so this one goes into `~/.config/nvim.lua`
into a line before the loading of lazy.nvim

```lua
--- [ blah blah blah ]
vim.g.leader = ' '
--- [ nvim loading ]
```

now the final part… i should remap the `VimWikiIndex` command from `<Leader>ww` because <kbd>w</kbd> is in a
different place and i have decided against building two different muscle memories (it confuses me and slows me down
because i lose track of which layout i'm on)

(wow almost all my issues are because of the alternate keyboard layout)

the actual final part should be building the HTML pages from these wiki pages, but for now i shall satisfy myself with
Nextcloud syncing my wiki and opening them in nvim across all my different devices

oh right… so i need to change the wiki path to put it into the Nextcloud folder

i'm reading the vim help pages to type this out and i'm already find the `vimwiki-option-auto_export` option that
should ideally just let me generate the HTML without any additional work haha. that's why you should rtfm, kids

```lua
--- ~/.config/nvim/lua/plugins/vimwiki.lua
return {
--- […]
	init = function()
	--- […]
	g.vimwiki_list = {
		{
			path = os.getenv("HOME") .. "/nextcloud/..."
			html_path = os.getenv("HOME") .. "/nextcloud/.../www"
			auto_export = 1
			auto_toc = 1
			links_space_char = '_'
			toc_header = 'tableau'
		}
	}
	end
--- […]
}
```

already a quick check of `:h vimwiki-syntax` tells me that i cannot convert mediawiki
to HTML with the builtin tools, so i'll need to do something with pandoc later i think

<!--
- vim: spell spelllang=en
-->
