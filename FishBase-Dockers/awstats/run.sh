#!/bin/bash

service apache2 start

cp -f /awstats.template.conf "/usr/lib/cgi-bin/awstats/awstats.$WEBDOMAIN.conf"
sed -i "s/{WEBNAME}/$WEBDOMAIN/g" "/usr/lib/cgi-bin/awstats/awstats.$WEBDOMAIN.conf"
sed -i "s/{WEBSITE}/$WEBDOMAIN/g" "/usr/lib/cgi-bin/awstats/awstats.$WEBDOMAIN.conf"

while [ true ] ;
do
/bin/sh /run-before.sh $WEBDOMAIN
/usr/bin/perl /usr/lib/cgi-bin/awstats/awstats.pl -config=$WEBDOMAIN -update
sleep 600
done

