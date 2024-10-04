FROM php:8.3-fpm-alpine

WORKDIR /var/www/html

RUN apk update --no-cache \
    && apk upgrade --no-cache \
    && apk add --no-cache \
        autoconf \
        curl \
        freetype-dev \
        g++ \
        icu-dev \
        imagemagick-dev \
        imap-dev \
        libjpeg-turbo-dev \
        libmemcached-dev \
        libpng-dev \
        libpq-dev \
        libwebp-dev\
        libxml2-dev \
        libzip-dev \
        linux-headers \
        make \
        zlib-dev \
    && pecl install \
        imagick-3.7.0 \
        memcache-8.2 \
        memcached-3.2.0 \
        redis-6.0.2 \
        xdebug-3.3.2 \
    && docker-php-ext-configure \
        gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install \
        bcmath \
        exif \
        gd \
        imap \
        intl \
        opcache \
        pdo_mysql \
        pdo_pgsql \
        soap \
        zip \
    && docker-php-ext-enable \
        imagick \
        memcache \
        memcached \
        redis \
        opcache \
        xdebug \
    && curl -sSL https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && apk add --no-cache nodejs npm \
    && npm install -g npm \
    && npm install -g pnpm

RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
