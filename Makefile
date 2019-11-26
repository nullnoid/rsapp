.DEFAULT_GOAL := help

APP_NAME    = $(shell basename $(shell pwd))
SEMVER      = $(strip $(shell head -n 1 VERSION))
PROJECT     = 
IMAGE_REPO  = 

define HELP_TEXT =
Please use "make <target>" where <target> is one of:

--- General Commands ---
    help            display help

--- Commands for development ---
    run				run the app in dev mode
    build			build the app in dev mode
    test			test the app
    docker-run 		run the dockernized app
    docker-shell 	run the dockernized app with shell

--- Commands for build ---
    docker-build    build docker image
    deploy			build and push docker image

endef
export HELP_TEXT

# ignore the unknown parameters
%:
    @:

help:
	@echo "$$HELP_TEXT"

run:
	cargo run $(filter-out $@,$(MAKECMDGOALS))

build:
	cargo build $(filter-out $@,$(MAKECMDGOALS))

test:
	cargo test $(filter-out $@,$(MAKECMDGOALS))

docker-build:
	docker build . -t $(APP_NAME)

docker-run: docker-build
	docker rm --force ${APP_NAME} | true
	docker run --env-file .env --name ${APP_NAME} -it $(APP_NAME) $(filter-out $@,$(MAKECMDGOALS))

docker-shell: docker-build
	docker run --rm --env-file .env -it --entrypoint /bin/sh $(APP_NAME):$(SEMVER)

docker-tag:
	git tag v$(SEMVER) | true
	# docker tag $(APP_NAME) ${IMAGE_REPO}/$(APP_NAME):$(SEMVER)

docker-push:
	# docker push $(IMAGE_REPO)/$(APP_NAME):$(SEMVER)

deploy: docker-build docker-tag docker-push
