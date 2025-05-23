FROM php:8.3-fpm-alpine

RUN apk update --no-cache \
    && apk upgrade --no-cache \
    && apk add --no-cache \
    autoconf \
    g++ \
    libpq-dev \
    linux-headers \
    make \
    supervisor \
    && pecl install \
    redis-6.1.0 \
    xdebug-3.3.2 \
    && docker-php-ext-install \
    pcntl \
    pdo_mysql \
    pdo_pgsql \
    && docker-php-ext-enable \
    redis \
    xdebug

RUN apk del \
    autoconf \
    g++ \
    linux-headers \
    make

RUN curl -sSL https://getcomposer.org/installer \
    | php -- --install-dir=/usr/local/bin --filename=composer

RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
RUN rm "$PHP_INI_DIR/php.ini-production"

COPY /php/php.ini "$PHP_INI_DIR/conf.d/99_extra.ini"
COPY /supervisord/supervisord.conf /etc/supervisord.conf

RUN chown -R www-data:www-data /var/log /run

USER www-data

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
