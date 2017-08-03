# docker-caddy

[![Docker Build Statu](https://img.shields.io/docker/build/pteich/caddy.svg)](https://hub.docker.com/r/pteich/caddy/)

Docker image for [Caddy](https://github.com/mholt/caddy) HTTP/2 server based on Alpine Linux 3.5

Mount a local path like `/var/www/` to `/srv` into this Container and a local Caddyfile to `/etc/Caddyfile` to get up and running. Caddy includes automatic HTTPS suport using Let's Encrypt.
