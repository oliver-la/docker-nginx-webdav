FROM          debian:jessie
MAINTAINER    oliver@xama.us

RUN           apt-get update && \
              apt-get upgrade -y && \
              apt-get install -y nginx php5-fpm && \
              rm -rf /var/lib/apt/lists/*

# Default webdav user (CHANGE THIS!)
ENV           WEBDAV_USERNAME admin
ENV           WEBDAV_PASSWORD admin

# Configure directories and composer.
COPY          install.sh /install.sh
RUN           chmod +x /install.sh
RUN           bash /install.sh

# Configure nginx
RUN           rm -rf /etc/nginx/sites-enabled/*
COPY          default /etc/nginx/sites-enabled/default
RUN           rm /etc/nginx/fastcgi_params
COPY          fastcgi_params /etc/nginx/fastcgi_params
RUN           service nginx restart

# forward request and error logs to docker log collector
RUN           ln -sf /dev/stdout /var/log/nginx/access.log
RUN           ln -sf /dev/stderr /var/log/nginx/error.log

# copy server.php for client -- sabredav communication
COPY         /server.php /var/webdav/server.php

VOLUME      /var/webdav/public
