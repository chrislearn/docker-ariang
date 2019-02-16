FROM multiarch/alpine:aarch64-edge

ARG ARIANG_VERSION=1.0.0

ENV RPC_SECRET=
ENV ENABLE_AUTH=false
ENV ARIA2_USER=user
ENV ARIA2_PWD=password
ENV DOMAIN=:80
ENV PUID=1000
ENV PGID=1000

RUN apk add --no-cache --update caddy aria2

COPY conf /aria2/conf-copy
COPY aria2c.sh /aria2/
COPY Caddyfile /
COPY SecureCaddyfile /

# AriaNG
WORKDIR /ariang

RUN chmod +x /aria2/aria2c.sh && \
    wget https://github.com/mayswind/AriaNg/releases/download/${ARIANG_VERSION}/AriaNg-${ARIANG_VERSION}.zip && \
    unzip AriaNg-${ARIANG_VERSION}.zip && \
    rm AriaNg-${ARIANG_VERSION}.zip && \
    chmod -R 755 ./

WORKDIR /aria2

# User downloaded files
VOLUME /aria2/data
VOLUME /aria2/conf

EXPOSE 6800
EXPOSE 80

CMD ["/bin/sh", "/aria2/aria2c.sh"]
