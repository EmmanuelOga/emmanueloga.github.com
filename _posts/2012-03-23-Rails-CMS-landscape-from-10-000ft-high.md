---
layout: post
title: Rails CMS landscape from 10,000ft high
date: 23 March 2012
---

I'm needing a CMS to setup a semi dynamic web site. The features I'm looking for:

* Ruby 1.9.2 compatible (for use with [heroku's cedar stack](http://devcenter.heroku.com/articles/cedar)).
* If it uses Rails, it should be ~> 3.x.
* Backed by a SQL database.
* Easy to use by non developers.
* Easily extensible with custom sections (e.g. adding a product catalogue).
* I should  be able to install, style it ([bootstrap](http://twitter.github.com/bootstrap/)) and test it locally in *less than 5 minutes* (pretentious, I know).

I went through each of the options I found really quick, just to have a
feel of each one from 10,000 ft high, so I'm sure I might have judged
some of them unfairly.

## Radiant

According to the Wikipedia article, the first release of
[http://radiantcms.org/](Radiant) was 5 years ago, and it is still today
alive and kicking. Unfortunately, it runs on Rails 2.x. I rather not
have to deal with Rails 2.x for a new project if I can avoid it.

## Refinery

The [Refinery](http://refinerycms.com/) installation went on pretty
well, but I couldn't find any sample themes for it.

Even though Ryan Bates in
[his screencast](http://railscasts.com/episodes/332-refinery-cms-basics)
makes styling Refinery look easy as he just pastes some magic CSS code
on application.css.scss, trying to adapt Refinery to use [bootstrap](http://twitter.github.com/bootstrap/) is
definitely a lot more involved.

To be clear, I think if I was creating the styles from scratch then
Refinery would be great for me. The generated html looks pretty sane.
But since I'm constrained to make it work with existing markup (the way
bootstrap wants me to work), I find it a bit difficult to customize.

## BrowserCMS

After installing the [browsercms](http://www.browsercms.org/) gem, the
first thing I got with the very first command I run is:

    undefined method `load_missing_constant' for module `ActiveSupport::Dependencies' (NameError)

An error so early in the process of installing the app lowered my
confidence on the project... I wasn't sure I was going to succeed
debugging the problem in just 5 minutes. I may inspect this option
further in the future.

## Locomotive

Since [Locomotive](http://locomotivecms.com/) looks pretty cool, I
decided to obviate my decision of using a good'ol SQL database as the
storage and created a free account on mongohq.com.

I spent a couple of minutes setting up the whole thing just to be confronted
with this after following the site's instructions:

    uninitialized constant CASClient::Tickets::Storage::ActiveRecord (NameError)

The one requirement I did not want to obviate was, again, my 5 minutes
deadline. So I skipped to the next option.

## Nesta

[Nesta](http://nestacms.com/) just worked. This is a good thing on my
book. Also, it installed only a few gems.

There are a couple of
[ready made themes](https://github.com/search?q=nesta-theme&type=Everything&repo=&langOverride=&start_value=1). Even a bootstrap one (which did not work too well out of the box, at least with
the demo content... oh well).

Anyway, this is a very nice CMS for hackers, I can see myself using it on the
future. It is too hardcore to casual users though: you need to create markdown
files manually into the project directory to edit the site.

## Zena

[Zena](http://zenadmin.org/) looked promising but again it is based on
Rails 2.x and I don't feel like using Rails 2.x for a new project.

## adva2

I quote the [adva-cms2](https://github.com/svenfuchs/adva-cms2) README:

    "adva-cms2 is currently in an early developer sneak-peak preview stage."

Despite the warning I tried it and... I could not make it work. Some
problem with gem dependencies I think.

## Alchemy

[Alchemy](http://alchemy-cms.com/) installation was *almost*
straightforward. I got a couple of errors but I could correct manually
without a lot of hoop-jumping, but once I ran the dashboard I was
overwhelmed by the interface.

I just wanted to create a single page and test the result. I have the
*feeling* this must be a pretty powerful CMS, but since it is difficult
to use even for a seasoned web applications developer -as I am ;)- I'm
guessing not so experienced users will have a hard time with it too.

# Conclusion

From the whole list of CMS available the most promising ones for my
purposes where Nesta and Refinery. Nesta is a bare-bones, good for
static content, made for hackers CMS. I can see myself using it if I
ever need something slightly more flexible than jekyll for my blog.

Refinery CMS looks pretty good, works out of the box and is easy to
manage, but a little hard to style. Right now I'm not sure if it will
work for me, but spending something more than 5 minutes trying to
customize it seems worth the effort in order to avoid creating my
website form scratch.
