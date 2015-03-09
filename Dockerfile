# Base on latest CentOS image
FROM centos:latest

MAINTAINER “Jonathan Ervine” <jon.ervine@gmail.com>
ENV container docker

# Install updates, and pre-requisites for CouchPotato
RUN yum update -y; yum clean all
RUN yum install -y unzip

# Download and extract the latest SickRage release
RUN curl -L https://github.com/RuudBurger/CouchPotatoServer/archive/master.zip -o /CouchPotatoServer.zip
RUN unzip /CouchPotatoServer.zip
RUN rm -f /CouchPotatoServer.zip

VOLUME /config
VOLUME /data
VOLUME /downloads

EXPOSE 5050
ENTRYPOINT ["/CouchPotatoServer-master/CouchPotato.py", "--data_dir=/config"]
