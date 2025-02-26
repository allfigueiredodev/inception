#!/bin/bash
if [ ! -d "${VOLUMES_PATH}" ]; then
        echo "Creating data folder"
        mkdir -p ${VOLUMES_PATH}/mariadb
        mkdir -p ${VOLUMES_PATH}/wordpress
fi

if [ ! -d "/home/${USER}/var" ]; then
        echo "Creating var folder"
        mkdir -p ~/${USER}/var/www/html
fi

if ! grep -q "localhost ${LOGIN}.42.fr" /etc/hosts; then \
		sudo sed -i "2i\127.0.0.1\tlocalhost ${LOGIN}.42.fr" /etc/hosts; \
fi