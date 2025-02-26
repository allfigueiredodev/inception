#!/bin/bash

# echo "[WORDPRESS SETUP] Starting setup script..." >&2

# # Wait for MySQL to be ready
# # for i in {$i..30}; do
# #     if mysqladmin ping -h"mariadb" -u"${DB_USER}" -p"${DB_PASS}" ; then
# #         echo "[WORDPRESS SETUP] Database connection successful!" >&2
# #         break
# #     fi
# #     echo "[WORDPRESS SETUP] Waiting for database connection... ($i/30)" >&2
# # 	sleep 2
# # done

# echo "Installing wp core..."
# wp core install --allow-root \
# 		--path=/var/www \
# 		--title=inception \
# 		--url=${DOMAIN_NAME} \
# 		--admin_user=${WP_ADM} \
# 		--admin_password=${WP_ADM_PASS} \
# 		--admin_email=${WP_ADM_EMAIL}

# #Setting database 
# echo "Setting the database..."
# if [ ! -f wp-config.php ]; then
#     wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbhost=mariadb --dbpass=$DB_PASS --allow-root
# fi

# #Create commom user
# echo "Creating commom user..."
# wp user create "$WP_COMMOM_USER" "$WP_COMMOM_USER_EMAIL" --user_pass="$WP_COMMOM_USER_PASS" --allow-root

# echo "[WORDPRESS SETUP] Starting setup script..." >&2

# Wait for MariaDB to be ready (30 retries, 2s interval)
# max_retries=30
# retry_count=0
# while ! mysqladmin ping -h"mariadb" -u"${DB_USER}" -p"${DB_PASS}" --silent; do
#     retry_count=$((retry_count+1))
#     if [ $retry_count -ge $max_retries ]; then
#         echo "[WORDPRESS SETUP] ERROR: Database connection failed after $max_retries attempts" >&2
#         exit 1
#     fi
#     echo "[WORDPRESS SETUP] Waiting for database connection... ($retry_count/$max_retries)" >&2
#     sleep 2
# done
# echo "[WORDPRESS SETUP] Database connection successful!" >&2

# Proceed with WordPress installation
# echo "Installing wp core..."
# wp core install --allow-root \
#     --path=/var/www \
#     --title=inception \
#     --url=${DOMAIN_NAME} \
#     --admin_user=${WP_ADM} \
#     --admin_password=${WP_ADM_PASS} \
#     --admin_email=${WP_ADM_EMAIL}



# echo "Setting the database..."
# wp config create \
#     --dbname=${DB_NAME} \
#     --dbuser=${DB_USER} \
#     --dbhost=mariadb \
#     --dbpass=${DB_PASS} \
#     --allow-root \
#     --path=/var/www

echo "Creating common user..."
wp user create "${WP_COMMOM_USER}" "${WP_COMMOM_USER_EMAIL}" \
    --user_pass="${WP_COMMOM_USER_PASS}" \
    --allow-root \
    --path=/var/www/wordpress

# wp user create "${WP_COMMOM_USER}" "${WP_COMMOM_USER_EMAIL}" --user_pass="${WP_COMMOM_USER_PASS}" --allow-root --path=/var/www/wordpress/ // RIGHT COMMAND SYNTAX AND VALUES