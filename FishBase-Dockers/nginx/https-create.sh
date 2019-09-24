#!/bin/sh
echo == Check User ==
cr=`ls /etc/letsencrypt/accounts/acme-v01.api.letsencrypt.org/directory/*/meta.json`
if [ -z "$cr" ]; then
	certbot register --agree-tos --email webmaster@$FB_WEBDOMAIN
fi
echo == Did SSL ==
# ============  Those Code Is Clean Folder to slove the Custom SSL make the Errors ===============
if [ -d "/etc/letsencrypt/live/$FB_WEBDOMAIN" ]; then
	mv "/etc/letsencrypt/live/$FB_WEBDOMAIN" "/etc/letsencrypt/live/$FB_WEBDOMAIN-bak"
fi
if [ -d "/etc/letsencrypt/archive/$FB_WEBDOMAIN" ]; then
        mv "/etc/letsencrypt/archive/$FB_WEBDOMAIN" "/etc/letsencrypt/archive/$FB_WEBDOMAIN-bak"
fi
if [ -f "/etc/letsencrypt/renewal/$FB_WEBDOMAIN.conf" ]; then
        mv "/etc/letsencrypt/renewal/$FB_WEBDOMAIN.conf" "/etc/letsencrypt/renewal/$FB_WEBDOMAIN.conf.bak"
fi
# ============  Those Code Is Clean Folder to slove the Custom SSL make the Errors ===============
if [ -d "/etc/letsencrypt/live/$SLB_WEBDOMAIN" ]; then
        mv "/etc/letsencrypt/live/$SLB_WEBDOMAIN" "/etc/letsencrypt/live/$SLB_WEBDOMAIN-bak"
fi
if [ -d "/etc/letsencrypt/archive/$SLB_WEBDOMAIN" ]; then
        mv "/etc/letsencrypt/archive/$SLB_WEBDOMAIN" "/etc/letsencrypt/archive/$SLB_WEBDOMAIN-bak"
fi
if [ -f "/etc/letsencrypt/renewal/$SLB_WEBDOMAIN.conf" ]; then
        mv "/etc/letsencrypt/renewal/$SLB_WEBDOMAIN.conf" "/etc/letsencrypt/renewal/$SLB_WEBDOMAIN.conf.bak"
fi

# =========== Those Code Is Apply For WebSites =====================
certbot certonly --webroot -w /etc/letsencrypt/acme -d $FB_WEBDOMAIN -d www.$FB_WEBDOMAIN -n
certbot certonly --webroot -w /etc/letsencrypt/acme -d $SLB_WEBDOMAIN -d www.$SLB_WEBDOMAIN -n
# =========== Those Code Is To Recuse the Old SSL CA if Apply Failure ==================
if [ -d "/etc/letsencrypt/live/$FB_WEBDOMAIN" ]; then
	rm -rf "/etc/letsencrypt/live/$FB_WEBDOMAIN-bak"
else
	mv "/etc/letsencrypt/live/$FB_WEBDOMAIN-bak" "/etc/letsencrypt/live/$FB_WEBDOMAIN"
fi
if [ -d "/etc/letsencrypt/archive/$FB_WEBDOMAIN" ]; then
        rm -rf "/etc/letsencrypt/archive/$FB_WEBDOMAIN-bak"
else
        mv "/etc/letsencrypt/archive/$FB_WEBDOMAIN-bak" "/etc/letsencrypt/archive/$FB_WEBDOMAIN"
fi
if [ -f "/etc/letsencrypt/renewal/$FB_WEBDOMAIN.conf" ]; then
        rm -rf "/etc/letsencrypt/renewal/$FB_WEBDOMAIN.conf.bak"
else
        mv "/etc/letsencrypt/renewal/$FB_WEBDOMAIN.conf.bak" "/etc/letsencrypt/renewal/$FB_WEBDOMAIN.conf"
fi
# =========== Those Code Is To Recuse the Old SSL CA if Apply Failure ==================
if [ -d "/etc/letsencrypt/live/$SLB_WEBDOMAIN" ]; then
        rm -rf "/etc/letsencrypt/live/$SLB_WEBDOMAIN-bak"
else
        mv "/etc/letsencrypt/live/$SLB_WEBDOMAIN-bak" "/etc/letsencrypt/live/$SLB_WEBDOMAIN"
fi
if [ -d "/etc/letsencrypt/archive/$SLB_WEBDOMAIN" ]; then
        rm -rf "/etc/letsencrypt/archive/$SLB_WEBDOMAIN-bak"
else
        mv "/etc/letsencrypt/archive/$SLB_WEBDOMAIN-bak" "/etc/letsencrypt/archive/$SLB_WEBDOMAIN"
fi
if [ -f "/etc/letsencrypt/renewal/$SLB_WEBDOMAIN.conf" ]; then
        rm -rf "/etc/letsencrypt/renewal/$SLB_WEBDOMAIN.conf.bak"
else
        mv "/etc/letsencrypt/renewal/$SLB_WEBDOMAIN.conf.bak" "/etc/letsencrypt/renewal/$SLB_WEBDOMAIN.conf"
fi
# ============ Those Code Is Reload Nginx Settings ====================
nginx -s reload

# ============ Code Below This Line Is Apply A Wildchar CA ===============
#certbot certonly -d *.$FB_WEBDOMAIN -d $FB_WEBDOMAIN --agree-tos --email webmaster@$FB_WEBDOMAIN --manual --preferred-challenges dns --server https://acme-v02.api.letsencrypt.org/directory

