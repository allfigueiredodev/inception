name = inception
LOGIN=aperis-p
VOLUMES_PATH=/home/${LOGIN}/data

export VOLUMES_PATH
export LOGIN

all:
	@printf "Launch configuration ${name}...\n"
	@bash srcs/requirements/wordpress/tools/set_up.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --force-recreate 

build:
	@printf "Building configuration ${name}...\n"
	@bash srcs/requirements/tools/set_up.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build --force-recreate 

down:
	@printf "Stopping configuration ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down

re: fclean
	@printf "Rebuild configuration ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

clean: down
	@printf "Cleaning configuration ${name}...\n"
	@docker system prune -a
	@sudo rm -rf ${VOLUMES_PATH}/wordpress/*
	@sudo rm -rf ${VOLUMES_PATH}/mariadb/*

fclean:
	@printf "Total clean of all configurations docker\n"
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@docker volume rm $(shell docker volume ls -q)
	@sudo rm -rf ${VOLUMES_PATH}/wordpress/*
	@sudo rm -rf ${VOLUMES_PATH}/mariadb/*
	@sudo rm -rf ${VOLUMES_PATH}/
	@sudo rm -rf /home/${LOGIN}/var

.PHONY	: all build down re clean fclean
