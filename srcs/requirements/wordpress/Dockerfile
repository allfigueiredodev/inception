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
    wget \
    unzip && \
    sed -i "s|listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|g" \
      /etc/${PHP_VERSION}/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" \
      /etc/${PHP_VERSION}/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" \
      /etc/${PHP_VERSION}/php-fpm.d/www.conf && \
    rm -f /var/cache/apk/*
WORKDIR /var/www/html/
RUN wget https://wordpress.org/latest.zip && \
    unzip latest.zip && \
    cp -rf wordpress/* . && \
    rm -rf wordpress latest.zip
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
COPY ./requirements/wordpress/conf/wp-config-create.sh .
COPY ./requirements/wordpress/conf/set_initial_accounts.sh .
RUN sh wp-config-create.sh && rm wp-config-create.sh && \
    sh set_initial_accounts.sh && rm set_initial_accounts.sh && \
    chmod -R 0777 wp-content && \
    wp core download --allow-root --path=/var/www/html
EXPOSE 9000
CMD ["/usr/sbin/php-fpm83", "-F"]
