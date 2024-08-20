#!/bin/bash

ln -s /usr/bin/php83 /usr/bin/php

# Create admin user
echo "Creating admin user..."
wp --version
wp user create "$WP_ADM" "$WP_ADM_EMAIL" --user_pass="$WP_ADM_PASS" --allow-root

# Create commom user
echo "Creating commom user..."
wp --version
wp user create "$WP_COMMOM_USER" "$WP_COMMOM_USER_EMAIL" --user_pass="$WP_COMMOM_USER_PASS" --allow-root
