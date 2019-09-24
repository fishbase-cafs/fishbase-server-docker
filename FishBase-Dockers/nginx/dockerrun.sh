#!/usr/bin/env sh

if [ -n "$FB_WEB2DOMAIN" ]; then
        cp -f /template.conf "/etc/nginx/conf.d/$FB_WEB2DOMAIN.conf"
        sed -i "s/{WEBDOMAIN}/$FB_WEB2DOMAIN/g" "/etc/nginx/conf.d/$FB_WEB2DOMAIN.conf"
        sed -i "s/default_server/ /g" "/etc/nginx/conf.d/$FB_WEB2DOMAIN.conf"
        sed -i "s/{LOGTAG}/#/g" "/etc/nginx/conf.d/$FB_WEB2DOMAIN.conf"
	sed -i "s/{WEBBASIC}/$FB_WEBDOMAIN/g" "/etc/nginx/conf.d/$FB_WEB2DOMAIN.conf"
        sed -i "s/{WEBSERVER}/$FB_WEBSERVER/g" "/etc/nginx/conf.d/$FB_WEB2DOMAIN.conf"
	mkdir -p /etc/letsencrypt/live/$FB_WEB2DOMAIN
	cp -n /etc/letsencrypt/live/$FB_WEBDOMAIN/chain.pem /etc/letsencrypt/live/$FB_WEB2DOMAIN/chain.pem 2>&1
	cp -n /etc/letsencrypt/live/$FB_WEBDOMAIN/fullchain.pem /etc/letsencrypt/live/$FB_WEB2DOMAIN/fullchain.pem 2>&1
	cp -n /etc/letsencrypt/live/$FB_WEBDOMAIN/privkey.pem /etc/letsencrypt/live/$FB_WEB2DOMAIN/privkey.pem 2>&1
fi

if [ -n "$SLB_WEBDOMAIN" ]; then
        cp -f /template.conf "/etc/nginx/conf.d/$SLB_WEBDOMAIN.conf"
        sed -i "s/{WEBDOMAIN}/$SLB_WEBDOMAIN/g" "/etc/nginx/conf.d/$SLB_WEBDOMAIN.conf"
        sed -i "s/default_server/ /g" "/etc/nginx/conf.d/$SLB_WEBDOMAIN.conf"
        sed -i "s/{LOGTAG}/#/g" "/etc/nginx/conf.d/$SLB_WEBDOMAIN.conf"
        sed -i "s/{WEBBASIC}/$SLB_WEBDOMAIN/g" "/etc/nginx/conf.d/$SLB_WEBDOMAIN.conf"
        sed -i "s/{WEBSERVER}/$SLB_WEBSERVER/g" "/etc/nginx/conf.d/$SLB_WEBDOMAIN.conf"
        mkdir -p /etc/letsencrypt/live/$SLB_WEBDOMAIN
        cp -n /etc/https-ca/chain.pem /etc/letsencrypt/live/$SLB_WEBDOMAIN/chain.pem 2>&1
        cp -n /etc/https-ca/fullchain.pem /etc/letsencrypt/live/$SLB_WEBDOMAIN/fullchain.pem 2>&1
        cp -n /etc/https-ca/privkey.pem /etc/letsencrypt/live/$SLB_WEBDOMAIN/privkey.pem 2>&1
fi

if [ -n "$SLB_WEB2DOMAIN" ]; then
        cp -f /template.conf "/etc/nginx/conf.d/$SLB_WEB2DOMAIN.conf"
        sed -i "s/{WEBDOMAIN}/$SLB_WEB2DOMAIN/g" "/etc/nginx/conf.d/$SLB_WEB2DOMAIN.conf"
        sed -i "s/default_server/ /g" "/etc/nginx/conf.d/$SLB_WEB2DOMAIN.conf"
        sed -i "s/{LOGTAG}/#/g" "/etc/nginx/conf.d/$SLB_WEB2DOMAIN.conf"
        sed -i "s/{WEBBASIC}/$SLB_WEBDOMAIN/g" "/etc/nginx/conf.d/$SLB_WEB2DOMAIN.conf"
        sed -i "s/{WEBSERVER}/$SLB_WEBSERVER/g" "/etc/nginx/conf.d/$SLB_WEB2DOMAIN.conf"
        mkdir -p /etc/letsencrypt/live/$SLB_WEB2DOMAIN
        cp -n /etc/letsencrypt/live/$SLB_WEBDOMAIN/chain.pem /etc/letsencrypt/live/$SLB_WEB2DOMAIN/chain.pem 2>&1
        cp -n /etc/letsencrypt/live/$SLB_WEBDOMAIN/fullchain.pem /etc/letsencrypt/live/$SLB_WEB2DOMAIN/fullchain.pem 2>&1
        cp -n /etc/letsencrypt/live/$SLB_WEBDOMAIN/privkey.pem /etc/letsencrypt/live/$SLB_WEB2DOMAIN/privkey.pem 2>&1
fi

