FROM alpine:3.18.3

RUN set -xe \
    && apk add -U rsync libcap \
    && rm -rf /var/cache/apk/*

COPY rsyncd.conf /etc/rsyncd.conf
COPY docker-entrypoint.sh /docker-entrypoint.sh

# https://askubuntu.com/a/919732
RUN adduser -D rsyncd && setcap cap_net_bind_service,cap_setgid=+ep /usr/bin/rsync
USER rsyncd

WORKDIR /share
COPY --chown=rsyncd rsyncd.secrets /home/rsyncd/

EXPOSE 873

ENTRYPOINT [ "/docker-entrypoint.sh"]
CMD ["rsync", "--daemon", "--no-detach", "--log-file", "/dev/stdout"]
