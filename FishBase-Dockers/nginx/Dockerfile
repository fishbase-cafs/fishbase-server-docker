FROM really/nginx-certbot
COPY template.conf /template.conf
COPY dockerentry.sh /usr/local/bin/docker-entrypoint.sh
COPY dockerrun.sh /usr/local/bin/docker-run.sh
COPY https-update.sh /https-update.sh
COPY https-create.sh /https-create.sh
COPY https-create-web2.sh /GlobalWeb/https-web2-create.sh
RUN ln -s /https-update.sh /etc/periodic/hourly/https-update.sh
