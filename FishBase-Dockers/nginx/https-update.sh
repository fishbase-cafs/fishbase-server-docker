#!/bin/sh
killall certbot > /dev/null 2>&1
certbot renew --quiet --renew-hook "/usr/sbin/nginx -s reload" &
date > /tmp/lastbot
