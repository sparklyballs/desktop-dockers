FROM hurricane/dockergui:xvnc

# set variables
# User/Group Id gui app will be executed as default are 99 and 100
ENV USER_ID=99 GROUP_ID=100 APP_NAME="HandBrake" WIDTH=1280 HEIGHT=720 TERM=xterm
# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Add local files
ADD src/ /

# startup file. Use coppit's monitoring script from the inotify-command container. Revision-lock to a specific version
# to avoid any surprises.
RUN wget -O /runas.sh \
  'https://raw.githubusercontent.com/coppit/docker-inotify-command/d0b25a4ed40582f5e2d21282c32c58164495c07b/runas.sh' && \
chmod +x /runas.sh && \
wget -O /monitor.py \
  'https://raw.githubusercontent.com/coppit/docker-inotify-command/1401a636bbc9369141d0d32ac7b80c2bf7fcdbcb/monitor.py' && \
sed -i 's/^RUNAS.*/RUNAS = "\/runas.sh"/' /monitor.py && \
chmod +x /monitor.py && \
mkdir /etc/service/inotify && \
mv /inotify.sh /etc/service/inotify/run && \
chmod +x /etc/service/inotify/run && \
mv /copy-script.sh /etc/my_init.d/copy-script.sh && \
chmod +x /etc/my_init.d/copy-script.sh && \

# repositories
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
python3-setuptools && \

# install watchdog module for Python3
easy_install3 watchdog && \

# clean up
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
/usr/share/man /usr/share/groff /usr/share/info \
/usr/share/lintian /usr/share/linda /var/cache/man && \
(( find /usr/share/doc -depth -type f ! -name copyright|xargs rm || true )) && \
(( find /usr/share/doc -empty|xargs rmdir || true ))

VOLUME ["/Watch", "/Output", "/nobody/.config/ghb"]
