#!/usr/bin/env sh

if [ -f "/usr/sbin/crond" ]; then
  crond -b -S -l 2
fi

mkdir -p /etc/nginx/conf.d
cp -f /template.conf "/etc/nginx/conf.d/$FB_WEBDOMAIN.conf"
sed -i "s/{WEBDOMAIN}/$FB_WEBDOMAIN/g" "/etc/nginx/conf.d/$FB_WEBDOMAIN.conf"
sed -i "s/{LOGTAG}/ /g" "/etc/nginx/conf.d/$FB_WEBDOMAIN.conf"
sed -i "s/{WEBBASIC}/$FB_WEBDOMAIN/g" "/etc/nginx/conf.d/$FB_WEBDOMAIN.conf"
sed -i "s/{WEBSERVER}/$FB_WEBSERVER/g" "/etc/nginx/conf.d/$FB_WEBDOMAIN.conf"
sed -i "s/{LOGFILE}/access/g" "/etc/nginx/conf.d/$FB_WEBDOMAIN.conf"

mkdir -p /etc/letsencrypt/live/$FB_WEBDOMAIN
cp -n /etc/https-ca/chain.pem /etc/letsencrypt/live/$FB_WEBDOMAIN/chain.pem 2>&1
cp -n /etc/https-ca/fullchain.pem /etc/letsencrypt/live/$FB_WEBDOMAIN/fullchain.pem 2>&1
cp -n /etc/https-ca/privkey.pem /etc/letsencrypt/live/$FB_WEBDOMAIN/privkey.pem 2>&1

#cp -f /template.conf "/etc/nginx/conf.d/$SLB_WEBDOMAIN.conf"
#sed -i "s/{WEBDOMAIN}/$SLB_WEBDOMAIN/g" "/etc/nginx/conf.d/$SLB_WEBDOMAIN.conf"
#sed -i "s/{LOGTAG}/ /g" "/etc/nginx/conf.d/$SLB_WEBDOMAIN.conf"
#sed -i "s/{WEBBASIC}/$SLB_WEBDOMAIN/g" "/etc/nginx/conf.d/$SLB_WEBDOMAIN.conf"
#sed -i "s/{WEBSERVER}/$SLB_WEBSERVER/g" "/etc/nginx/conf.d/$SLB_WEBDOMAIN.conf"

#mkdir -p /etc/letsencrypt/live/$SLB_WEBDOMAIN
#cp -n /etc/https-ca/chain.pem /etc/letsencrypt/live/$SLB_WEBDOMAIN/chain.pem 2>&1
#cp -n /etc/https-ca/fullchain.pem /etc/letsencrypt/live/$SLB_WEBDOMAIN/fullchain.pem 2>&1
#cp -n /etc/https-ca/privkey.pem /etc/letsencrypt/live/$SLB_WEBDOMAIN/privkey.pem 2>&1

mkdir -p /etc/letsencrypt/acme

/usr/local/bin/docker-run.sh > /dev/null 2>&1 &

service cron start

if [ -f "/usr/sbin/nginx" ]; then
  /usr/sbin/nginx -g "daemon off;" "$@"
else
  echo "There is no NGINX application installed"
  "$@"
fi
