#!/bin/sh
echo === SendCmd To Create SSL ===
certbot certonly -d www.$WEB2DOMAIN -d $WEB2DOMAIN --agree-tos --email webmaster@$WEB2DOMAIN --manual --preferred-challenges dns --server https://acme-v02.api.letsencrypt.org/directory

