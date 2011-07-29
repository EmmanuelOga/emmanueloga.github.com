---
layout: post
title: "Beer Drinking Contest: Ruby versus Lua. Fight!"
date: 29 July 2011
---
Grab a [gist](https://gist.github.com/1113413). You probably already
know what's the [output](http://www.99-bottles-of-beer.net/lyrics.html) of these programs.

### Ruby

{% highlight ruby %}
class Crowd < Struct.new(:bottles)
  def drink()    puts("Take one down and pass it around."); bottles.drink(1); self;  end
  def buy_more() puts("Go to the store and buy some more."); bottles.buy(99); self; end
  def sing()     puts("#{bottles} on the wall, #{bottles}."); self; end
end

class Bottles < Struct.new(:qty)
  def drink(amount) self.qty -= amount; end
  def buy(amount)   self.qty += amount; end
  def to_s() qty == 0 ? "No more bottles of beer" : "#{qty} bottle#{'s' if qty > 1} of beer" end
end

Crowd.new(Bottles.new(99)).tap do |crowd|
  99.times { crowd.drink and crowd.sing }
  crowd.buy_more.sing
end
{% endhighlight %}

### Lua
{% highlight lua %}
local Crowd   = {}
Crowd.drink   = function(self) print("Take one down and pass it around.") self.bottles:drink(1) return self end
Crowd.buymore = function(self) print("Go to the store and buy some more.") self.bottles:buy(99) return self end
Crowd.sing    = function(self) print(tostring(self.bottles).." on the wall, "..tostring(self.bottles)..".") return self end

local Bottles      = {}
Bottles.__index    = Bottles
Bottles.drink      = function(self, amount) self.qty = self.qty - amount end
Bottles.buy        = function(self, amount) self.qty = self.qty + amount end
Bottles.__tostring = function(self)
  if self.qty == 0 then return "No more bottles of beer"
  else return self.qty.." bottle"..(self.qty == 0 and '' or 's').." of beer"
  end
end

local crowd = setmetatable({bottles = setmetatable({qty=99}, Bottles)}, {__index=Crowd})

crowd:sing() for i = 99, 1, -1 do crowd:drink():sing() end crowd:buymore():sing()
{% endhighlight %}

### Let the games begin!

{% highlight bash %}
#/usr/bin/env sh

echo 'Baseline echo'
time for i in {0..20..1}; do echo "A long line with a number: $i" > /dev/null ; done
# real	0m0.001s user	0m0.000s sys	0m0.000s

lua -v
time for i in {0..20..1}; do lua beer.lua > /dev/null ; done
# Lua 5.1.4  Copyright (C) 1994-2008 Lua.org, PUC-Rio
# real	0m0.054s user	0m0.000s sys	0m0.007s

luajit-2.0.0-beta6 -v
time for i in {0..20..1}; do luajit-2.0.0-beta6 beer.lua > /dev/null ; done
# LuaJIT 2.0.0-beta6 -- Copyright (C) 2005-2011 Mike Pall. http://luajit.org/
# real	0m0.041s user	0m0.000s sys	0m0.007s

rvm 1.9.2 exec ruby -v
time for i in {0..20..1}; do rvm 1.9.2 exec ruby beer.rb > /dev/null ; done
# ruby 1.9.2p180 (2011-02-18 revision 30909) [x86_64-linux]
# real	0m17.076s user	0m12.116s sys	0m3.323s

rvm jruby exec jruby -v
time for i in {0..20..1}; do rvm jruby exec jruby beer.rb > /dev/null ; done
# jruby 1.6.2 (ruby-1.8.7-p330) (2011-05-23 e2ea975) (OpenJDK 64-Bit Server VM 1.6.0_22) [linux-amd64-java]
# real	1m35.087s user	2m21.537s sys	0m7.226s

rvm ree ruby -v
time for i in {0..20..1}; do rvm ree exec ruby beer.rb > /dev/null ; done
# ruby 1.8.7 (2011-02-18 patchlevel 334) [x86_64-linux], MBARI 0x6770, Ruby Enterprise Edition 2011.03
# real	0m18.075s user	0m12.619s sys	0m3.526s
{% endhighlight %}

### Conclusions

* I don't give any chance to the jit capable interpreters to work their magic.
* I'm "measuring" the system's I/O too even when I'm directing the output to /dev/null, get over it.
* Lua, including its start-up time, is FAST!. Also, object oriented programming
  in lua is flexible, simple and nice.
* Rails does not scale.
* I want a beer.
