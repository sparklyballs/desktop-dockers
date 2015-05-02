FROM phusion/baseimage:0.9.16
MAINTAINER sparklyballs <sparkly@madeupemail.com>

# Set correct environment variables
ENV DEBIAN_FRONTEND=noninteractive HOME="/root" TERM=xterm LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

# set ports
EXPOSE 8080 3389

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Add required files that are local
ADD src/ /root/

# set config volume
VOLUME /config

# Set the locale
RUN locale-gen en_US.UTF-8 && \

# Configure user nobody to match unRAID's settings
usermod -u 99 nobody && \
usermod -g 100 nobody && \
usermod -m -d /nobody nobody && \
usermod -s /bin/bash nobody && \
usermod -a -G adm,sudo nobody && \
echo "nobody:PASSWD" | chpasswd && \

# folders for user nobody
mkdir /nobody && \
mkdir -p /nobody/.config/openbox && \
mkdir /nobody/.cache && \

# update apt and install dependencies
echo 'deb mirror://mirrors.ubuntu.com/mirrors.txt trusty main universe restricted' > /etc/apt/sources.list && \
echo 'deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-updates main universe restricted' >> /etc/apt/sources.list && \
add-apt-repository ppa:no1wantdthisname/openjdk-fontfix && \
add-apt-repository ppa:stebbins/handbrake-releases && \
apt-get update -qq && \
apt-get install -qy --force-yes --no-install-recommends \
wget \
unzip \
vnc4server \
x11-xserver-utils \
openbox xfonts-base \
xfonts-100dpi \
xfonts-75dpi \
libfuse2 xrdp \
openjdk-7-jre \
libossp-uuid-dev \
libpng12-dev \
libfreerdp-dev \
libcairo2-dev \
tomcat7 && \

apt-get install -qy gnome-themes-standard handbrake-gtk && \

# fix startup files etc....
mv /root/00_config.sh /etc/my_init.d/00_config.sh && \
mv /root/service/* /etc/service/ && \
rm -rf /root/service && \
chmod -R +x /etc/service/ /etc/my_init.d/ /etc/xrdp/startwm.sh && \

# fix up config files etc....
mv /root/xrdp.ini /etc/xrdp/xrdp.ini && \
mv /root/sesman.ini /etc/xrdp/sesman.ini && \
mkdir -p /etc/guacamole && \
mv /root/guacamole.properties /etc/guacamole/guacamole.properties && \
mv /root/noauth-config.xml /etc/guacamole/noauth-config.xml && \
mv  /root/rc.xml /nobody/.config/openbox/rc.xml && \
mv /root/autostart /nobody/.config/openbox/autostart && \
chown nobody:users /nobody/.config/openbox/rc.xml && \
chown -R nobody:users /config /nobody /usr/bin/ghb && \

# install tomcat and guacamole
mkdir -p /var/cache/tomcat7 && \
mkdir -p /var/lib/guacamole/classpath && \
mkdir -p /usr/share/tomcat7/.guacamole && \
mkdir -p /usr/share/tomcat7-root/.guacamole && \
mkdir -p /root/.guacamole && \
dpkg -i /root/guacamole/guacamole-server_0.9.6_amd64.deb && \
ldconfig && \
cp /root/guacamole/guacamole-0.9.6.war /var/lib/tomcat7/webapps/guacamole.war && \
cp /root/guacamole/guacamole-auth-noauth-0.9.6.jar /var/lib/guacamole/classpath && \
rm -rf root/guacamole && \
ln -s /etc/guacamole/guacamole.properties /usr/share/tomcat7/.guacamole/ && \
ln -s /etc/guacamole/guacamole.properties /usr/share/tomcat7-root/.guacamole/ && \
ln -s /etc/guacamole/guacamole.properties /root/.guacamole/ && \
rm -Rf /var/lib/tomcat7/webapps/ROOT && \
ln -s /var/lib/tomcat7/webapps/guacamole.war /var/lib/tomcat7/webapps/ROOT.war && \
ln -s /usr/local/lib/freerdp/guacsnd.so /usr/lib/x86_64-linux-gnu/freerdp/ && \ 
ln -s /usr/local/lib/freerdp/guacdr.so /usr/lib/x86_64-linux-gnu/freerdp/ && \


# clean up
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
/usr/share/man /usr/share/groff /usr/share/info \
/usr/share/lintian /usr/share/linda /var/cache/man && \
(( find /usr/share/doc -depth -type f ! -name copyright|xargs rm || true )) && \
(( find /usr/share/doc -empty|xargs rmdir || true ))
