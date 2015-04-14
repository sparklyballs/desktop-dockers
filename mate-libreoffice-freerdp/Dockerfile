# set base os
FROM phusion/baseimage:0.9.16


# Set correct environment variables
ENV DEBIAN_FRONTEND=noninteractive HOME="/root" TERM=xterm
CMD ["/sbin/my_init"]

# add local files
ADD src/ /root/

# update apt and install build dependencies
RUN add-apt-repository ppa:freerdp-team/freerdp && \
mv /root/freerdp-team-freerdp-trusty.list /etc/apt/sources.list.d/ && \
apt-add-repository ppa:ubuntu-mate-dev/ppa && \
apt-add-repository ppa:ubuntu-mate-dev/trusty-mate && \
mv /root/excludes /etc/dpkg/dpkg.cfg.d/excludes && \
apt-get update && \
apt-get install -y freerdp wget openjdk-7-jre supervisor sudo nano net-tools  x11vnc xvfb mate-desktop-environment-core libreoffice && \

# create ubuntu user
useradd --create-home --shell /bin/bash --user-group --groups adm,sudo ubuntu && \
echo "ubuntu:PASSWD" | chpasswd && \

# set user ubuntu to same uid and guid as nobody:users in unraid
usermod -u 99 ubuntu && \
usermod -g 100 ubuntu && \

# clean up
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
/usr/share/man /usr/share/groff /usr/share/info \
/usr/share/lintian /usr/share/linda /var/cache/man && \
(( find /usr/share/doc -depth -type f ! -name copyright|xargs rm || true )) && \
(( find /usr/share/doc -empty|xargs rmdir || true ))
