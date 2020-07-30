# docker-wireguard Makefile
#
build:
	docker-compose build

rebuild:
	docker-compose build --no-cache

keys:
	@docker run -it --rm wireguard:latest gen-key

shell:
	@docker run -it --rm wireguard:latest bash -l
