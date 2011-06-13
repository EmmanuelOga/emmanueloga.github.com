---
layout: post
title: Lua's multiple arguments and the "select" function
date: 09 December 2010
---
When I first read about lua's select function I found it a little
confusing.

According to [lua's manual for version 5.1](http://www.lua.org/manual/5.1/manual.html#pdf-select),
select behaves as follows:

{% highlight lua %}
select (index, ···)
{% endhighlight %}

<pre>
If index is a number, returns all arguments after argument number
index.  Otherwise, index must be the string "#", and select returns
the total number of extra arguments it received.
</pre>

That wasn't clear to me at first, but then I remembered lua sports
_real_ multiple arguments. I remark the word _real_ because other
languages like ruby don't really support returning multiple arguments.
In ruby, if a method returns multiple arguments they are automatically
packed into an array. Lua, in the other hand, has built in multiple
arguments, which you can convert into a table if you really need to:

{% highlight lua %}
function multiple_args(...)
  local arguments = {...}  -- pack the arguments in a table
  -- do something --
  return unpack(arguments) -- return multiple arguments from a table (unpack)
end
{% endhighlight %}

Remembering the nature of lua's multiple arguments, and the fact that
multiple arguments are not returned on a lua table dressed as an array,
the description on the manual started to make sense.

The select function takes as "index" the index of the first argument
that you want to retrieve, and any number of arguments afterward (the
count of arguments starts at 1).

{% highlight lua %}
print(select(1, 1, 2, 3)) --> 1, 2, 3
print(select(2, 1, 2, 3)) --> 2, 3
print(select(3, 1, 2, 3)) --> 3
print(select(4, 1, 2, 3)) --> NOTHING

print(select(1, {1, 2, 3})) --> table
print(select(2, {1, 2, 3})) --> nothing
{% endhighlight %}

In the last two examples, the number of variable arguments is just one,
consisting of a single table.

By the way, note another subtlety of lua: if you select more that the
number of arguments available you get *absolutely nothing!*. Not even
nil: nothing. If you try to pack NOTHING into a table, you get an empty
table:

{% highlight lua %}
print(#{(function()end)()}) --> 0
{% endhighlight %}

Finally, if you pass "#" as index, the function returns a count of the
multiple arguments provided:

{% highlight lua %}
print(select("#")) --> 0
print(select("#", {1, 2, 3})) --> 1 (single table as argument)
print(select("#", 1, 2, 3)) --> 3
print(select("#", {1,2,3}, 4, 5, {6,7,8}) --> 4 (a table, 2 numbers, another table)
{% endhighlight %}
