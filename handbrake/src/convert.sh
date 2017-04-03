#!/bin/bash

########### EDITABLE VARIABLES ##########

DEST_EXT=mp4
PRESET=Ipad

#########################################



##### DO NOT CHANGE ANYTHING BELOW HERE ###############

SRC=/Watch
DEST=/Output
HANDBRAKE_CLI=HandBrakeCLI



IFS=$(echo -en "\n\b")
for FILE in `ls $SRC`
do
        filename=$(basename $FILE)
        extension=${filename##*.}
        filename=${filename%.*}

        $HANDBRAKE_CLI -i $SRC/$FILE -o $DEST/$filename.$DEST_EXT --preset $PRESET

chown nobody:users $DEST/$filename.$DEST_EXT

done
