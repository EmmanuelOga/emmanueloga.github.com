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

Since it is unlikely Gmail will ever include a feature to automate such
specific workflow, I decided to give Google's
[AppScript](https://developers.google.com/apps-script/) a try.

Check it out: [the script I wrote to automate this task](https://script.google.com/d/12ONoFC4Cg05GQI1Q1Y8G50AfWk3wvdmkanTryZ6KndbAdt_l7GGYWqBZ/edit?usp=sharing).

Here's how the resulting Script looks like (you need to be logged into
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

<div style="color: red; border: 2px dashed red; padding: 5px; margin: 5px;">
The standard <strong>disclaimer</strong> applies: <strong>the script
will erase your email! Normally it should only move emails from the
hosts you select to your Trash folder, but use it at your own
risk!</strong>
</div>

Developing this script was fun but I found a few caveats because I was
lazy and decided not to use the UI components and do the UI using
[html services](https://developers.google.com/apps-script/execution_web_apps) instead of the
[ui services](https://developers.google.com/apps-script/guides/ui-service).

AppScript uses [caja](https://code.google.com/p/google-caja/) under the
hood, so a lot of things are not allowed (e.g.: it did not allow me to
add pictures, like a loading gif, or svg, to the page).

All in all it was a fun experience and I think AppScript is definitely a
very useful tool to have in your toolbox if you use Google products like
Gmail or Spreadsheets.
