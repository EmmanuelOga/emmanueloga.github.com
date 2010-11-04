#!/bin/sh

compass compile && jekyll

while true; do
  inotifywait -e modify -r . && compass compile && jekyll
done
