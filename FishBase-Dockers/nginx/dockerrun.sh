#!/usr/bin/env sh

if [ -n "$WEB2DOMAIN" ]; then
        cp -f /template.conf "/etc/nginx/conf.d/$WEB2DOMAIN.conf"
        sed -i "s/{WEBDOMAIN}/$WEB2DOMAIN/g" "/etc/nginx/conf.d/$WEB2DOMAIN.conf"
        sed -i "s/default_server/ /g" "/etc/nginx/conf.d/$WEB2DOMAIN.conf"
        sed -i "s/{LOGTAG}/#/g" "/etc/nginx/conf.d/$WEB2DOMAIN.conf"
fi

