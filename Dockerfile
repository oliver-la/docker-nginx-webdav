FROM          debian:jessie
MAINTAINER    oliver@xama.us

RUN           apt-get update && \
              DEBIAN_FRONTEND=noninteractive apt-get install -y nginx php5-fpm && \
              rm -rf /var/lib/apt/lists/*

# Default webdav user (CHANGE THIS!)
ENV           WEBDAV_USERNAME admin
ENV           WEBDAV_PASSWORD admin

COPY          install.sh /install.sh

# Configure nginx
RUN           rm -rf /etc/nginx/sites-enabled/*
COPY          default /etc/nginx/sites-enabled/default
RUN           rm /etc/nginx/fastcgi_params
COPY          fastcgi_params /etc/nginx/fastcgi_params

# forward request and error logs to docker log collector
RUN           ln -sf /dev/stdout /var/log/nginx/access.log
RUN           ln -sf /dev/stderr /var/log/nginx/error.log

# copy server.php for client -- sabredav communication
COPY         /server.php /var/webdav/server.php

VOLUME       /var/webdav/public

CMD          /install.sh && service php5-fpm start && nginx -g "daemon off;"

