FROM alpine:3.5
MAINTAINER Peter Teich <peter.teich@gmail.com>

ENV DUMBINIT_VERSION 1.2.0
ENV CADDY_VERSION 0.10.3
ENV CADDYPATH /.caddy

RUN set -x \
    && apk update && apk add --no-cache \
        openssl \
        dpkg \
        ca-certificates \
    && update-ca-certificates \
    && cd /tmp \
    && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && wget -O /usr/local/bin/dumb-init "https://github.com/Yelp/dumb-init/releases/download/v${DUMBINIT_VERSION}/dumb-init_${DUMBINIT_VERSION}_${dpkgArch}" \
    && chmod +x /usr/local/bin/dumb-init \    
    && wget -O caddy.tar.gz "https://github.com/mholt/caddy/releases/download/v${CADDY_VERSION}/caddy_v${CADDY_VERSION}_linux_${dpkgArch}.tar.gz" \    
    && tar xzvf caddy.tar.gz \
    && rm -f caddy.tar.gz \
    && mv caddy /bin/caddy \
    && rm -rf /tmp/*

VOLUME ["/logs/caddy"]

COPY html /srv
COPY Caddyfile /config

ENTRYPOINT ["/usr/local/bin/dumb-init","/bin/caddy"]

EXPOSE 80 443 2015
WORKDIR /srv
CMD ["-agree", "-conf=/config/Caddyfile"]
