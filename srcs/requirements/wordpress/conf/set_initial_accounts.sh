#!/bin/bash

# ln -s /usr/bin/php83 /usr/bin/php

echo "Installing wp core..."

wp core install --allow-root \
		--path=/var/www/ \
		--title=inception \
		--url=${DOMAIN_NAME} \
		--admin_user=${WP_ADM} \
		--admin_password=${WP_ADM_PASS} \
		--admin_email="aperis-p@42.fr"

# Setting database 
echo "Setting the database..."
wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbhost=mariadb --dbpass=$DB_PASS --allow-root

# Create admin user
echo "Creating admin user..."
wp user create "$WP_ADM" "$WP_ADM_EMAIL" --user_pass="$WP_ADM_PASS" --allow-root

# Create commom user
echo "Creating commom user..."
wp user create "$WP_COMMOM_USER" "$WP_COMMOM_USER_EMAIL" --user_pass="$WP_COMMOM_USER_PASS" --allow-root