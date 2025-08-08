ARG PHP_VERSION=8.3

FROM php:${PHP_VERSION}-fpm-alpine AS factory

ARG XDEBUG_VERSION=3.3.2
ARG REDIS_VERSION=6.1.0
ARG COMPOSER_VERSION=2.8.9

RUN apk update --no-cache \
    && apk upgrade --no-cache \
    && apk add --no-cache \
    autoconf \
    g++ \
    icu-dev \
    libpq-dev \
    libzip-dev \
    linux-headers \
    make

RUN pecl install \
    redis-${REDIS_VERSION} \
    xdebug-${XDEBUG_VERSION} \
    && docker-php-ext-install \
    bcmath \
    intl \
    pcntl \
    pdo_mysql \
    pdo_pgsql \
    zip

RUN curl -sSL https://getcomposer.org/installer \
    | php -- --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION}

ARG PHP_TEMP_DIR=/tmp/php_extensions

RUN PHP_EXT_DIR=$(php-config --extension-dir) \
    && mkdir -p ${PHP_TEMP_DIR} \
    && cp ${PHP_EXT_DIR}/bcmath.so ${PHP_TEMP_DIR} \
    && cp ${PHP_EXT_DIR}/intl.so ${PHP_TEMP_DIR} \
    && cp ${PHP_EXT_DIR}/pcntl.so ${PHP_TEMP_DIR} \
    && cp ${PHP_EXT_DIR}/pdo_mysql.so ${PHP_TEMP_DIR} \
    && cp ${PHP_EXT_DIR}/pdo_pgsql.so ${PHP_TEMP_DIR} \
    && cp ${PHP_EXT_DIR}/redis.so ${PHP_TEMP_DIR} \
    && cp ${PHP_EXT_DIR}/xdebug.so ${PHP_TEMP_DIR} \
    && cp ${PHP_EXT_DIR}/zip.so ${PHP_TEMP_DIR}

FROM php:${PHP_VERSION}-fpm-alpine

RUN apk update --no-cache \
    && apk upgrade --no-cache \
    && apk add --no-cache \
    icu-libs \
    libpq \
    libzip \
    supervisor

ARG PHP_TEMP_DIR=/tmp/php_extensions

COPY --from=factory /usr/local/bin/composer /usr/local/bin/composer
COPY --from=factory ${PHP_TEMP_DIR} ${PHP_TEMP_DIR}

RUN PHP_EXT_DIR=$(php-config --extension-dir) \
    && cp ${PHP_TEMP_DIR}/bcmath.so ${PHP_EXT_DIR} \
    && cp ${PHP_TEMP_DIR}/intl.so ${PHP_EXT_DIR} \
    && cp ${PHP_TEMP_DIR}/pcntl.so ${PHP_EXT_DIR} \
    && cp ${PHP_TEMP_DIR}/pdo_mysql.so ${PHP_EXT_DIR} \
    && cp ${PHP_TEMP_DIR}/pdo_pgsql.so ${PHP_EXT_DIR} \
    && cp ${PHP_TEMP_DIR}/redis.so ${PHP_EXT_DIR} \
    && cp ${PHP_TEMP_DIR}/xdebug.so ${PHP_EXT_DIR} \
    && cp ${PHP_TEMP_DIR}/zip.so ${PHP_EXT_DIR} \
    && rm -rf ${PHP_TEMP_DIR}

RUN docker-php-ext-enable \
    bcmath \
    intl \
    pcntl \
    pdo_mysql \
    pdo_pgsql \
    redis \
    xdebug \
    zip

RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
RUN rm "$PHP_INI_DIR/php.ini-production"

COPY php/php.ini "$PHP_INI_DIR/conf.d/99_extra.ini"
COPY supervisord/supervisord.conf /etc/supervisord.conf

RUN chown -R www-data:www-data /var/log /run

USER www-data

ENV PATH="/home/www-data/.composer/vendor/bin:$PATH"

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
