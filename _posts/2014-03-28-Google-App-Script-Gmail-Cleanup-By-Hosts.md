---
layout: post
title: Fun with Google's AppScript! Cleaning up Gmail emails by host
date: 28 March 2014
---

I have had three Gmail accounts for a while now. Some times I stop
reading one of my two personal accounts for a while and when I come
back, I need to deal with the mess of emails.

I've always wanted a feature in Gmail to automate this manual workflow:

1. Locate by visual inspection a host to delete
2. Search "from:host", mark all emails for deletion
3. Delete all marked emails
4. Repeat for as many hosts as needed.

Since it is unlikely Gmail will ever include such specific feature, I
decided to give Google's
[AppScript](https://developers.google.com/apps-script/) a try.

You can [check the sources (and run the script!) here](https://script.google.com/d/12ONoFC4Cg05GQI1Q1Y8G50AfWk3wvdmkanTryZ6KndbAdt_l7GGYWqBZ/edit?usp=sharing).

Here's how the resulting Script looks like:

<div class="align_center" style="padding: 2em;">
  <img style="max-width: 85%;" src="/images/gmail-sweeper.png" title="Gmail Sweeper" alt="Gmail Sweeper Screenshot" />
</div>

The script is also able to archive emails coming from a certain host,
and/or mark them as important.

The standard <strong>disclaimer</strong> applies: <strong>the script
will erase your email! Normally it should only move emails from the
hosts you select to your Trash folder, but use it at your own
risk!</strong>
