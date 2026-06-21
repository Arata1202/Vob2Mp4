run:
	@chmod -R 777 ./input/
	@docker compose build
	@docker compose run --rm app

.PHONY: run
