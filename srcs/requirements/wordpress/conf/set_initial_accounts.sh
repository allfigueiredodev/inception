#!/bin/bash

echo "Installing wp core..."
wp core install --allow-root \
		--path=/var/www/wordpress \
		--title=inception \
		--url=${DOMAIN_NAME} \
		--admin_user=${WP_ADM} \
		--admin_password=${WP_ADM_PASS} \
		--admin_email=${WP_ADM_EMAIL}

Setting database 
echo "Setting the database..."
if [ ! -f wp-config.php ]; then
    wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbhost=mariadb --dbpass=$DB_PASS --allow-root
fi

Create admin user
echo "Creating admin user..."
wp user create "$WP_ADM" "$WP_ADM_EMAIL" --user_pass="$WP_ADM_PASS" --allow-root


Create commom user
echo "Creating commom user..."
wp user create "$WP_COMMOM_USER" "$WP_COMMOM_USER_EMAIL" --user_pass="$WP_COMMOM_USER_PASS" --allow-root