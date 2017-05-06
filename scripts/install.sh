#!/bin/bash

##
# Instructions to be executed on container start
##

# Fix possible permission errors
chown -R www-data:www-data /var/webdav
chmod -R 777 /var/webdav

# Create authentication file
echo "$WEBDAV_USERNAME:SabreDAV:$(php -r "echo md5('$WEBDAV_USERNAME:SabreDAV:$WEBDAV_PASSWORD');")" >> .htdigest
