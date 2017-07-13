FROM hurricane/dockergui:xvnc

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
add-apt-repository ppa:ubuntu-toolchain-r/test && \

# install dependencies
apt-get update && \ 
apt-get install \
libnotify.bin \
libstdc++6 \
gnome-themes-standard -y && \
mkdir -p /nobody/FileZilla3 && \
curl -o /tmp/filezilla.tar.bz2 -L https://sourceforge.net/projects/filezilla/files/FileZilla_Client/3.26.2/FileZilla_3.26.2_x86_64-linux-gnu.tar.bz2 && \
tar xvf /tmp/filezilla.tar.bz2  -C /nobody/FileZilla3 --strip-components=1 && \
chown -R nobody:users /nobody && \

# clean up
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
/usr/share/man /usr/share/groff /usr/share/info \
/usr/share/lintian /usr/share/linda /var/cache/man && \
(( find /usr/share/doc -depth -type f ! -name copyright|xargs rm || true )) && \
(( find /usr/share/doc -empty|xargs rmdir || true ))

