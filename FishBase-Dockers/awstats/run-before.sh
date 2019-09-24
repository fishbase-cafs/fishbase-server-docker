#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
echo === Rotate Logs ===
echo === Cut Logs ===

datv=`date "+%Y%m%d"`
yerv=`date "+%Y"`
mkdir -p "/awstatslogs/$1/$yerv"
mkdir -p "/awstatsdatas/$1"
chmod a+w "/awstatsdatas/$1" -R
filev="/awstatslogs/$1/$yerv/$1-$datv.log"
cat /var/log/nginx/access.log >> $filev

status=`echo $?`
if [ "$status" -eq 0 ]; then
   echo === Clear Logs ===
   cat /dev/null > /var/log/nginx/access.log
else
   echo Failure
fi

mkdir -p "/awstatslogs/$2/$yerv"
mkdir -p "/awstatsdatas/$2"
chmod a+w "/awstatsdatas/$2" -R
filev2="/awstatslogs/$2/$yerv/$2-$datv.log"
cat /var/log/nginx/access_slb.log >> $filev2

status=`echo $?`
if [ "$status" -eq 0 ]; then
   echo === Clear Logs ===
   cat /dev/null > /var/log/nginx/access_slb.log
else
   echo Failure
fi
