#!/bin/bash

if [[ $(cat /etc/timezone) != $TZ ]] ; then
  echo "$TZ" > /etc/timezone
  dpkg-reconfigure -f noninteractive tzdata
fi

mkdir -p /home/ubuntu/unraid
mkdir -p /home/ubuntu/.config/libreoffice/4/user
if [ -d "/home/ubuntu/unraid/wallpapers" ]; then
echo "using existing wallpapers etc..."
else
mkdir -p /home/ubuntu/unraid/wallpapers
cp /root/wallpapers/* /home/ubuntu/unraid/wallpapers/
fi

if [ -f "/home/ubuntu/.config/libreoffice/4/user/registrymodifications.xcu" ]; then
echo "using existing libreoffice settings file"
else
cp /root/registrymodifications.xcu /home/ubuntu/.config/libreoffice/4/user/
chown -R ubuntu:users /home/ubuntu/
chmod -R 755 /home/ubuntu/.config/libreoffice
chmod 600 /home/ubuntu/.config/libreoffice/4/user/registrymodifications.xcu
fi

mkdir  /var/run/sshd
mkdir  /root/.vnc
/usr/bin/supervisord -c /root/supervisord.conf
while [ 1 ]; do
/bin/bash
done
