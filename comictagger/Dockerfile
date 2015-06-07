FROM hurricane/dockergui:xvnc

# set variables
# User/Group Id gui app will be executed as default are 99 and 100
ENV USER_ID=99 GROUP_ID=100 APP_NAME="ComicTagger" WIDTH=1280 HEIGHT=720 TERM=xterm

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Add local files
ADD src/ /

# add repositories, update apt and install dependencies
RUN add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ trusty universe multiverse" && \
add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ trusty-updates universe multiverse" && \
apt-get update -qq && \
apt-get install \
python \
python-dev \
python-pip \
python-qt4 \
libtiff5-dev \
libjpeg8-dev \
zlib1g-dev \
libfreetype6-dev \
liblcms2-dev \
libwebp-dev \
tcl8.6-dev \
tk8.6-dev \
python-tk \
cmake \
unzip \
unrar \
rar \
zip \
python-bs4 -y && \

# build openjpeg2 support for pillow
cd /tmp && \
wget http://downloads.sourceforge.net/project/openjpeg.mirror/2.0.1/openjpeg-2.0.1.tar.gz && \
tar xzvf openjpeg-2.0.1.tar.gz && \
cd openjpeg-2.0.1/ && \
cmake . && \
make && \
make install && \

# install pip packages
pip install pillow configparser && \
pip install --pre --allow-external comictagger --allow-unverified comictagger comictagger && \

# set additional config files
mv /000-add-in-config.sh /etc/my_init.d/000-add-in-config.sh && \
chmod +x /etc/my_init.d/000-add-in-config.sh && \

# clean up
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 
