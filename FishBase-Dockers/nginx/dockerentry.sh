#!/usr/bin/env sh

if [ -f "/usr/sbin/crond" ]; then
  crond -b -S -l 2
fi

mkdir -p /etc/nginx/conf.d
cp -f /template.conf "/etc/nginx/conf.d/$WEBDOMAIN.conf"
sed -i "s/{WEBDOMAIN}/$WEBDOMAIN/g" "/etc/nginx/conf.d/$WEBDOMAIN.conf"

/usr/local/bin/docker-run.sh > /dev/null 2>&1 &

if [ -f "/usr/sbin/nginx" ]; then
  /usr/sbin/nginx -g "daemon off;" "$@"
else
  echo "There is no NGINX application installed"
  "$@"
fi
