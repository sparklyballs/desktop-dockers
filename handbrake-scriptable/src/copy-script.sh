#!/bin/bash
chown -R nobody:users /script
if [ -f "/script/convert.sh" ]; then
echo "using existing script, may require editing"
chown -R nobody:users /script
else
cp /convert.sh /script/convert.sh
chown -R nobody:users /script
fi
