FROM alpine:3.17.3

RUN apk update \
    && apk add unbound bind-tools \
    && wget -S https://www.internic.net/domain/named.cache -O /etc/unbound/root.hints

COPY docker-entrypoint.sh .
COPY config/unbound.conf /etc/unbound/unbound.conf

RUN chmod +x docker-entrypoint.sh

HEALTHCHECK --interval=10s \
    --timeout=5s \
    --start-period=3s \
    CMD dig +short +norecurse +retry=0 @127.0.0.1 -p 5053 pi.hole || exit 1

EXPOSE 5053

ENTRYPOINT ["./docker-entrypoint.sh"]
