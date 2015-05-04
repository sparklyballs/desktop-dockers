FROM hurricane/dockergui:xvnc

# set variables
# User/Group Id gui app will be executed as default are 99 and 100
ENV USER_ID=99 GROUP_ID=100 APP_NAME="PuddleTag" WIDTH=1420 HEIGHT=840 TERM=xterm

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Add local files
ADD src/ /

# fetch puddletag
RUN wget --directory-prefix=/tmp http://sourceforge.net/projects/puddletag/files/puddletag_1.0.5-1_all.deb && \

# update apt and install dependencies
apt-get update && \
apt-get install -qy \
python-support \
python-mutagen \
python-qt4 \
python-pyparsing \
python-configobj \
libchromaprint-tools \
gnome-themes-standard && \

# install puddletag
dpkg -i /tmp/puddletag_1.0.5-1_all.deb && \

# clean up
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
/usr/share/man /usr/share/groff /usr/share/info \
/usr/share/lintian /usr/share/linda /var/cache/man && \
(( find /usr/share/doc -depth -type f ! -name copyright|xargs rm || true )) && \
(( find /usr/share/doc -empty|xargs rmdir || true ))

