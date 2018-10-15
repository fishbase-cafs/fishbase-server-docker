#!/bin/sh
echo === SendCmd To Create SSL ===
certbot certonly -d www.$WEBDOMAIN -d $WEBDOMAIN --agree-tos --email webmaster@$WEBDOMAIN --manual --preferred-challenges dns --server https://acme-v02.api.letsencrypt.org/directory

