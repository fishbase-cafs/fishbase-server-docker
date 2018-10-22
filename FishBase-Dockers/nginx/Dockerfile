FROM nginx
COPY template.conf /template.conf
RUN apt-get update \
    && apt-get install -y vim cron letsencrypt

COPY dockerentry.sh /usr/local/bin/docker-entrypoint.sh
COPY dockerrun.sh /usr/local/bin/docker-run.sh

COPY https-update.sh /https-update.sh
COPY https-create.sh /https-create.sh
COPY ca /etc/https-ca
COPY crontab /var/spool/cron/crontabs/root

COPY bin/nginx /usr/sbin/nginx
COPY bin/libsregex.so.0 /usr/lib/libsregex.so.0
RUN mkdir -p /var/lib/nginx/tmp

#RUN ln -s /https-update.sh /etc/cron.hourly/https-update.sh
#RUN ln -s /https-create.sh /etc/cron.monthly/https-create.sh

RUN rm -rf /etc/nginx/conf.d/*
RUN mkdir -p /etc/letsencrypt/acme

ENTRYPOINT /usr/local/bin/docker-entrypoint.sh
