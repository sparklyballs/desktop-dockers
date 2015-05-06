#!/bin/sh
while inotifywait -r -e create /watch-folder; do
/bin/bash /nobody/.config/ghb/Convert-Script/convert.sh
echo "Converting file(s)"
done
