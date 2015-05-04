FROM hurricane/dockergui:xvnc

# set variables
# User/Group Id gui app will be executed as default are 99 and 100
ENV USER_ID=99 GROUP_ID=100 APP_NAME="XnRetro" WIDTH=1420 HEIGHT=840 TERM=xterm LD_LIBRARY_PATH="/nobody/XnRetro/lib"

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Add local files
ADD src/ /

# set 32 bit arch
RUN dpkg --add-architecture i386 && \

# install XnRetro
cd /tmp && \
wget --directory-prefix=/tmp http://download.xnview.com/XnRetro-linux.tgz && \
cd /nobody && \
tar -xvf /tmp/XnRetro-linux.tgz && \
chown -R nobody:users /nobody && \

# repositories
mv /etc/apt/sources.list /root/sources.list && \
mv /apt-source /etc/apt/sources.list && \

# install 32 bit dependencies
apt-get update && \ 
apt-get install -y \
lib32gcc1 \
lib32stdc++6 libc6-i386 \
libfontconfig1:i386 \
libfreetype6:i386 \
libglib2.0-0:i386 \
libgstreamer-plugins-base0.10-0:i386 \
libgstreamer0.10-0:i386 \
libice6:i386 \
libjpeg62:i386 \
libpng12-0:i386 \
libqt4-svg:i386 \
libsm6:i386 \
libx11-6:i386 \
libxext6:i386 \
libxml2:i386 \
libxrender1:i386 \
zlib1g:i386 \
gnome-themes-standard && \

# clean up
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
/usr/share/man /usr/share/groff /usr/share/info \
/usr/share/lintian /usr/share/linda /var/cache/man && \
(( find /usr/share/doc -depth -type f ! -name copyright|xargs rm || true )) && \
(( find /usr/share/doc -empty|xargs rmdir || true ))


