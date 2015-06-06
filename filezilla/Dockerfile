FROM hurricane/dockergui:x11rdp1.2

# set variables
# User/Group Id gui app will be executed as default are 99 and 100
ENV USER_ID=99 GROUP_ID=100 APP_NAME="FileZilla" WIDTH=1280 HEIGHT=720 TERM=xterm

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Add local files
ADD src/ /

# repositories
RUN echo 'deb http://archive.ubuntu.com/ubuntu trusty main universe restricted' > /etc/apt/sources.list && \
echo 'deb http://archive.ubuntu.com/ubuntu trusty-updates main universe restricted' >> /etc/apt/sources.list && \
add-apt-repository ppa:ubuntu-toolchain-r/test

# install dependencies
apt-get update && \ 
apt-get install \
libnotify.bin \
libstdc++6 \
gnome-themes-standard -y && \
cd /tmp && \
wget http://downloads.sourceforge.net/project/filezilla/FileZilla_Client/3.11.0.1/FileZilla_3.11.0.1_x86_64-linux-gnu.tar.bz2 && \
tar -xvf FileZilla_3.11.0.1_x86_64-linux-gnu.tar.bz2 && \
mv FileZilla3 /nobody && \
chown -R nobody:users /nobody && \

# clean up
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
/usr/share/man /usr/share/groff /usr/share/info \
/usr/share/lintian /usr/share/linda /var/cache/man && \
(( find /usr/share/doc -depth -type f ! -name copyright|xargs rm || true )) && \
(( find /usr/share/doc -empty|xargs rmdir || true ))

