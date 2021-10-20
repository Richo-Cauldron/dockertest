FROM php:8.0.5-fpm-alpine

RUN docker-php-ext-install pdo pdo_mysql bcmath

RUN mkdir -p /var/www/html

WORKDIR /var/www/html

RUN apk --no-cache add pcre-dev ${PHPIZE_DEPS}\
    && pecl install redis \
    && docker-php-ext-enable redis \
    && apk del pcre-dev ${PHPIZE_DEPS}

RUN apk --no-cache add shadow && usermod -u 1000 www-data && groupmod -g 1000 www-data