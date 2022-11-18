ENV_FILE=.env

include ${ENV_FILE}
export

IMAGE_TAG=0.1.0
REGISTRY=${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
IMAGE=${REGISTRY}/${UI_AWS_ECR}:${IMAGE_TAG}

.SILENT:

## help: print this help message
.PHONY: help
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

## build: build
.PHONY: build
build:
	docker build -f Dockerfile -t ${IMAGE} .

## login: login to registry
.PHONY: login
login:
	aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${REGISTRY}

## push: push to registry
.PHONY: push
push:
	docker push ${IMAGE}

## publish: build + login + push
.PHONY: publish
publish:
	make build
	make login
	make push
