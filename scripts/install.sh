#!/bin/bash

###############################################################################
# This is an install script for my Docker WebDAV (based on nginx) approach.
# Author: Oliver Lazovic (https://www.xama.us)
###############################################################################

# Directories
mkdir /var/webdav
chmod -R 755 /var/webdav

# Working directory
cd /var/webdav

# SabreDAV Directories
mkdir data
mkdir public
touch .htdigest
chmod a+rwx data public .htdigest

# Install composer
php -r "readfile('http://getcomposer.org/installer');" > composer-setup.php
php composer-setup.php --install-dir=/usr/bin --filename=composer # As executable
php -r "unlink('composer-setup.php');"

# Fetch SabreDAV
composer require sabre/dav ~3.1.3
composer update sabre/dav

# Create authentication file
echo "$WEBDAV_USERNAME:SabreDAV:$(php -r "echo md5('$WEBDAV_USERNAME:SabreDAV:$WEBDAV_PASSWORD');")" >> .htdigest