FROM alpine:latest

RUN apk add --no-cache \
    bash \
    tzdata \
    && rm -rf /var/cache/apk/*

ENV TZ=UTC

ADD update_mam.sh /usr/local/bin/update_mam.sh
RUN chmod +x /usr/local/bin/update_mam.sh

# set cron schedule and start cron
CMD echo "$CRON_SCHEDULE /usr/local/bin/update_mam.sh" > /etc/crontabs/root && crond -f
