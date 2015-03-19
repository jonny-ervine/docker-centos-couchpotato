# Base on latest CentOS image
FROM centos:latest

MAINTAINER “Jonathan Ervine” <jon.ervine@gmail.com>
ENV container docker

# Install updates, and pre-requisites for CouchPotato
RUN yum update -y; yum clean all
RUN yum install -y http://mirror.pnl.gov/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
RUN yum install -y unzip supervisor
RUN yum clean all

# Download and extract the latest SickRage release
RUN curl -L https://github.com/RuudBurger/CouchPotatoServer/archive/master.zip -o /CouchPotatoServer.zip
RUN unzip /CouchPotatoServer.zip
RUN rm -f /CouchPotatoServer.zip

ADD supervisord.conf /etc/supervisord.conf
ADD couchpotato.ini /etc/supervisord.d/couchpotato.conf

VOLUME /config
VOLUME /data
VOLUME /downloads

EXPOSE 5050 9004
ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
