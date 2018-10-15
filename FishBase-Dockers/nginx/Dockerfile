FROM really/nginx-certbot
COPY template.conf /template.conf
COPY dockerentry.sh /usr/local/bin/docker-entrypoint.sh
COPY https-update.sh /https-update.sh
COPY https-create.sh /https-create.sh
RUN ln -s /https-update.sh /etc/periodic/hourly/https-update.sh
