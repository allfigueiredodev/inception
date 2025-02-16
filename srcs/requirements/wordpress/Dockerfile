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
#     sed -i "s|listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|g" \
#       /etc/${PHP_VERSION}/php-fpm.d/www.conf && \
#     sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" \
#       /etc/${PHP_VERSION}/php-fpm.d/www.conf && \
#     sed -i "s|;listen.group = nobody|listen.group = nobody|g" \
#       /etc/${PHP_VERSION}/php-fpm.d/www.conf && \
#     rm -f /var/cache/apk/*
# WORKDIR /var/www/
# # RUN wget https://wordpress.org/latest.zip && \
# #     unzip latest.zip && \
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

# First install all required packages
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
unzip

# Configure PHP-FPM and increase memory limit
RUN sed -i "s|listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|g" /etc/${PHP_VERSION}/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" /etc/${PHP_VERSION}/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" /etc/${PHP_VERSION}/php-fpm.d/www.conf && \
    echo "php_admin_value[memory_limit] = 256M" >> /etc/${PHP_VERSION}/php-fpm.d/www.conf && \
    rm -f /var/cache/apk/*

WORKDIR /var/www/

# Install WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Create PHP symlink
RUN ln -s /usr/bin/php83 /usr/bin/php

# Download WordPress with increased memory limit
RUN php -d memory_limit=256M /usr/local/bin/wp && \
    wp core download --allow-root --path=/var/www/

WORKDIR /var/www/wordpress

COPY ./requirements/wordpress/conf/set_initial_accounts.sh .
COPY ./requirements/wordpress/conf/wp-config-create.sh .

RUN sh wp-config-create.sh && rm wp-config-create.sh && \
    sh set_initial_accounts.sh && rm set_initial_accounts.sh && \
    chmod -R 0777 wp-content

EXPOSE 9000

CMD ["/usr/sbin/php-fpm83", "-F"]