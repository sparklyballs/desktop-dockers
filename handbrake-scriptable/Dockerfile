FROM hurricane/dockergui:xvnc

# set variables
# User/Group Id gui app will be executed as default are 99 and 100
ENV USER_ID=99 GROUP_ID=100 APP_NAME="HandBrake" WIDTH=1280 HEIGHT=720 TERM=xterm
# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Add local files
ADD src/ /

# startup file
RUN mkdir /etc/service/inotify && \
mv /inotify.sh /etc/service/inotify/run && \
chmod +x /etc/service/inotify/run && \
mv /copy-script.sh /etc/my_init.d/copy-script.sh && \
chmod +x /etc/my_init.d/copy-script.sh && \

# repositories
echo 'deb http://archive.ubuntu.com/ubuntu trusty main universe restricted' > /etc/apt/sources.list && \
echo 'deb http://archive.ubuntu.com/ubuntu trusty-updates main universe restricted' >> /etc/apt/sources.list && \
add-apt-repository ppa:stebbins/handbrake-releases && \

# update apt and install dependencies
mv /excludes /etc/dpkg/dpkg.cfg.d/excludes && \
apt-get update && \
apt-get install -qy \
handbrake-gtk \
handbrake-cli \
gnome-themes-standard \ 
inotify-tools && \

# clean up
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
/usr/share/man /usr/share/groff /usr/share/info \
/usr/share/lintian /usr/share/linda /var/cache/man && \
(( find /usr/share/doc -depth -type f ! -name copyright|xargs rm || true )) && \
(( find /usr/share/doc -empty|xargs rmdir || true ))
