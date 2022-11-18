ENV_FILE=.env

include ${ENV_FILE}
export

IMAGE_TAG=$(shell poetry version -s)
REGISTRY=${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
IMAGE=${REGISTRY}/${API_AWS_ECR}:${IMAGE_TAG}

.SILENT:

## help: print this help message
.PHONY: help
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

## install: install for local development
.PHONY: install
install:
	poetry env use python3.9
	poetry install

## run: run api
.PHONY: run
run:
	poetry run uvicorn src.main:app --port ${API_PORT} --host ${API_HOST} --workers ${API_WORKERS}

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
