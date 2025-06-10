build:
	@docker compose build

run:
	@chmod -R 777 ./input/VIDEO_TS/
	@docker compose run --rm app

.PHONY: build run
