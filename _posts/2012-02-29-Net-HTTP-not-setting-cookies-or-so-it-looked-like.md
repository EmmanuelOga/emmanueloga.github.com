---
layout: post
title: Net::HTTP not setting cookies... or so it looked like
date: 29 February 2012
---

I was retrieving a web page from a site, but I found out it needed a cookie to
be set in order to work. Otherwise, it was redirecting me to set up my language
of preference. I thought no problem... let's set up that cookie.

{% highlight ruby %}
require 'net/http'

url = "http://www.realtor.com/realestateandhomes-detail/3429-W-Lone-Mountain-Rd_North-Las-Vegas_NV_89031_M12163-28068"
uri = URI(url)
http = Net::HTTP.new(uri.host, 80)
request = Net::HTTP::Get.new(uri.request_uri)
request['Cookie'] = "preference=USA"
r = http.request(request)
{% endhighlight %}

Awesome! it worked! Sometimes...

After a bit of banging my head against the wall I decided to try with a
different version of ruby, 1.9.3.

Locally I was using ree-1.8.7-2011.12, and on the c.i. server ruby-1.8.7-p352.

So what was the difference? [Check it out](https://github.com/ruby/ruby/blob/v1_9_3_rc1/lib/net/http.rb#L1864).

Turns out 1.9.3 sets a default user agent. Even though it should be optional,
looks like some servers do not look at the cookies header if the user
agent is not set.

The takeaway: if you are setting cookies on your request, make sure the
user agent is being set too:

{% highlight ruby %}
request['User-Agent'] = 'MyCoolUserAgentString'
{% endhighlight %}
