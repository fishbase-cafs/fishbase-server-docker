#!/usr/bin/env sh

if [ -f "/usr/sbin/crond" ]; then
  crond -b -S -l 2
fi

mkdir -p /etc/nginx/conf.d
cp -f /template.conf "/etc/nginx/conf.d/$WEBDOMAIN.conf"
sed -i "s/{WEBDOMAIN}/$WEBDOMAIN/g" "/etc/nginx/conf.d/$WEBDOMAIN.conf"
sed -i "s/{LOGTAG}/ /g" "/etc/nginx/conf.d/$WEBDOMAIN.conf"
sed -i "s/{WEBBASIC}/$WEBDOMAIN/g" "/etc/nginx/conf.d/$WEBDOMAIN.conf"

mkdir -p /etc/letsencrypt/live/$WEBDOMAIN
cp -n /etc/https-ca/chain.pem /etc/letsencrypt/live/$WEBDOMAIN/chain.pem 2>&1
cp -n /etc/https-ca/fullchain.pem /etc/letsencrypt/live/$WEBDOMAIN/fullchain.pem 2>&1
cp -n /etc/https-ca/privkey.pem /etc/letsencrypt/live/$WEBDOMAIN/privkey.pem 2>&1

mkdir -p /etc/letsencrypt/acme

/usr/local/bin/docker-run.sh > /dev/null 2>&1 &

service cron start

if [ -f "/usr/sbin/nginx" ]; then
  /usr/sbin/nginx -g "daemon off;" "$@"
else
  echo "There is no NGINX application installed"
  "$@"
fi
