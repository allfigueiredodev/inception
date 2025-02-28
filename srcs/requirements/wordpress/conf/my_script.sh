#! /bin/sh

wp config create --path=/var/www/html --dbname=${DB_NAME} --dbuser=${DB_USER} --dbpass=${DB_PASS} --dbhost=mariadb --allow-root
wp core install --url=https://${DOMAIN_NAME} --title=inception --admin_user=${WP_ADM} --admin_password=${WP_ADM_PASS} --admin_email=${WP_ADM_EMAIL} --path=/var/www/html --allow-root
wp user create ${WP_COMMOM_USER} ${WP_COMMOM_USER_EMAIL} --user_pass=${WP_COMMOM_USER_PASS} --path=/var/www/html --allow-root 
wp theme activate twentytwentyfour --allow-root