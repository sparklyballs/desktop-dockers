#!/bin/bash
chown -R nobody:users /script
if [ -f "/script/convert.sh" ]; then
echo "using existing script, may require editing"
chown -R nobody:users /script
chmod +x /script/convert.sh
else
cp /convert.sh /script/convert.sh
chmod +x /script/convert.sh
chown -R nobody:users /script
fi
