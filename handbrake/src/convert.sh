#!/bin/bash

########### EDITABLE VARIABLES ##########

DEST_EXT=mp4
PRESET=Ipad

#########################################



##### DO NOT CHANGE ANYTHING BELOW HERE ###############

SRC=/nobody/.config/ghb/Watch-Folder
DEST=/Output
HANDBRAKE_CLI=HandBrakeCLI
FILE_LIST=/nobody/.config/ghb/processed_files.dat



IFS=$(echo -en "\n\b")
for FILE in `ls $SRC`
do
        # Hash the file details for some privacy. Also hash the inode number, since sometimes people will want to
        # re-encode the same file by placing it back in the dir.
        file_hash=$(stat -c '%i %s %n' "$FILE" | md5sum | awk '{print $1}')

        if grep -q "$file_hash" "$FILE_LIST"; then continue; fi

        filename=$(basename $FILE)
        extension=${filename##*.}
        filename=${filename%.*}

        $HANDBRAKE_CLI -i $SRC/$FILE -o $DEST/$filename.$DEST_EXT --preset $PRESET

chown nobody:users $DEST/$filename.$DEST_EXT

        # Should we only remember the hash for the file if handbrake succeeded? If we do that, we'll keep trying to
        # convert the same file over and over. This way is simpler. If they want to re-encode, rename the file, or move
        # it out and back into the watch folder.
        echo $file_hash >> $FILE_LIST
done
