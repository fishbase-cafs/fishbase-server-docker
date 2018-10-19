#!/bin/sh
echo == Check User ==
cr=`ls /etc/letsencrypt/accounts/acme-v01.api.letsencrypt.org/directory/*/meta.json`
if [ -z "$cr" ]; then
	certbot register --agree-tos --email webmaster@$WEBDOMAIN
fi
echo == Did SSL ==
certbot certonly --webroot -w /etc/letsencrypt/acme -d $WEBDOMAIN -d www.$WEBDOMAIN -n
/usr/sbin/nginx -s reload

#certbot certonly -d www.$WEBDOMAIN -d $WEBDOMAIN --agree-tos --email webmaster@$WEBDOMAIN --manual --preferred-challenges dns --server https://acme-v02.api.letsencrypt.org/directory

