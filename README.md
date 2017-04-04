# docker-caddy
Docker image for [Caddy](https://github.com/mholt/caddy) HTTP/2 server based on Alpine Linux 3.5

This Caddy build includes support for Route53 DNS provider.

Mount a local path like `/var/www/` to `/srv` into this Container and a local Caddyfile to `/etc/Caddyfile` to get up and running. Caddy includes automatic HTTPS suport using Let's Encrypt.
