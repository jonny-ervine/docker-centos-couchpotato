# docker-centos-couchpotato
## CouchPotato running on the latest CentOS docker image (7.0)

The Dockerfile should intialise the CentOS image and subscribe to the EPEL repository. The pre-requisites for CouchPotato are then installed via yum.

The EPEL repository provides:

    supervisor

The CouchPotato daemon is controlled via the supervisord daemon which has a web front end exposed via port 9004. Default username and password for the web front end is admin:admin.

The SickRage software package is downloaded as a zip file from github and then extracted into the docker container ready for use.

The container can be run as follows:

    docker pull jervine/docker-centos-couchpotato
    docker run -d -n <optional name of container> -h <optional host name of container> -e TZ="<optional timezone> -v /<config directory on host>:/config/couchpotato -v /<download directory on host>:/downloads -p 505:5050 -p 9004:9004 jervine/docker-centos-couchpotato

THe TZ variable allows the user to set the correct timezone for the container and should take the form "Europe/London". If no timezone is specified then UTC is used by default. The timezone is set up when the container is run. Subsequent stops and starts will not change the timezone.

The container can be verified on the host by using:

    docker logs <container id/container name>
and/or:

    cat /<config directory on host>/logs/couchpotato.log

Please note that the SELinux permissions of the config and downloads directories may need to be changed/corrected as necessary.
