---
layout: post
title: Downloading and unzipping a file with ruby
date: 21 June 2011
---
Quick! I need to download a zip file from an HTTP server and unzip it!
That's surely trivial with ruby... is it? *Yes, it is*. But! Turns out
there are a bunch of zip handling gems out there, and I had to try a
a couple before arriving to my final solution.

First, let's download the file. This particular resource is served via
an HTTP POST method. Yeah, unusual for a zip file.

{% highlight ruby %}
  require 'net/http'

  url = "http://someweirdserver.com/a-zip-served-via-POST.zip"
  data = { "some-bizarre-params" => "which-are-needed" }

  zipbytes = Net::HTTP.post_form(URI.parse(url), data).body
{% endhighlight %}

Done. Moving forward, let's unzip the file. One detail to bear in mind,
I have the zip file as a buffer (a String instance), and I don't want
to go trough a tempfile to unzip it. The good news is that the
[zipruby](http://zipruby.rubyforge.org/) gem can work off buffers.

{% highlight ruby %}
  require 'zipruby'

  Zip::Archive.open_buffer(zipbytes) do |zf|
    # this is a single file archive, so read the first file
    zf.fopen(zf.get_name(0)) do |f|
      unzipped = f.read
      # done! do something with the unzipped file.
    end
  end
{% endhighlight %}
