---
layout: post
title: VIM config snippets
date: 28 November 2011
---
There are lots of things you can do to better organize your vim
configuration, starting with using
[pathogen](http://www.vim.org/scripts/script.php?script_id=2332).

Apart from using pathogen, what I like to do is *having small snippets
of configuration on separate files* to tweak specific things. Here's [my
.vimrc](https://github.com/EmmanuelOga/vimrc/blob/master/vimrc):

{% highlight vim %}
" Setup for pathogen.
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Load additional plugin configurations and stuff
for rc in split(globpath(&rtp, "rc/*"), "\n")
  execute "source" rc
endfor
{% endhighlight %}

First part is the setup for pathogen. The second part is what I'm
talking about, I go through every file in my
[.vim/rc](https://github.com/EmmanuelOga/vimrc/tree/master/rc) directory
and load every snippet of that folder.

A fun thing to try is to *make every snippet "self contained"*. That
way, if someone browsing your config thinks the thing you are setting up
there is cool, all he has to do is copy that single file to get
the specific piece of functionality.

BTW, since I use gvim most of the time, on the .gvimrc I just source the
.vimrc, plus a few GUI tweaks (removing toolbars, menus, etc).

{% highlight vim %}
source ~/.vim/vimrc
" ... some gui settings.
{% endhighlight %}
