FROM alpine:3.19
ARG PHP_VERSION=php83 \
    DB_NAME \
    DB_USER \
    DB_PASS
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
    wget \
    unzip && \
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
      /etc/${PHP_VERSION}/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" \
      /etc/${PHP_VERSION}/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" \
      /etc/${PHP_VERSION}/php-fpm.d/www.conf && \
    rm -f /var/cache/apk/*
WORKDIR /var/www
RUN wget https://wordpress.org/latest.zip && \
    unzip latest.zip && \
    cp -rf wordpress/* . && \
    rm -rf wordpress latest.zip
COPY ./requirements/wordpress/conf/wp-config-create.sh .
RUN sh wp-config-create.sh && rm wp-config-create.sh && \
    chmod -R 0777 wp-content/
CMD ["/usr/sbin/php-fpm83", "-F"]
