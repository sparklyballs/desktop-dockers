#!/bin/bash

while inotifywait --monitor -e moved_to -e create /watch-folder; do
/bin/bash /script/convert.sh
done

