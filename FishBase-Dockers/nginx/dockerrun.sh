#!/usr/bin/env sh

if [ -n "$WEB2DOMAIN" ]; then
        cp -f /template.conf "/etc/nginx/conf.d/$WEB2DOMAIN.conf"
        sed -i "s/{WEBDOMAIN}/$WEB2DOMAIN/g" "/etc/nginx/conf.d/$WEB2DOMAIN.conf"
        sed -i "s/default_server/ /g" "/etc/nginx/conf.d/$WEB2DOMAIN.conf"
        sed -i "s/{LOGTAG}/#/g" "/etc/nginx/conf.d/$WEB2DOMAIN.conf"
	mkdir -p /etc/letsencrypt/live/$WEB2DOMAIN
	cp -n /etc/letsencrypt/live/$WEBDOMAIN/chain.pem /etc/letsencrypt/live/$WEB2DOMAIN/chain.pem
	cp -n /etc/letsencrypt/live/$WEBDOMAIN/fullchain.pem /etc/letsencrypt/live/$WEB2DOMAIN/fullchain.pem
	cp -n /etc/letsencrypt/live/$WEBDOMAIN/privkey.pem /etc/letsencrypt/live/$WEB2DOMAIN/privkey.pem
fi

