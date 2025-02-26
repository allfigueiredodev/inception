# FROM alpine:3.19
# ARG PHP_VERSION=php83 \
#     DB_NAME \
#     DB_USER \
#     DB_PASS \
#     WP_COMMOM_USER \
#     WP_COMMOM_USER_EMAIL \
#     WP_COMMOM_USER_PASS \
#     WP_ADM \
#     WP_ADM_EMAIL \
#     WP_ADM_PASS 
# RUN apk update && apk upgrade && apk add --no-cache \
#     ${PHP_VERSION} \
#     ${PHP_VERSION}-fpm \
#     ${PHP_VERSION}-mysqli \
#     ${PHP_VERSION}-json \
#     ${PHP_VERSION}-curl \
#     ${PHP_VERSION}-dom \
#     ${PHP_VERSION}-exif \
#     ${PHP_VERSION}-fileinfo \
#     ${PHP_VERSION}-mbstring \
#     ${PHP_VERSION}-openssl \
#     ${PHP_VERSION}-xml \
#     ${PHP_VERSION}-zip \
#     ${PHP_VERSION}-phar \
#     ${PHP_VERSION}-common \
#     ${PHP_VERSION}-session \
#     ${PHP_VERSION}-iconv \
#     ${PHP_VERSION}-gd \
#     ${PHP_VERSION}-imap \
#     ${PHP_VERSION}-cgi \
#     ${PHP_VERSION}-pdo \
#     ${PHP_VERSION}-pdo_mysql \
#     ${PHP_VERSION}-soap \
#     ${PHP_VERSION}-posix \
#     ${PHP_VERSION}-tokenizer \
#     ${PHP_VERSION}-gettext \
#     ${PHP_VERSION}-ldap \
#     ${PHP_VERSION}-ctype \
#     ${PHP_VERSION}-simplexml \
#     fcgi \
#     wget \
#     unzip && \
#     sed -i "s|listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|g" \ // test this with and without it, because localhost is the default value, 0.0.0.0 is foreign
#       /etc/${PHP_VERSION}/php-fpm.d/www.conf && \
#     sed -i "s|;listen.owner = root|listen.owner = root|g" \
#       /etc/${PHP_VERSION}/php-fpm.d/www.conf && \
#     sed -i "s|;listen.group = root|listen.group = root|g" \
#       /etc/${PHP_VERSION}/php-fpm.d/www.conf && \
#     rm -f /var/cache/apk/*
# WORKDIR /var/www/
# # RUN wget https://wordpress.org/latest.zip && \
# #     unzip latest.zip && \ // if I let the wordpress volume just as /var/www/ it will create the wordpress folder whe unzip it
# #     cp -rf wordpress/* . && \
# #     rm -rf wordpress latest.zip
# RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
#     chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
# RUN ln -s /usr/bin/php83 /usr/bin/php
# RUN wp core download --allow-root --path=/var/www/
# WORKDIR /var/www/wordpress
# COPY ./requirements/wordpress/conf/set_initial_accounts.sh .
# COPY ./requirements/wordpress/conf/wp-config-create.sh .
# RUN sh wp-config-create.sh && rm wp-config-create.sh && \
#     sh set_initial_accounts.sh && rm set_initial_accounts.sh && \
#     chmod -R 0777 wp-content
# EXPOSE 9000
# CMD ["/usr/sbin/php-fpm83", "-F"]

# Create nginx user/group and set ownership
# RUN addgroup -S nginx && adduser -S -G nginx nginx && \
#     chown -R nginx:nginx /var/www && \
#     echo "php_admin_value[memory_limit] = 256M" >> /etc/${PHP_VERSION}/php-fpm.d/www.conf && \
#     rm -f /var/cache/apk/*

# Configure PHP-FPM and increase memory limit
# RUN sed -i "s|listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|g" /etc/${PHP_VERSION}/php-fpm.d/www.conf && \
#     sed -i "s|user = nobody|user = nginx|g" /etc/${PHP_VERSION}/php-fpm.d/www.conf && \
#     sed -i "s|group = nobody|group = nginx|g" /etc/${PHP_VERSION}/php-fpm.d/www.conf && \
#     sed -i "s|listen.owner = nobody|listen.owner = nginx|g" /etc/${PHP_VERSION}/php-fpm.d/www.conf && \
#     sed -i "s|listen.group = nobody|listen.group = nginx|g" /etc/${PHP_VERSION}/php-fpm.d/www.conf
#     sed -i "s|listen.owner = root|listen.owner = root|g" /etc/${PHP_VERSION}/php-fpm.d/www.conf && \
#     sed -i "s|listen.group = root|listen.group = root|g" /etc/${PHP_VERSION}/php-fpm.d/www.conf && \
#     # Set PHP-FPM to run as nginx user (add to your Dockerfile)

# RUN adduser -S -G www-data www-data

# Download WordPress with increased memory limit
# RUN php -d memory_limit=512M /usr/local/bin/wp core download --allow-root --path=/var/www
# RUN php -d memory_limit=512M /usr/local/bin/wp core download --path=/var/www/wordpress --allow-root

# RUN chown -R www-data:www-data /var/www 

# COPY ./requirements/wordpress/conf/wp-config-create.sh .
# RUN sh wp-config-create.sh && rm wp-config-create.sh

# RUN su -s /bin/sh -p -c "wp config create --path=/var/www/wordpress --dbname=wordpress --dbuser=${DB_USER} --dbhost=mariadb --dbpass=${DB_PASS}" www-data

# RUN su -s /bin/sh -p -c "wp --path=/var/www/wordpress core install \
#     --url=${DOMAIN_NAME} --title=inception --admin_user=${WP_ADM} --admin_password=${WP_ADM_PASS} \
#     --admin_email=${WP_ADM_EMAIL} --skip-email" www-data  

# RUN find /var/www/wordpress -type d -exec chmod g+s {} \; 
# RUN chmod g+w /var/www/wordpress/wp-content 
# RUN chmod -R g+w /var/www/wordpress/wp-content/themes 
# RUN chmod -R g+w /var/www/wordpress/wp-content/plugins

# COPY ./requirements/wordpress/conf/set_initial_accounts.sh .
# COPY ./requirements/wordpress/conf/wait-for-db.sh /usr/local/bin/

# COPY ./requirements/wordpress/conf/my_script.sh .

# sh set_initial_accounts.sh && rm set_initial_accounts.sh && \

# RUN sh set_initial_accounts.sh && \
# RUN chmod -R 0755 /var/www/wordpress/wp-content

# CMD ["/usr/sbin/php-fpm83", "-F"]


FROM alpine:3.19
ARG PHP_VERSION=php83 \
DB_NAME \
DB_USER \
DB_PASS \
WP_COMMOM_USER \
WP_COMMOM_USER_EMAIL \
WP_COMMOM_USER_PASS \
WP_ADM \
WP_ADM_EMAIL \
WP_ADM_PASS

RUN apk update && apk upgrade && apk add --no-cache \
${PHP_VERSION} \
${PHP_VERSION}-fpm \
${PHP_VERSION}-mysqli \
${PHP_VERSION}-json \
${PHP_VERSION}-curl \
${PHP_VERSION}-dom \
${PHP_VERSION}-exif \
${PHP_VERSION}-fileinfo \
${PHP_VERSION}-mbstring \
${PHP_VERSION}-openssl \
${PHP_VERSION}-xml \
${PHP_VERSION}-zip \
${PHP_VERSION}-phar \
${PHP_VERSION}-common \
${PHP_VERSION}-session \
${PHP_VERSION}-iconv \
${PHP_VERSION}-gd \
${PHP_VERSION}-imap \
${PHP_VERSION}-cgi \
${PHP_VERSION}-pdo \
${PHP_VERSION}-pdo_mysql \
${PHP_VERSION}-soap \
${PHP_VERSION}-posix \
${PHP_VERSION}-tokenizer \
${PHP_VERSION}-gettext \
${PHP_VERSION}-ldap \
${PHP_VERSION}-ctype \
${PHP_VERSION}-simplexml \
fcgi \
wget \
unzip \
mariadb-client

#Change work directory
WORKDIR /var/www/html

#Install WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

#Create PHP symlink
RUN ln -s /usr/bin/${PHP_VERSION} /usr/bin/php

#Download WP core
RUN wget https://wordpress.org/latest.zip && \
    unzip latest.zip

COPY ./requirements/wordpress/conf/my_script.sh .

RUN chmod +x my_script.sh

RUN sed -i "s|listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|g" \ 
      /etc/${PHP_VERSION}/php-fpm.d/www.conf

# # Create the wp-config file
# RUN wp config create --path=/var/www/wordpress \
#                      --dbname=${DB_NAME} --dbuser=${DB_USER} \
#                      --dbpass=${DB_PASS} --dbhost=localhost \
#                      --allow-root 

# # Install wp core using the wp-config file
# RUN wp core install --url=${DOMAIN_NAME} --title="inception" \
#                     --admin_user=${WP_ADM} --admin_password=${WP_ADM_PASS} \
#                     --admin_email=${WP_ADM_EMAIL} --path=/var/www/wordpress \
#                     --allow-root 

# # Create the main user using the wp cli
# RUN wp user create "${WP_COMMOM_USER}" "${WP_COMMOM_USER_EMAIL}" \
#                     --user_pass="${WP_COMMOM_USER_PASS}" \
#                     --allow-root \
#                     --path=/var/www/wordpress

EXPOSE 9000

#Run PHP
CMD ["sh", "-c", "/usr/sbin/php-fpm83 -F"]
# CMD ["sh", "-c", "tail -f /dev/null"]

#PHP Warning:  mysqli_real_connect(): php_network_getaddresses: getaddrinfo for mariadb failed: Name does not resolve in phar:///usr/local/bin/wp/vendor/wp-cli/config-command/src/Config_Command.php on line 234
