IMAGE = "jahrik/arm-traefik"
TAG := $(shell uname -m)

all: build

build:
	@docker build -t ${IMAGE}:$(TAG) -f Dockerfile_${TAG} .

push:
	@docker push ${IMAGE}:$(TAG)

.PHONY: all build push
