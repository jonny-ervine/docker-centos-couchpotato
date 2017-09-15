# docker-centos-couchpotato
## CouchPotato running on CentOS (7.4)
### Build Version: 1
Date of Build: 15th September 2017

The Dockerfile should intialise the CentOS image and subscribe to the EPEL repository. The pre-requisites for CouchPotato are then installed via yum.

The EPEL repository provides:

    supervisor

The CouchPotato daemon is controlled via the supervisord daemon which has a web front end exposed via port 9004. Default username and password for the web front end is admin:admin.

The CouchPotatoServer software is pulled from the github source into the docker container ready for use.

The container can be run as follows:

    docker pull jervine/docker-centos-couchpotato
    docker run -d -n <optional name of container> -h <optional host name of container> -e USER="<user account to run as> -e USERUID="<uid of user account"> -e TZ="<optional timezone> -v /<config directory on host>:/config/couchpotato -v /<download directory on host>:/downloads -p 5050:5050 -p 9004:9004 jervine/docker-centos-couchpotato

The USER and UID variables will be used to create an unprivileged account in the container to run the CouchPotatoServer under. The startup.sh script will create this user and also inject the username into the user= parameter of the couchpotato.ini supervisor file.

The TZ variable allows the user to set the correct timezone for the container and should take the form "Europe/London". If no timezone is specified then UTC is used by default. The timezone is set up when the container is run. Subsequent stops and starts will not change the timezone.

The container can be verified on the host by using:

    docker logs <container id/container name>
and/or:

    cat /<config directory on host>/logs/couchpotato.log

Please note that the SELinux permissions of the config and downloads directories may need to be changed/corrected as necessary. [Currently chcon -Rt svirt_sandbox_file_t <directory>]
