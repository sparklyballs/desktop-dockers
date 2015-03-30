#!/bin/bash

if [[ $(cat /etc/timezone) != $TZ ]] ; then
  echo "$TZ" > /etc/timezone
  dpkg-reconfigure -f noninteractive tzdata
fi

mkdir -p /home/ubuntu/unraid
mkdir -p /home/ubuntu/.config/libreoffice/4/user
mkdir -p /home/ubuntu/.config/pcmanfm/LXDE
if [ -d "/home/ubuntu/unraid/wallpapers" ]; then
echo "using existing wallpapers etc..."
else
mkdir -p /home/ubuntu/unraid/wallpapers
cp /root/wallpapers/* /home/ubuntu/unraid/wallpapers/
mv  /root/desktop-items-0.conf /home/ubuntu/.config/pcmanfm/LXDE/desktop-items-0.conf
chown ubuntu:users /home/ubuntu/.config/pcmanfm/LXDE/desktop-items-0.conf
chmod 644 /home/ubuntu/.config/pcmanfm/LXDE/desktop-items-0.conf
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
