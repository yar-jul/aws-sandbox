ENV_FILE=.env

include ${ENV_FILE}
export

IMAGE_TAG=$(shell poetry version -s)
REGISTRY=${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
IMAGE=${REGISTRY}/${AWS_ECR_NAME}:${IMAGE_TAG}

.SILENT:

## help: print this help message
.PHONY: help
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

## run: run api
.PHONY: run
run:
	poetry run uvicorn src.main:app --port ${API_PORT} --host ${API_HOST} --workers ${API_WORKERS}

## compose: create and start containers
.PHONY: compose
compose:
	docker-compose stop
	docker-compose rm -f
	docker-compose -f docker-compose.yml --env-file ${ENV_FILE} up -d --build --remove-orphans

## build: build
.PHONY: build
build:
	docker build -f Dockerfile -t ${IMAGE} .

## login: login to registry
.PHONY: login
login:
	aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${REGISTRY}

## publish: publish to registry
.PHONY: publish
publish:
	docker push ${IMAGE}
