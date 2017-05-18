# Base on latest CentOS image
FROM centos:latest

MAINTAINER “Jonathan Ervine” <jon.ervine@gmail.com>
ENV container docker

# Install updates, and pre-requisites for CouchPotato
RUN yum update -y; yum clean all
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install -y unzip supervisor git
RUN yum clean all

# Download and extract the latest SickRage release
RUN git clone https://github.com/CouchPotatoServer/CouchPotatoServer.git

ADD supervisord.conf /etc/supervisord.conf
ADD couchpotato.ini /etc/supervisord.d/couchpotato.ini
ADD start.sh /usr/sbin/start.sh
RUN chmod 755 /usr/sbin/start.sh

VOLUME /config
VOLUME /data
VOLUME /downloads

EXPOSE 5050 9004
ENTRYPOINT ["/usr/sbin/start.sh"]
