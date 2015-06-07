#!/bin/bash
mkdir -p /nobody/.ComicTagger
if [ -f "/nobody/.ComicTagger/settings" ]; then
echo "settings file in place"
else
cp /root/settings /nobody/.ComicTagger/settings
fi
# sanitize COMICCODE for white space
SANEDCOMICCODE0=$COMICCODE
SANEDCOMICCODE1="${SANEDCOMICCODE0#"${SANEDCOMICCODE0%%[![:space:]]*}"}"
SANEDCOMICCODE="${SANEDCOMICCODE1%"${SANEDCOMICCODE1##*[![:space:]]}"}"
sed -i -e "s@cv_api_key.*@cv_api_key = ${SANEDCOMICCODE}@g" /nobody/.ComicTagger/settings
chown nobody:users /nobody/.ComicTagger/settings
