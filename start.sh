#!/bin/bash
mkdir -p /var/www/htdocs
mkdir -p /var/www/logs
chown www-data.www-data /var/www/ -Rf
# start all the services
/usr/local/bin/supervisord -n
