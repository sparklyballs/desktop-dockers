FROM phusion/baseimage:0.9.16
ENV DEBIAN_FRONTEND noninteractive
# Set correct environment variables
ENV HOME /root
ENV TERM xterm
# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Add local files
ADD src/ /root/

# set workdir 
WORKDIR /

# Expose ports 
EXPOSE 6080
EXPOSE 5900
EXPOSE 3389

# set startup file
RUN mv /root/firstrun.sh /etc/my_init.d/firstrun.sh && \
chmod +x /etc/my_init.d/firstrun.sh && \

# update apt and install dependencies
mv /root/excludes /etc/dpkg/dpkg.cfg.d/excludes && \
apt-add-repository ppa:ubuntu-mate-dev/ppa && \
apt-add-repository ppa:ubuntu-mate-dev/trusty-mate && \
apt-get update && \
apt-get install -y --force-yes --no-install-recommends xdg-utils python wget openjdk-7-jre supervisor sudo nano net-tools mate-desktop-environment-core x11vnc xvfb gtk2-engines-murrine ttf-ubuntu-font-family  && \
apt-get install -y xrdp && \

# create ubuntu user
useradd --create-home --shell /bin/bash --user-group --groups adm,sudo ubuntu && \
echo "ubuntu:PASSWD" | chpasswd && \

# set user ubuntu to same uid and guid as nobody:users in unraid
usermod -u 99 ubuntu && \
usermod -g 100 ubuntu && \

# fetch and install calibre to /home/ubuntu
wget --no-check-certificate -nv -O- https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py | python -c "import sys; main=lambda x,y:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main('/home/ubuntu/', True)" && \


# swap in modified xrdp.ini
mv /etc/xrdp/xrdp.ini /etc/xrdp/xrdp.original && \
mv /root/xrdp.ini /etc/xrdp/xrdp.ini && \
chown root:root /etc/xrdp/xrdp.ini && \

# clean up
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
/usr/share/man /usr/share/groff /usr/share/info \
/usr/share/lintian /usr/share/linda /var/cache/man && \
(( find /usr/share/doc -depth -type f ! -name copyright|xargs rm || true )) && \
(( find /usr/share/doc -empty|xargs rmdir || true ))
