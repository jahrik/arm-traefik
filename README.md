# arm-traefik

[![Build](https://github.com/jahrik/arm-traefik/actions/workflows/build.yml/badge.svg)](https://github.com/jahrik/arm-traefik/actions/workflows/build.yml)

Multi-arch [Traefik](https://traefik.io/) image fronting the swarm stacks (Cloudflare DNS-challenge TLS, dashboard, swarm provider). A pinned layer over the official `traefik` image; all config is CLI flags in the compose.

## Run

```bash
docker run --rm jahrik/arm-traefik:latest version
```

## Deploy (swarm)

```bash
make deploy   # stack: traefik, creates the traefik overlay network
```

Needs `CF_API_EMAIL`/`CF_API_KEY`/`DOMAINNAME`/`TRAEFIK_ACME_CASERVER` env vars; acme.json and dynamic rules live under `/mnt/g1/traefik`.

## Build

```bash
make build
make push
```

CI: PR builds + version/API checks; merge to main pushes multi-arch (amd64/arm64/armv6) to Docker Hub — upstream ships arm/v6, which also runs on Pi 3.
