FROM php:8.3-fpm-alpine

RUN apk update --no-cache \
    && apk upgrade --no-cache \
    && apk add --no-cache \
        autoconf \
        freetype-dev \
        g++ \
        icu-dev \
        libjpeg-turbo-dev \
        libmemcached-dev \
        libpng-dev \
        libpq-dev \
        libwebp-dev\
        libzip-dev \
        linux-headers \
        make \
        zlib-dev \
    && pecl install \
        memcached \
        redis \
        xdebug \
    && docker-php-ext-configure \
        gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install \
        bcmath \
        exif \
        gd \
        intl \
        opcache \
        pdo_mysql \
        pdo_pgsql \
        zip \
    && docker-php-ext-enable \
        memcached \
        redis \
        xdebug

RUN curl -sSL https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apk add --no-cache nodejs npm \
    && npm install -g npm

RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

EXPOSE 9000
