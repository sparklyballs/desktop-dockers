#!/bin/bash

if [[ $(cat /etc/timezone) != $TZ ]] ; then
  echo "$TZ" > /etc/timezone
  dpkg-reconfigure -f noninteractive tzdata
fi

mkdir -p /home/ubuntu/unraid

if [ -d "/home/ubuntu/unraid/wallpapers" ]; then
echo "using existing wallpapers etc..."
else
mkdir -p /home/ubuntu/unraid/wallpapers
cp /root/wallpapers/* /home/ubuntu/unraid/wallpapers/
fi


mkdir  /var/run/sshd
mkdir  /root/.vnc
/usr/bin/supervisord -c /root/supervisord.conf
while [ 1 ]; do
/bin/bash
done
