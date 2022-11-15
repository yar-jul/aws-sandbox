include .env
export

.SILENT:

## help: print this help message
.PHONY: help
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

## run: run api
.PHONY: run
run:
	poetry run uvicorn src.main:app --port $(PORT) --host $(HOST) --workers $(WORKERS)

## compose: create and start containers
.PHONY: compose
compose:
	docker-compose stop
	docker-compose rm -f
	docker-compose -f docker-compose.yml --env-file .env up -d --build --remove-orphans
