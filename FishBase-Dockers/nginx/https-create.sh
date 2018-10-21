#!/bin/sh
echo == Check User ==
cr=`ls /etc/letsencrypt/accounts/acme-v01.api.letsencrypt.org/directory/*/meta.json`
if [ -z "$cr" ]; then
	certbot register --agree-tos --email webmaster@$WEBDOMAIN
fi
echo == Did SSL ==
if [ -d "/etc/letsencrypt/live/$WEBDOMAIN" ]; then
	mv "/etc/letsencrypt/live/$WEBDOMAIN" "/etc/letsencrypt/live/$WEBDOMAIN-bak"
fi
if [ -d "/etc/letsencrypt/archive/$WEBDOMAIN" ]; then
        mv "/etc/letsencrypt/archive/$WEBDOMAIN" "/etc/letsencrypt/archive/$WEBDOMAIN-bak"
fi
if [ -f "/etc/letsencrypt/renewal/$WEBDOMAIN.conf" ]; then
        mv "/etc/letsencrypt/renewal/$WEBDOMAIN.conf" "/etc/letsencrypt/renewal/$WEBDOMAIN.conf.bak"
fi
certbot certonly --webroot -w /etc/letsencrypt/acme -d $WEBDOMAIN -d www.$WEBDOMAIN -n
if [ -d "/etc/letsencrypt/live/$WEBDOMAIN" ]; then
	rm -rf "/etc/letsencrypt/live/$WEBDOMAIN-bak"
else
	mv "/etc/letsencrypt/live/$WEBDOMAIN-bak" "/etc/letsencrypt/live/$WEBDOMAIN"
fi
if [ -d "/etc/letsencrypt/archive/$WEBDOMAIN" ]; then
        rm -rf "/etc/letsencrypt/archive/$WEBDOMAIN-bak"
else
        mv "/etc/letsencrypt/archive/$WEBDOMAIN-bak" "/etc/letsencrypt/archive/$WEBDOMAIN"
fi
if [ -f "/etc/letsencrypt/renewal/$WEBDOMAIN.conf" ]; then
        rm -rf "/etc/letsencrypt/renewal/$WEBDOMAIN.conf.bak"
else
        mv "/etc/letsencrypt/renewal/$WEBDOMAIN.conf.bak" "/etc/letsencrypt/renewal/$WEBDOMAIN.conf"
fi

nginx -s reload

#certbot certonly -d www.$WEBDOMAIN -d $WEBDOMAIN --agree-tos --email webmaster@$WEBDOMAIN --manual --preferred-challenges dns --server https://acme-v02.api.letsencrypt.org/directory

