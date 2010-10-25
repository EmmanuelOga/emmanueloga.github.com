#!/bin/sh

while true; do
  inotifywait -e modify -r . && compass compile && jekyll
done
