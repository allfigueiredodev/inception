#!bin/sh
if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
cat << EOF > /var/www/wordpress/wp-config.php
<?php
define( 'DB_NAME', '${DB_NAME}' );
define( 'DB_USER', '${DB_USER}' );
define( 'DB_PASSWORD', '${DB_PASS}' );
define( 'DB_HOST', 'localhost' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );
define('FS_METHOD','direct');
\$table_prefix = 'wp_';
define( 'WP_DEBUG', false );
if ( ! defined( 'ABSPATH' ) ) {
define( 'ABSPATH', __DIR__ . '/' );}
require_once ABSPATH . 'wp-settings.php';
EOF
# su -s /bin/sh -p -c "wp config create --path=/var/www/wordpress --extra-php --dbname=wordpress --dbuser=${DB_USER} --dbhost=mariadb --dbpass=${DB_PASS}" www-data

# echo "Creating the database"
# wp db create --allow-root --path=wordpress
fi