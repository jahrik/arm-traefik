IMAGE = "jahrik/arm-traefik"
TAG := $(shell uname -m)

all: build

build:
	@docker build -t ${IMAGE}:$(TAG) -f Dockerfile_${TAG} .

push:
	@docker push ${IMAGE}:$(TAG)

deploy:
	# @docker stack deploy -c docker-compose.yml traefik
	@docker stack deploy --resolve-image=never --with-registry-auth -c docker-compose.yml traefik

.PHONY: all build push deploy
