---
layout: post
title: Graphs are Everywhere! An overview of GraphConnect San Francisco 2013
date: 07 October 2013
---

[Neo4j](http://www.neo4j.org/) is a very cool
[Graph Database](http://en.wikipedia.org/wiki/Graph_database)
which sports an embedded mode for Java applications but also an stand-alone
server with a REST API. Drivers are available for
[a ton](http://www.neo4j.org/develop/drivers)
of different programming languages.

The developers of Neo4j organized [GraphConnect](http://www.graphconnect.com/san-francisco/)
@ San Francisco and I was lucky enough to be invited!
Hereby I present some of the notes I took.

<div class="align_center" style="padding: 2em;">
  <img style="max-width: 85%;" src="/images/graphc.png" title="GraphConnect 2013" alt="GraphConnect 2013" />
</div>

### New Opportunities for Connected Data, by [Emil Eifrem](https://twitter.com/emileifrem)

To me, the take away on this keynote was the notion that, in
any given data set, there are relations to be discovered: "There's a
Graph for That!". Exploiting this relationships can give a
company an strategic advantage over competitors.

Emil mentioned a paper published by Gartner:
[The Competitive Dynamics of the Consumer Web: Five Graphs Deliver a Sustainable Advantage](http://www.gartner.com/id=2081316).
Hopefully I'll get a hold of that paper at some point, sounds like an
interesting read! Many times relationships are not self evident. A question that we can
ask ourselves when observing a given system is: What five graphs
exist here?

Emil announced a free course on Neo4j will be made available on
[versal.com](versal.com), probably by end of October.

He finished by demoing a bit the sweet new
[data browser for Neo4j](https://github.com/neo4j/neo4j-browser/), built with
[AngularJS](angularjs.org).

### What's new in Neo4j 2.0, by [Andreas Kollegger](https://twitter.com/akollegger)

Labeling is a new feature that replaces the need to assign <code>{ type: "Type" }</code> properties
on Nodes or create <code>(Node)-[:IS_A]->(Type)</code> relationships. Labels
are light weight and shouldn't be thought of as a rigid type system.
Labels are automatically indexed, so it is efficient to query
for all Nodes with a certain label.

Another new feature is constraints: for instance, we can now
constraint that a given property, like title, should be unique across
nodes.

<code>CREATE UNIQUE</code> is going away and will be replaced with <code>MERGE</code>.

Many other things mentioned in this talk are well documented in a couple
of blog posts in a much better way than I could do:

* [New Milestone Release Neo4j 2.0.0-M03](http://blog.neo4j.org/2013/05/new-milestone-release-neo4j-200-m03.html)
* [Neo4j 2.0.0-M05 released](http://blog.neo4j.org/2013/09/neo4j-200m05-released.html)

### DIY Graph Search, by [Max De Marzi](https://twitter.com/maxdemarzi)

Max demoed a [search
engine](http://maxdemarzi.com/2013/01/28/facebook-graph-search-with-cypher-and-neo4j/)
accepting natural language queries, similar to Facebook Search.

He implemented the parser using
[treetop](http://treetop.rubyforge.org/), so not really a full natural
language processor, but it was a nice hack for getting something
working quickly. The app worked by converting human friendly search
patterns to Cyper queries.

### Graph Adoption at Gamesys, by [Toby O'Rourke](https://twitter.com/tobyorourke)

I was looking forward this talk because I really like both subjects:
Graphs and Video Games! :)

The talk was about how Neo4j is used on [Gamesys](http://www.gamesyscorporate.com/)
to back many of their games.

An example was how they tracked referral of friends. By visually
plotting the referrals, suspicious activity patterns can be quickly
spotted.

Graphs can also be used to model game economy. By putting all
monsters, characters, locations and items of an RPG on a Graph, an
analysis can be done showing things like monster that are too easy to
beat or items that are too cheap or too expensive. The talk was a bit
vague though about how to exactly find this things - trade secrets? :).

### Hacking Health Care with Neo4j, by [Fred Trotter](https://twitter.com/fredtrotter)

[DocGraph](docgraph.org) is a Data Set comprised of fifty million connections that
shows how healthcare providers team to provide care.

This talk was about were that data came from and what can be done
with it. If working with a big health data set sounds
interesting to you, you should check [this page](http://docgraph.org/data-and-tools/).

### Designing and Building a Graph Database Application, by [Ian Robinson](https://twitter.com/iansrobinson)

[This talk](https://www.dropbox.com/s/nqrt3pfln4vhnzm/Designing%20and%20Building%20Graph%20Database%20Application.pdf)
was about [Domain Driven Design](http://stackoverflow.com/questions/4166816/domain-driven-design-vs-model-driven-architecture),
how to build an application able to evolve over time, and how to use
Test Driven Development during the process. Not surprisingly, these very
same tools can be used to build any other application!

The talk showed how to identify the Domain Entities starting from user
Stories to the specification of the Data Model. One big advantage when
using Graph Databases is that the Entities identified during design
phase are often directly translatable to the Nodes and Relationships,
in a lot more straightforward and flexible way than when designing the
schema for a relational database.

### A Little Graph Theory for the Busy Developer, by [Jim Webber](https://twitter.com/jimwebber)

<div class="align_center" style="padding: 2em;">
  <img style="max-width: 85%;" src="/images/graphs2.jpg" title="Fancy Graph Theory Explained :)" alt="Fancy Graph Theory Explained :)" />
</div>

The closing talk from Jim Webber was very entertaining and informative!
Some key points:

* Complexity in data management is a function not only of the **size**, but also of the **connectedness** and **uniformity** of the data (people tend to only focus only on size).
* Graph databases leverage the rich theory behind graphs to find the information hidden in the relations of the data.
* Traditional databases, including relational and document oriented databases, [imprison](http://jim.webber.name/2011/04/square-pegs-and-round-holes-in-the-nosql-world/) your data.
* In Graph Databases we don't need to denormalize or lay the data in a special way (e.g. for map-reduce friendliness).

Some algorithms and concepts mentioned:

* [Triadic Closures](http://en.wikipedia.org/wiki/Triadic_closure)
* [Structural Balance](http://en.wikipedia.org/wiki/Signed_graph#Social_psychology)
* [Weighted Graph](http://en.wikipedia.org/wiki/Weighted_graph#Weighted_graphs_and_networks)
* [Graph Partitioning](http://en.wikipedia.org/wiki/Graph_partitioning)

A recommended book to dig more into these subjects is
[Networks, Crowds, and Markets: Reasoning About a Highly Connected
World](http://books.google.com/books?id=atfCl2agdi8C&lpg=PP1&dq=networks%20crowds%20and%20markets&pg=PP1#v=onepage&q=networks%20crowds%20and%20markets&f=false).

I'm pretty sure this talk also mentioned the
[NoSQL distilled book](http://books.google.com/books?id=AyY1a6-k3PIC&lpg=PA1&dq=NoSQL%20distilled&pg=PT11#v=onepage&q=NoSQL%20distilled&f=false)
as a good source of information regarding non relational databases.

#### A Digression on Graphs, Graph Databases and Graph Processing Systems

<div class="align_center" style="padding: 2em;">
  <img style="max-width: 85%;" src="/images/graphs.jpg" title="Graphs are everywhere!" alt="Graphs are Everywhere!" />
</div>

There's a distinction to be made between Graph Compute Engines (which
are generally used for running offline algorithms over massive amounts of
Nodes), and Graph Databases. These concepts are explained well in the
freely available [Graph Databases Book](http://graphdatabases.com/).

Arguably every big player in the web nowadays is using Graphs in one way
or another (a point stressed in Emil's keynote):

* Facebook has the [Open Graph](https://developers.facebook.com/docs/opengraph/).
* Yahoo's Marissa Mayer talked about the
[Interests Graph](https://www.youtube.com/watch?v=Zlru1trZ6MI),
although I still have to see what Yahoo is exactly doing to build this
Graph and make use of it.
* LinkedIn has the Connections Graph: there is a tool that allows
you to visualize your own personal
[connections](http://inmaps.linkedinlabs.com/network).
* Google's [Page Rank](http://en.wikipedia.org/wiki/Pagerank),
the company's corner stone algorithm which powers Search,
is based on Graph Theory (and so is
[Knowledge Graph](http://en.wikipedia.org/wiki/Knowledge_Graph)).

Google has also published the
[Pregel](http://googleresearch.blogspot.com/2009/06/large-scale-graph-computing-at-google.html)
paper describing a distributed graph processing system.
Some open source Graph Processing systems, like
[Apache Giraph](http://giraph.apache.org/),
have picked Pregel as the basis for their implementations, but Google
itself has not released an Open Source Graph Database or Graph
Processing Software package yet.
