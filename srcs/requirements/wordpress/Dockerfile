FROM alpine:3.20
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
    
#Copy all files inside the wordpress folder to the workdir "/var/www/html"
RUN cp -rf ./wordpress/* .

#Copy the script that will set up wordpress to inside the container
COPY ./requirements/wordpress/conf/my_script.sh .

#Make it executable
RUN chmod +x my_script.sh

#Set the container to listen on all network interfaces
RUN sed -i "s|listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|g" \ 
        /etc/${PHP_VERSION}/php-fpm.d/www.conf

#Let the 9000 port exposed
EXPOSE 9000

#Run PHP and set wordpress up
CMD ["sh", "-c", "/usr/sbin/php-fpm83 -F", "&&", "sh", "-c", "./my_script.sh" ]