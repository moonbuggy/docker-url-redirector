# Docker URL Redirector
An Nginx container with URL redirections configured based on a container
environment variable.

Combining this with [Traefik](https://traefik.io/traefik/) and
[Docker Dnsmasq Updater](https://github.com/moonbuggy/docker-dnsmasq-updater),
we can override the DNS lookup for a public site we want to redirect, point it
to this container and then redirect it to where we want to go.

## Container Environment
*   `REDIRECTS`	 - a space separated list of `<domain>,<redirect>` strings
*   `TZ`		     - set timezone

An example of _REDIRECTS_, forcing the use of geo-specific domains:
```sh
REDIRECTS="google.com,google.com.au ebay.com,ebay.com.au"
```

#### docker-compose.yml
```yaml
version: '3.8'

services:
  url-redirector:
    image: moonbuggy2000/url-redirector:latest
    container_name: url-redirector
    hostname: url-redirector
    domainname: url-redirector.moon
    restart: unless-stopped
    environment:
      - "TZ=Australia/Sydney"
      - "REDIRECTS=<domain_1>,<redirect_1> <domain_2>,<redirect_2>"
    labels:
      - "traefik.enable=true"
      - "traefik.docker.network=traefik"
      - "traefik.http.routers.url-redirector.rule=Host(`domain_1`) || Host(`domain_2`)"
    networks:
      - traefik

networks:
  traefik:
    name: traefik
```

## Links
GitHub: <https://github.com/moonbuggy/docker-url-redirector>

Docker Hub: <https://hub.docker.com/r/moonbuggy2000/url-redirector>
