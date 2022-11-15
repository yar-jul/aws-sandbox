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
