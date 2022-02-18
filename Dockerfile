FROM alpine:3.15

RUN apk update \
    && apk add unbound \
    && wget -S https://www.internic.net/domain/named.cache -O /etc/unbound/root.hints

COPY docker-entrypoint.sh .
COPY config/unbound.conf /etc/unbound/unbound.conf

RUN chmod +x docker-entrypoint.sh

EXPOSE ${UNBOUND_PORT}

ENTRYPOINT ["./docker-entrypoint.sh"]
