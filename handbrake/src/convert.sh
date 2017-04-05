#!/bin/bash

########### EDITABLE VARIABLES ##########

DEST_EXT=mp4
PRESET=Ipad

#########################################



##### DO NOT CHANGE ANYTHING BELOW HERE ###############

SRC=/nobody/.config/ghb/Watch-Folder
DEST=/Output
HANDBRAKE_CLI=HandBrakeCLI



IFS=$(echo -en "\n\b")
for FILE in `ls $SRC`
do
        filename=$(basename $FILE)
        extension=${filename##*.}
        filename=${filename%.*}

        $HANDBRAKE_CLI -i $SRC/$FILE -o $DEST/$filename.$DEST_EXT --preset $PRESET

        PID=$!
        # This might fail if the user has not provided --cap-add=CAP_SYS_NICE to the container. So ignore failures here.
        renice 19 $PID
        wait $PID

chown nobody:users $DEST/$filename.$DEST_EXT

done
