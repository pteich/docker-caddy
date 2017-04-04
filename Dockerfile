FROM alpine:3.5
MAINTAINER Peter Teich <peter.teich@gmail.com>

ENV DUMBINIT_VERSION 1.2.0
ENV CADDY_VERSION 0.9.5

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
    && wget -T 120 -O caddy.tar.gz "https://caddyserver.com/download/build?os=linux&arch=${dpkgArch}&features=route53" \
    && tar xzvf caddy.tar.gz \
    && rm -f caddy.tar.gz \
    && mv caddy /bin/caddy \
    && rm -rf /tmp/*

COPY html /html
COPY Caddyfile /config

ENTRYPOINT ["/usr/local/bin/dumb-init","/bin/caddy"]

VOLUME ["/config", "/html", "/logs"]

EXPOSE 80 443 2015
WORKDIR /html
CMD ["-agree", "-conf=/config/Caddyfile"]
