class String
  def dasherize
    word = dup
    word.gsub!(/[^a-zA-Z0-9]/, "-")
    word.squeeze!("-")
    word.chomp!("-")
    word
  end
end

desc "create a new post with today's date."
task :new do
  print "Type title: "
  title = gets.chomp
  now = Time.now
  new_path = now.strftime("_posts/%Y-%m-%d-#{title.dasherize}.md")

  if File.file?(new_path)
    puts "The post already exists"
    exit
  end

  File.open(new_path, "w+") do |f|
    f << <<-POST
---
layout: post
title: #{title}
date: #{now.strftime("%d %B %Y")}
---
Have fun.
POST
  end

  exec "gvim #{new_path}"
end

task :default => :new
