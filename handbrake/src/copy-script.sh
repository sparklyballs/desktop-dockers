#!/bin/bash
mkdir -p /nobody/.config/ghb/Convert-Script
chown -R nobody:users /nobody/.config/ghb
if [ -f "/nobody/.config/ghb/Convert-Script/convert.sh" ]; then
echo "using existing script, may require editing"
chown -R nobody:users /nobody/.config/ghb
chmod +x /nobody/.config/ghb/Convert-Script/convert.sh
else
cp /convert.sh /nobody/.config/ghb/Convert-Script/convert.sh
chmod +x /nobody/.config/ghb/Convert-Script/convert.sh
chown -R nobody:users /nobody/.config/ghb
fi
