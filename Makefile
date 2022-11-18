ENV_FILE=.env

include ${ENV_FILE}
export

.SILENT:

## help: print this help message
.PHONY: help
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

## compose: create and start containers
.PHONY: compose
compose:
	docker-compose stop
	docker-compose rm -f
	docker-compose -f docker-compose.yml --env-file ${ENV_FILE} up -d --build --remove-orphans
