FROM hurricane/dockergui:xvnc

# set variables
# User/Group Id gui app will be executed as default are 99 and 100
ENV USER_ID=99 GROUP_ID=100 APP_NAME="ComicTagger" WIDTH=1280 HEIGHT=720 TERM=xterm

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Add local files
ADD src/ /

# update apt
RUN echo "deb http://ch.archive.ubuntu.com/ubuntu/ trusty main restricted" >> /etc/apt/sources.list && \
echo "deb-src http://ch.archive.ubuntu.com/ubuntu/ trusty main restricted" >> /etc/apt/sources.list && \
apt-get update -qq && \

# install PIL dependencies
apt-get build-dep python-imaging -y && \
apt-get install \ 
libjpeg62 \
libjpeg62-dev \
libfreetype6 \
libfreetype6-dev \
zlib1g-dev \
python-pip -y && \

# install PIL
ln -s /usr/lib/x86_64-linux-gnu/libz.so /usr/lib/libz.so && \
ln -s /usr/lib/x86_64-linux-gnu/libjpeg.so /usr/lib/libjpeg.so && \
pip install PIL --allow-external PIL --allow-unverified PIL && \


# install comictagger dependencies
add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ trusty universe multiverse" && \
add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ trusty-updates universe multiverse" && \
apt-get update -qq && \
apt-get install \
python-qt4 \
unzip \
unrar \
rar \
zip \
python-bs4 -y && \

# install remaining pip packages
pip install configparser && \
pip install --pre --allow-external comictagger --allow-unverified comictagger comictagger && \

# clean up
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 
