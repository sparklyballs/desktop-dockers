#!/bin/sh
while inotifywait -r -e create /watch-folder; do
/bin/bash /script/convert.sh
echo "Converting file(s)"
done
