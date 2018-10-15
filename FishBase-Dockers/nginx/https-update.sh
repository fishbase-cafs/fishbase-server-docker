#!/bin/sh
killall certbot
certbot renew --quiet --renew-hook "/usr/sbin/nginx -s reload" &
date > /tmp/lastbot
