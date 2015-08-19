#!/bin/sh
while inotifywait -r -e create,moved_to /nobody/.config/ghb/Watch-Folder; do
/bin/bash /nobody/.config/ghb/Convert-Script/convert.sh
echo "Converting file(s)"
done
