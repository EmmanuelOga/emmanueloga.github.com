---
layout: post
title: Fun with Google's Apps Script! Batch Processing Gmail emails By Host
date: 28 March 2014
---

Like everybody that has had the same email acount for a while, I receive
a lot of emails. Most of them are automatic responses or update from
sites like twitter.com, linkedin.com, facebook.com, plus.google.com,
etc.. Others are mailing lists I signed up for and lost interest
in, and so on.

Sometimes I get tired of the amount of emails to manage, and  I just
want to tell Gmail: "delete all emails coming from *host.com*", for any
number of hosts.

My email managemenet workflow goes something like this:

1. Locate by visual inspection a host I want to delete or archive
2. Search "from:host", mark all emails for deletion
3. Delete all marked emails
4. Repeat for as many hosts as needed.

Since it is unlikely Gmail will ever include a feature to automate such
specific workflow, I decided to give Google's
[Apps Script](https://developers.google.com/apps-script/) a try (not to
confuse with [AppleScript](http://en.wikipedia.org/wiki/AppleScript) :p).

I got tired of doing this by hand and I wrote [a script to automate this task](https://script.google.com/d/12ONoFC4Cg05GQI1Q1Y8G50AfWk3wvdmkanTryZ6KndbAdt_l7GGYWqBZ/edit?usp=sharing).

Here's how the resulting Apps Script looks like (you need to be logged into
Gmail for it to work).

<div class="align_center" style="padding: 2em; border: 1px solid #ccc;">
  <a href="https://chrome.google.com/webstore/detail/gmail-sweeper/iabmkioocehcfbobkdchdmmidnjjipdn">
    <img style="max-width: 85%;" src="/images/gmail-sweeper.png" title="Gmail Sweeper" alt="Gmail Sweeper Screenshot" />
  </a>
</div>

<br/>
<br/>

The script is also able to archive emails coming from a certain host,
and/or mark them as important.

<p style="color: red; border: 2px dashed red; padding: 5px; margin: 5px;">

The standard <strong>disclaimer</strong> applies: <strong>this script
will erase some of your emails! Normally it should only move emails from
the hosts you select to your Trash folder, but use it at your own
risk!</strong>
</p>

<br/>
<br/>

Developing this script was fun but I found a few caveats because I was
lazy and decided not to use the [ui services](https://developers.google.com/apps-script/guides/ui-service).
Instead, I used the [html services](https://developers.google.com/apps-script/execution_web_apps).

Apps Script uses [caja](https://code.google.com/p/google-caja/) under the
hood, so a lot of things are not allowed (e.g.: it did not allow me to
add pictures, like a loading gif, or svg, to the page).

All in all it was a fun experience and I think AppScript is definitely a
very useful tool to have in your toolbox if you use Google products like
Gmail or Spreadsheets.
