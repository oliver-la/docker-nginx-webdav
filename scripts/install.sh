#!/bin/bash

##
# Instructions to be executed on container start
##

# Fix possible permission errors
chown -R www-data:www-data /var/webdav
chmod -R 777 /var/webdav

# Change default port
PORT=${PORT:-5000}
sed -i "s/listen 80 default_server/listen $PORT default_server/" /etc/nginx/sites-enabled/default

# Create authentication file
echo "$USERNAME:SabreDAV:$(php -r "echo md5('$USERNAME:SabreDAV:$PASSWORD');")" >> .htdigest
