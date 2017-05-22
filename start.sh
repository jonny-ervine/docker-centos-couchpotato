#!/bin/bash
##
## Start up script for CouchPotato on CentOS docker container
##

## Initialise any variables being called:
# Set the correct timezone
TZ=${TZ:-UTC}
USER=$USER
USER-UID=$USER-UID
setup=/config/.setup

if [ ! -f "${setup}" ]; then
  rm -f /etc/localtime
  cp /usr/share/zoneinfo/$TZ /etc/localtime
  adduser -u $USER-UID $USER
  sed -i "s/user=/user=$USER/g" /etc/supervisord.d/couchpotato.ini
  touch $setup
fi

## Start up CouchPotato daemon via supervisord
/usr/bin/supervisord -n -c /etc/supervisord.conf
