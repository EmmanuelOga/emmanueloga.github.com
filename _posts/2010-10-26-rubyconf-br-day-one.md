---
layout: post
title: Rubyconf.br Day One
---

{{ page.title }} (<strong>draft</strong>)
=========================================

<p class="meta">26 October 2010</p>

Today was the first day of the ruby conference in Sao Paulo. There where two
tracks so I could only attend some of the conferences. Some of them where given
in portuguese. I'm surprised I could understand most of the portuguese talks
without much problem.

It's a little late on the night so apologies for the quality of this post. I
definitely need a second pass over this post.

Opening: Fabio Akita
--------------------

Fabio opened the event with an inspiring talk about the four year road that was
the building of the great ruby community on Brasil.

He reflected on the common myth of the geniuses-from-born, and how even someone
like Mozart had to practice a lot before coming up with his best productions.
Lesson he wanted to state is, never stop practising. Deliberately practice
focusing in things you know you need to improve. Be receptive of critic (and
seek for it, ask for help from more experienced developers). Beware this
kind of focused efforts are not always fun from the start, but something we all
need to do to improve our craft. Do not stay in comfort zone, step ahead and
work out your weak points.

OpenSource is an ideal field to get better as a software developer. It isn't
only about code, but also about relating with others and sharing your ideas
with people, building a feedback loop, letting other know about your projects,
etc.

Another interesting points where, do not learn by learning, learn by doing.
And, don't be afraid to fail. If you never failed you never lived.

Client Side Developing: Yehuda Katz
-----------------------------------

Perhaps not surprisingly, Yehuda talked about client side development. He gave
some examples from SproutCore but stressed the general ideas are useful even if
you use something else to implement them.

Even though Ajax improves page responsiveness, user still have to wait for the
ajax request to happen. So, a better way to improve responsiveness is limiting
as much as possible the work on the server side. An easy example is validations
(stuff like presence of a field or confirmation of a password can be easily
done with javascript)

In this model the server side generated page can act almost like an static
template where the client side logic can manipulate the different interface
elements. Because this basic template should not change a lot, he encouraged to
cache as much as possible, resulting in fewer http requests made to the server
and hence higher latency. Rails is an ideal server side technology because it
provides powerful tools to build APIs.

Many projects mix DOM manipulation and business logic, causing spaghetti code
and uneven performance. It is better to buffer all the DOM manipulation calls
and do them at once and had separate objects to deal with the business stuff.

SproutCore uses a WIP batched version of jQuery which allows for buffered
execution of DOM manipulations.

The batched jQuery commands needs to be flushed at some point, and so a loop
like this is used to handle things in a closed event loop:

events (e.g. keypress, field change, etc.) -> handler -> bindings -> batched jquery flush -> loop

The bindings part is a technique to bind the change of an object (e.g. val on a textfield) to an
attribute in another object (like a model object).

    objA.set("name", "john")  // objA is binded to objB
    objB.get("name") -> ("john")

Two javascript libraries to perform binding are
[datalink](http://github.com/nje/jquery-datalink) for jQuery, SproutCore and
[knockout](http://knockoutjs.com/).

With these techniques you get predictable performance. You still need to do
some checks on the server side, including ensuring db consistency.

There are some javascript libraries to improve accessibility on rich client
applications.

Resque: Scott Chacon
--------------------

Scott talked about Resque and its parent/child fork model, the god/monit
friendly signals based management and some comparisons with other queues.

Resque has demonstrated to be solid scalable, running on GH for more than a
year for 165.000.000 jobs (13M/mo).

The sinatra web UI provides a very nice overview of what the queue is doing at
any specific moment.

Compared with:

* SQS: it has much better latency
* ActiveMessaging: it is much easier to use
* BackgroundJob: it is faster because it uses the forking to load the rails env just once
* DelayedJob: it is faster mostly because it is redis based (DJ uses mysql which becomes slow when you have thousands of jobs)
* beanstalkd: it has better visibility on the state of the queue

Scott did a live demo with an application to render pdfs, showing how easy is
to manage the background jobs and see exactly how many jobs are pending at any
given moment.

Rails 3.0 and 3.1: Jose Valim
-----------------------------

Jose talked about some of the refactorings on Rails 3.0, and how things where
modularized to better fit single responsibilities.

Key improvements on Rails 3.x are: agnosticism, better generators and addition
of ActiveModel and Railties.

He gave some sneak peeks on the new features for Rails 3.1, like better engines
and assets management.

On 3.1 sass will be used to serve assets. The stuff you'll be able to do is on
par with the functionality on the sprockets gem. The javascripts and stylesheets
will no longer be hosted on static /public folders but on /app subdirectories.

    /app/assets/javascript
    /app/assets/stylesheets

There will be change to do things like "JavascriptsController.use Minify" to
optimize assets size.

Caching will be handled by Rack::Cache, a middleware that handles caching
according with the RFC 2616 spec.

Assets will no longer have a query parameter with the timestamp of the file:

    /javascript/foo.js?#{foo.timestamp}

Instead, the RELEASE timestamp (with the timestamp of the release date) will be
used to update all assets at once (to avoid breaking js dependencies).

There will be a syntax like

    config.js_bundle :omg, :with =>  [:foo, :bar, :baz]

to manage bundles of assets.

Another Rails 3.1 improvement he mentioned was ActiveRecord identity map, which
can save lots memory, and the addition of simpler migrations: no more
self.up/self.down but a simpler #change method will be used to manage
migrations.

RubySOC: Ricardo Panaggio & Thiago Pradi Talk
---------------------------------------------

Ricardo and Thiago reflected in their experiences participating on the RubySOC,
and commented about the many incentives to do it:

* Plain old monetary incentive
* Opportunity to networking with great programmers
* Chance to improve as developers and really get to know the ruby language
* It is fun!

Some advice they gave on participating is to learn to receive critics, practice
clear English speaking/writing if you are not native English speaker, and focus
on good time management avoiding leaving things to the last minute.

When sending a proposal, sending a blank or bad written description is worse
than not sending anything. You need to spend time on it even before being
accepted in the program, but also don't be afraid of learning new things (and
learning while doing things).

Once selected, it is important to start the project ASAP and be communicative
about the progress. Patience is needed, as menthors can't always respond to
queries right away.

Good practices on Rails: Lucas Hungaro
--------------------------------------

Lucas talked about libraries and plugins he finds useful to improve performance
of his rails applications: bullet, query_reviewer, rails_indexes, kasket,
cachy, oink, DBCharmer, resque, cache_proxy.

He also commented on techniques that can improve code quality and
responsiveness: caching, push technologies and async responses.

He gave a warning on cloud computing usage (EC2): noisy neighbors, high I/O
latency and overpopulation are quite common flaws of cloud computer platforms.
That's why hosting on the cloud is not always the best solution.

He recommended [a presentation](http://vimeo.com/12814529) from J. Golick on
the subject.

On code quality he talked about code defensiveness (prevent bad input) and
Postel's Law: "be conservative in what you send, be liberal in what you accept".

Other guidelines he talked about:

* The Law of Demeter, "don't talk to strangers"
* SOLID
* Fat models, but don't put everything in the model (single responsibility principle)
* If something is difficult to isolate and test, probably is badly written.
* Zen Python (import this)

He linked to [a gist](http://gist.github.com/524462) with interesing references.

De-conference
-------------

The final hour of the conference was assigned to people giving quick talks
about stuff like Agile methodologies, and projects like hercules for continuous
deployment, infinity_test for testing, ironruby and mirah.org.
