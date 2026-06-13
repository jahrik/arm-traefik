# AGENTS.md

Multi-arch Traefik image: pinned `FROM` over official `traefik` v3, deployed as the `traefik` swarm stack that fronts the other stacks. All config is CLI flags in `docker-compose.yml`.

## Commands

```bash
make build                                  # build jahrik/arm-traefik:latest
docker run --rm jahrik/arm-traefik:latest version
make deploy                                 # swarm stack deploy (stack: traefik)
```

## CI

`build.yml`: Test (build + `version` + insecure-API poll) on PR; Release (buildx amd64/arm64/armv6 push to Docker Hub — upstream has no arm/v7, v6 covers Pi 3) on merge to main. Needs `DOCKERHUB_USERNAME`/`DOCKERHUB_TOKEN` secrets.

## Quirks

- v3 renamed the swarm provider: `--providers.swarm.*` (was `--providers.docker.* + swarmmode`). The old 1.x/2.x `traefik.toml` is gone.
- Other repos' compose files still carry traefik 1.x labels — update them to v3 router/service labels as stacks get redeployed against this.
- Runs on a manager node (docker.sock); secrets via `CF_API_*`, cert storage at `/mnt/g1/traefik/acme.json` (mode 600).
