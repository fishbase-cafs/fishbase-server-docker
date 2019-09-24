#!/bin/bash

service apache2 start

FB_WEBS1=`echo $FB_WEBDOMAIN | sed -e "s/\./\\\\\\\\\\\\\\\\\\\\\./g"`
cp -f /awstats.template.conf "/usr/lib/cgi-bin/awstats/awstats.$FB_WEBDOMAIN.conf"
sed -i "s/{WEBNAME}/$FB_WEBDOMAIN/g" "/usr/lib/cgi-bin/awstats/awstats.$FB_WEBDOMAIN.conf"
sed -i "s/{WEBSITE}/$FB_WEBDOMAIN/g" "/usr/lib/cgi-bin/awstats/awstats.$FB_WEBDOMAIN.conf"
sed -i "s/{WEBREG1}/$FB_WEBS1/g" "/usr/lib/cgi-bin/awstats/awstats.$FB_WEBDOMAIN.conf"

if [ ! -n "$FB_WEB2DOMAIN" ]; then
	sed -i "s/{WEBSITE}/localdomain/g" "/usr/lib/cgi-bin/awstats/awstats.$FB_WEBDOMAIN.conf"
	sed -i "s/{WEBREG2}/localdomain/g" "/usr/lib/cgi-bin/awstats/awstats.$FB_WEBDOMAIN.conf"
else
	FB_WEBS2=`echo $FB_WEB2DOMAIN | sed -e "s/\./\\\\\\\\\\\\\\\\\\\\\./g"`
	sed -i "s/{WEB2SITE}/$FB_WEB2DOMAIN/g" "/usr/lib/cgi-bin/awstats/awstats.$FB_WEBDOMAIN.conf"
	sed -i "s/{WEBREG2}/$FB_WEBS2/g" "/usr/lib/cgi-bin/awstats/awstats.$FB_WEBDOMAIN.conf"
fi

if [ ! -n "$SLB_WEBDOMAIN" ]; then
SLB_WEBS1=`echo $SLB_WEBDOMAIN | sed -e "s/\./\\\\\\\\\\\\\\\\\\\\\./g"`
cp -f /awstats.template.conf "/usr/lib/cgi-bin/awstats/awstats.$SLB_WEBDOMAIN.conf"
sed -i "s/{WEBNAME}/$SLB_WEBDOMAIN/g" "/usr/lib/cgi-bin/awstats/awstats.$SLB_WEBDOMAIN.conf"
sed -i "s/{WEBSITE}/$SLB_WEBDOMAIN/g" "/usr/lib/cgi-bin/awstats/awstats.$SLB_WEBDOMAIN.conf"
sed -i "s/{WEBREG1}/$SLB_WEBS1/g" "/usr/lib/cgi-bin/awstats/awstats.$SLB_WEBDOMAIN.conf"

if [ ! -n "$SLB_WEB2DOMAIN" ]; then
        sed -i "s/{WEBSITE}/localdomain/g" "/usr/lib/cgi-bin/awstats/awstats.$SLB_WEBDOMAIN.conf"
        sed -i "s/{WEBREG2}/localdomain/g" "/usr/lib/cgi-bin/awstats/awstats.$SLB_WEBDOMAIN.conf"
else
        SLB_WEBS2=`echo $SLB_WEB2DOMAIN | sed -e "s/\./\\\\\\\\\\\\\\\\\\\\\./g"`
        sed -i "s/{WEB2SITE}/$SLB_WEB2DOMAIN/g" "/usr/lib/cgi-bin/awstats/awstats.$SLB_WEBDOMAIN.conf"
        sed -i "s/{WEBREG2}/$SLB_WEBS2/g" "/usr/lib/cgi-bin/awstats/awstats.$SLB_WEBDOMAIN.conf"
fi
fi

while [ true ] ;
do
/bin/sh /run-before.sh $FB_WEBDOMAIN $SLB_WEBDOMAIN
/usr/bin/perl /usr/lib/cgi-bin/awstats/awstats.pl -config=$FB_WEBDOMAIN -update
/usr/bin/perl /usr/lib/cgi-bin/awstats/awstats.pl -config=$SLB_WEBDOMAIN -update
sleep 600
/etc/init.d/apache2 start
done

