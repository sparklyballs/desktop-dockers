#!/bin/bash
chown -R nobody:users /script
if [ -f "/convert.sh" ]; then
echo "using existing script, may require editing"
chown -R nobody:users /script
else
cp /convert.sh /script/convert.sh
chown -R nobody:users /script
fi
