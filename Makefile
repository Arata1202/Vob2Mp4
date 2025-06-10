run:
	@chmod -R 777 ./input/VIDEO_TS/
	@docker compose build
	@docker compose run --rm app

.PHONY: run
