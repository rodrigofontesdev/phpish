FROM php:8.3-fpm-alpine

ARG NODE_VERSION=20

WORKDIR /var/www/html

RUN apk update && apk upgrade --no-cache \
    && apk add --no-cache \
        curl \
        git \
        libzip-dev \
        zip \
        unzip \
        sqlite-dev \
        libpq-dev \
        # postgresql-client \
        # mariadb-client \
        # mariadb \
        memcached \
        oniguruma-dev \
        icu-dev \
        imagemagick-dev \
        g++ \
        make \
        autoconf \
        libxml2-dev \
        libpng-dev \
        linux-headers \
    && docker-php-ext-install \
        pdo_mysql \
        pdo_sqlite \
        pdo_pgsql \
        bcmath \
        gd \
        mbstring \
        xml \
        intl \
    && pecl install imagick redis xdebug \
    && docker-php-ext-enable \
        imagick \
        redis \
        xdebug \
    && curl -sLS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && alias composer='php /usr/local/bin/composer' \
    && apk add --no-cache nodejs npm \
    && npm install -g npm \
    && npm install -g pnpm \
    && apk del --no-cache

EXPOSE 80/tcp



# RUN apt-get update && apt-get install -y \
#     curl \
#     git \
#     unzip \
#     libzip-dev \
#     libonig-dev \
#     libxml2-dev \
#     libpq-dev \
#     imagemagick \
#     mariadb-client \
#     && docker-php-ext-install \
#     pdo_mysql \
#     pdo_sqlite \
#     pdo_pgsql \
#     zip \
#     bcmath \
#     exif \
#     gd \
#     mbstring \
#     openssl \
#     xml \
#     opcache \
#     && pecl install redis \
#     && docker-php-ext-enable redis
