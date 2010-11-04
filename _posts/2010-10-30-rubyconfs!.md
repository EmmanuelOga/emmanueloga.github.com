---
layout: post
title: See you at rubyconf.br!
---

{{ page.title }}
================

<p class="meta">30 October 2010</p>

This year I could attend both rubyconf Brazil and Uruguay. Both conferences had
great talks and summarizing everything would be overkill, so I'll instead post
some brief notes.

* [http://rubyconf.com.br/](http://rubyconf.com.br/ "RubyConf Brazil")
* [http://www.rubyconf.com.br/en/schedule](http://www.rubyconf.com.br/en/schedule "Brazil Schedule")

* [http://rubyconfuruguay.org/en/agenda](http://rubyconfuruguay.org/en/agenda "Uruguay Schedule")
* [http://rubyconfuruguay.org](http://rubyconfuruguay.org "RubyConf Uruguay")

My Notes
--------

#### Brazil Opening

[Fabio Akita](http://akitaonrails.com/)'s talk was great in motivating the
audience to be more participative in open source projects as a way of
continuously improving as developers.

#### Client side development

[Yehuda Katz](http://yehudakatz.com/) talked about focusing on the client side
of web applications.  Using Ajax techniques is a start but ajax still generates
a lot of latency waiting for server responses. In order to have
[a better client side experience](http://www.sproutcore.com/)
techniques like buffered DOM manipulation, object bindings and
event loops on the client side, can help to do as much work on the client as
possible.

#### Rails 3.1

[José Valim](https://github.com/josevalim) talked about some great features
that will be packaged on rails 3.1, as better asset packaging (in line with the
functionality provided by the sprockets gems), making rails serve the
stylesheets and javascript and use sass, and general improvements on a lot of
areas (new ActiveRecord's identity map, better generators, etc.).

#### Rubinius

Both [Evan Phoenix](http://blog.fallingsnow.net/) in Brazil and [Brian
Ford](http://blog.brightredglow.com/) in Uruguay described great features
packed on of [rubinius](http://rubini.us/). Some of the impressive features are
the integrated console and the profiler (both triggable by command line, no
additional gems required). They also talked about the modularity and
extensibility of the tools bundled in the rubinius environment, made evident by
the possibility to implement 3rd party languages (like the
[fancy programming language](http://www.fancy-lang.org/)).

#### JRuby

[Charles Nutter](http://blog.headius.com/)
[showcased](http://www.slideshare.net/CharlesNutter/rubyconf-uruguay-2010-jruby)
some cool demos on jruby, including live coding a swt GUI from irb, using the
VisualVM profiler to profile some code, running a multithreaded java
environment from the command line using the [trinidad
gem](https://github.com/calavera/trinidad), and a 3D game. He also showed a
demo of the [mirah programming language](mirah.org), which has a syntax
similar to ruby's but contains type annotations and can produce either java
code or jvm bytecode.

#### Webfinger

[Blaine Cook](http://romeda.org/) talked about
[webfinger](http://webfinger.org/), a solution to provide users with an
identity on the web in such a way they becomes the owners of it (as opposed as
tying the identity on the web to any given service, like twitter, facebook or
linkedin profile names). Slides [here](http://lanyrd.com/2010/rubyconf-uruguay/smzm/).

#### Ruby 1.9.x fibers

[Aaron Patterson](http://tenderlovemaking.com/) gave a talk about scheduling,
fibers and coroutines.

#### OOP and SOLID

[Jim Weirich](http://onestepback.org/) gave a talk about OOP and the
[SOLID](http://en.wikipedia.org/wiki/SOLID) principles.

#### Git

[Scott Chacon](http://jointheconversation.org/) gave a tutorial for git,
starting from the fundamentals and the differences with other VCS like rcs or
svn.

#### Clojure

[Federico Brubacher](http://twitter.com/fbru02) talked about
[clojure](http://clojure.org/), a very nice functional programming language for
the jvm, and a great alternative to scala as it is a much more simple language.

#### ActiveRecord and Identity Maps

[Emilio Tagua](http://miloops.com/) talked the addition of an Identity Map to
ActiveRecord to shield great memory and performance savings.

#### Programming patterns

[Ignacio Facello](http://nucleartesuji.com/) talked about patterns for Ruby.

#### Metaprogramming

[Santiago Pastorino](http://twitter.com/spastorino) talked about
[metaprogramming](http://www.slideshare.net/spastorino/metaprogramming-5634072)
ruby techniques.

#### Android

[Tim Bray](http://www.tbray.org/ongoing/) gave a 30 minutes long advertisement
on [android](http://www.android.com/), quickly dismissing ruby as a viable
development option while it was on it. Despite that, android is a great
platform to develop mobile applications.

#### Uruguay Keynote

Evan Henshaw-Plath ([@rabble](http://twitter.com/rabble)) closed the Uruguay
conference with a great keynote where he talked about the characteristics of
the ruby community. He made some poignant references to _why (pun intended) and
some other guys from the ruby scene.
