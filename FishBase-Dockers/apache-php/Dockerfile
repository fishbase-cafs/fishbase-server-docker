FROM nimmis/apache-php7
RUN apt-get update \
    && apt-get install -y php-xml
COPY speling.load /etc/apache2/mods-enabled/speling.load
COPY speling.conf /etc/apache2/mods-enabled/speling.conf
COPY config.ini /etc/php/7.0/apache2/conf.d/php-addition.ini
#RUN service apache2 restart
