#!/bin/sh
while inotifywait -r -e create /nobody/.config/ghb/Watch-Folder; do
/bin/bash /nobody/.config/ghb/Convert-Script/convert.sh
echo "Converting file(s)"
done
