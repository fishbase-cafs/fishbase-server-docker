1.This Docker Should Be Setup For Fully Image of FishBase

Before your uses to change the docker-composer.yml to yourselfs:

<1> Setup inner MYSQL Password:
MYSQL_ROOT_PASSWORD=<Password>

It should be as same as the setting of PHP codes(webroot/includes/db.config.php and webroot/includes/db_connect.php)
And for the same reason, you need to set the server address in the database configuration to "fb_mysql" to ensure a database connection.

<2> Setup yourselves file folder:
Replace your folder to docker-composer.yml
My setting is:

/FishBase/WebPages/fishbaseweb   ==>  web files (webroot)
/FishBase/DataBases/mysql  ==>  db files (mysql files)
/FishBase/Awstats/Tmplog ==> current log folder (prepare an empty folder to make the temp files)
/FishBase/Awstats/Logs ==> awstats rotated logs (prepare an empty folder to make the files in)
/FishBase/Awstats/Datas ==> awstats result datas (prepare an empty folder to make the files in)
/FishBase/Configures/SSL ==> Let's Encrypt Folder (see SSL command part)

<3> Setup Domain Name
Replace all the 'fishbase.cn' to yourselves domain name.

<4> After Step 1.2.3 you can run "up" Command: "docker-compose up -d" to let your server run.

<5> Setup SSL commands
--(1) use Let's Encrypt As your HTTPS ca.
Let's Encrypt is a Free HTTPS Certificate authority.it use the ACME system to authorize.Each certificate is given 90 days.
However, the first production certificate process is necessary.
The built-in scripts are DNS certified for pre-deployment and debug deployment.

Input this command in your Shell after you finished the "up" command.

docker exec -it fb_nginx /https-create.sh

Follow the steps to complete the authentication. 
The script uses "Certbot" for certificate registration. Please refer to relevant information(https://certbot.eff.org/) if necessary.

A script from ACME is deployed inside docker to automatically extend the certificate validity.
If it is not work you can input this command to update manually.

docker exec -it fb_nginx /https-update.sh

--(2) use my selves HTTPS Certificate.
The most secure and applicable configuration files are already configured in the Docker Container "fb_nginx" container and can be configured manually if you are familiar with them (/etc/nginx/conf.d/*.conf).
You can use this command to enter the command shell inner docker container "fb_nginx"

docker exec -it fb_nginx /bin/sh

A simpler and more recommended approach is to place your certificates directly where they should be:
Firstly,you should make directories to your computer.
The folder is:<Let's Encrypt Folder>/live/www.<Domain name>
It should be consistent with the settings in <1>,Now It use my setting:

mkdir -p /FishBase/Configures/SSL/live/www.fishbase.cn

then copy and rename your certificate files:
`privkey.pem`  : the private key for your certificate.
`fullchain.pem`: the certificate file used in most server software.
`chain.pem`    : used for OCSP stapling.


<6> Reboot All Services
After all your setting.Reboot Dockers by this Command:

docker-composer restart

if you need update mirrors.you can use those commands:
To Stop Services:  docker-composer down
To Start Services:  docker-composer up -d

This is my docker's version.if there is some problem,check it first:
Docker-CE:
Docker version 18.06.1-ce, build e68fc7a
Docker-Compose:
Docker-compose version 1.8.0, build unknown


                                                                                      Balthasar @ Fishbase.cn

