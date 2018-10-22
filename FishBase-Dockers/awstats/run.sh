#!/bin/bash

service apache2 start

WEBS1=`echo $WEBDOMAIN | sed -e "s/\./\\\\\\\\\\\\\\\\\\\\\./g"`
cp -f /awstats.template.conf "/usr/lib/cgi-bin/awstats/awstats.$WEBDOMAIN.conf"
sed -i "s/{WEBNAME}/$WEBDOMAIN/g" "/usr/lib/cgi-bin/awstats/awstats.$WEBDOMAIN.conf"
sed -i "s/{WEBSITE}/$WEBDOMAIN/g" "/usr/lib/cgi-bin/awstats/awstats.$WEBDOMAIN.conf"
sed -i "s/{WEBREG1}/$WEBS1/g" "/usr/lib/cgi-bin/awstats/awstats.$WEBDOMAIN.conf"

if [ ! -n "$WEB2DOMAIN" ]; then
	sed -i "s/{WEBSITE}/localdomain/g" "/usr/lib/cgi-bin/awstats/awstats.$WEBDOMAIN.conf"
	sed -i "s/{WEBREG2}/localdomain/g" "/usr/lib/cgi-bin/awstats/awstats.$WEBDOMAIN.conf"
else
	WEBS2=`echo $WEB2DOMAIN | sed -e "s/\./\\\\\\\\\\\\\\\\\\\\\./g"`
	sed -i "s/{WEB2SITE}/$WEB2DOMAIN/g" "/usr/lib/cgi-bin/awstats/awstats.$WEBDOMAIN.conf"
	sed -i "s/{WEBREG2}/$WEBS2/g" "/usr/lib/cgi-bin/awstats/awstats.$WEBDOMAIN.conf"
fi

while [ true ] ;
do
/bin/sh /run-before.sh $WEBDOMAIN
/usr/bin/perl /usr/lib/cgi-bin/awstats/awstats.pl -config=$WEBDOMAIN -update
sleep 600
/etc/init.d/apache2 start
done

