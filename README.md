# PHPISH

Build Laravel applications faster with this pre-configured Docker environment. It includes PHP, Nginx, PostgreSQL, Redis, Node.js and more in a complete development stack, so you can start coding without installing or configuring anything locally.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Features](#features)
- [How to Use](#how-to-use)
  - [Install Laravel With Composer](#install-laravel-with-composer)
  - [Install Laravel With Laravel Installer](#install-laravel-with-laravel-installer)
  - [Clone an Existing Laravel Project](#clone-an-existing-laravel-project)
  - [Asset Bundling](#asset-bundling)
  - [Change PHP Configuration Settings](#change-php-configuration-settings)
  - [Change PHP Version and Build Arguments](#change-php-version-and-build-arguments)
  - [Add New PHP Extensions](#add-new-php-extensions)
  - [Use PostgreSQL as Database](#use-postgresql-as-database)
  - [Use Redis as Database](#use-redis-as-database)
  - [Use Laravel Reverb](#use-laravel-reverb)
  - [Customize Nginx Configuration](#customize-nginx-configuration)
- [Coming Soon](#coming-soon)
- [Built With](#built-with)
- [License](#license)

## Prerequisites

-   Docker

## Getting Started

Clone the repository into a new directory:

```sh
git clone git@github.com:rodrigofontesdev/phpish.git example-app
```

```sh
cd example-app
```

Run Docker services:

```sh
docker compose up -d
```

Now, you are able to create a new Laravel project inside the container. See the [How to Use section](#how-to-use).

## Features

-   [x] PHP 8.3
-   [x] Composer 2.8.9
-   [x] Nginx 1.28
-   [x] PostgreSQL 17
-   [x] SQLite 3
-   [x] Redis 8
-   [x] Node 22
-   [x] npm
-   [x] Supervisord
-   [x] WebSocket

## How to Use

In this part, you will learn how to work properly with the **PHPISH** and be able to interact correctly with your Laravel application.

> [!NOTE]
> It's not necessary to push the **PHPISH** files to your project's remote repository.

### Install Laravel With Composer

Open an interactive shell for the **php-fpm service**:

```sh
docker exec -it example-app-php-fpm-1 sh
```

Execute the follow command into the **php-fpm service** shell:

```sh
composer create-project laravel/laravel .
```

After the installation finish, open your browser and visit [http://localhost](http://localhost).

### Install Laravel With Laravel Installer

Open an interactive shell for the **php-fpm service**:

```sh
docker exec -it example-app-php-fpm-1 sh
```

Install the Laravel Installer globally:

```sh
composer global require laravel/installer
```

Create a new project:

```sh
laravel new .
```

After the installation finish, open your browser and visit [http://localhost](http://localhost).

### Clone an Existing Laravel Project

Ensure that you have the following folder structure:

```
example-app/
├── web/                <-- Your Laravel project goes here
│   ├── public/
│   │   └── index.php
│   └── ...
├── docker/
├── docker-compose.yml
└── README.md
```

Clone your existing Laravel project directly into the `web` directory:

```sh
git clone git@github.com:username/repo-name.git web
```

Open an interactive shell for the **php-fpm service**:

```sh
docker exec -it example-app-php-fpm-1 sh
```

Install the project dependencies.

```sh
composer install
```

After that dependencies are installed, open your browser and visit [http://localhost](http://localhost).

### Asset Bundling

Open an interactive shell for the **node service**:

```sh
docker exec -it example-app-node-1 sh
```

Now, you are capable to work with **npm**.

```sh
npm install
```

```sh
npm run dev
```

```sh
npm run build
```

### Change PHP Configuration Settings

You can customize the PHP configuration by editing the `docker/php/php.ini` file. After making your changes, you must rebuild the Docker image to apply them:

```sh
docker compose up -d --build
```

### Change PHP Version and Build Arguments

You can change the PHP version and other build arguments by modifying the `docker-compose.yml` file. The following build arguments are available:

```yaml
php-fpm:
  image: phpish:dev
  build:
    context: ./docker
    args:
      PHP_VERSION: 8.3          # Change PHP version (8.1, 8.2, 8.3, etc.)
      COMPOSER_VERSION: 2.8.9   # Change Composer version
      XDEBUG_VERSION: 3.3.2     # Change Xdebug version
      REDIS_VERSION: 6.1.0      # Change Redis PHP extension version
```

After making changes, rebuild the image:

```sh
docker compose up -d --build
```

### Add New PHP Extensions

> [!WARNING]
> **Advanced Configuration**: Adding new PHP extensions requires modifying the Dockerfile and may cause compatibility issues. Only proceed if you understand Docker builds and PHP extension management. Always test in a development environment first.

This project uses a **multi-stage Docker build** with a `factory` stage for compiling extensions and a `production` stage for the final runtime image. To add new PHP extensions, follow this exact pattern used in the Dockerfile:

**Example: Adding GD extension for image manipulation**

1. **[FACTORY] Install dependencies and compile extension:**
   ```dockerfile
   RUN apk add --no-cache \
       freetype-dev \
       libjpeg-turbo-dev \
       libpng-dev \
       && docker-php-ext-configure gd --with-freetype --with-jpeg \
       && docker-php-ext-install gd
   ```

2. **[FACTORY] Copy extension to temporary directory:**
   ```dockerfile
   RUN PHP_EXT_DIR=$(php-config --extension-dir) \
       && cp ${PHP_EXT_DIR}/gd.so ${PHP_TEMP_DIR}
   ```

3. **[RUNTIME] Install runtime dependencies (if needed):**
   ```dockerfile
   RUN apk add --no-cache \
       freetype \
       libjpeg-turbo \
       libpng
   ```

4. **[RUNTIME] Copy extension from temporary directory:**
   ```dockerfile
   RUN PHP_EXT_DIR=$(php-config --extension-dir) \
       && cp ${PHP_TEMP_DIR}/gd.so ${PHP_EXT_DIR}
   ```

5. **[RUNTIME] Enable the extension:**
   ```dockerfile
   RUN docker-php-ext-enable gd
   ```

After modifying the Dockerfile, rebuild the image:

```sh
docker compose up -d --build
```

### Use PostgreSQL as Database

To connect your Laravel application to the PostgreSQL database, update your `.env` file with the following settings. The `DB_HOST` must be the name of the PostgreSQL service defined in `docker-compose.yml`, which is `postgresql`.

```env
DB_CONNECTION=pgsql
DB_HOST=postgresql
DB_PORT=5432
DB_DATABASE=laravel
DB_USERNAME=laravel
DB_PASSWORD=laravel
```

> [!NOTE]
> You can connect to the database from your local machine using a client like DBeaver. Use `localhost` as the host and `5432` as the port.

### Use Redis as Database

To use Redis for caching or session storage, update your `.env` file. The `REDIS_HOST` must be the name of the Redis service, which is `redis`.

**For Caching:**

```env
CACHE_DRIVER=redis
```

**For Session:**

```env
SESSION_DRIVER=redis
```

**Connection Settings:**

```env
REDIS_HOST=redis
REDIS_PASSWORD=null
REDIS_PORT=6379
```

### Use Laravel Reverb

This environment is ready to work with [Laravel Reverb](https://laravel.com/docs/reverb) for real-time WebSocket communication.

First, install Reverb via Composer:

```sh
composer require laravel/reverb
```

Publish the configuration file:

```sh
php artisan reverb:install
```

Next, update your `.env` file with the Reverb server configuration. The `REVERB_SERVER_HOST` must be `0.0.0.0` to accept connections from outside the container.

```env
REVERB_APP_ID=
REVERB_APP_KEY=
REVERB_APP_SECRET=
REVERB_SERVER_HOST=0.0.0.0
REVERB_SERVER_PORT=8080
REVERB_SERVER_TLS=false
```

Finally, configure your frontend by adding these variables to your `.env` file and updating `resources/js/bootstrap.js` as needed. The `VITE_REVERB_HOST` must be `localhost` to allow your browser to connect.

```env
VITE_REVERB_APP_KEY="${REVERB_APP_KEY}"
VITE_REVERB_HOST="localhost"
VITE_REVERB_PORT="${REVERB_SERVER_PORT}"
VITE_REVERB_SCHEME="http"
```

After configuration, start the Reverb server:

```sh
php artisan reverb:start
```

### Customize Nginx Configuration

You can customize the Nginx configuration by editing the `docker/nginx/nginx.conf` file. This file contains Laravel-optimized settings that you can modify for your specific needs. After making your changes, restart the Nginx container to apply them:

```sh
docker compose restart nginx
```

## Coming Soon

-   [ ] Production environment support
-   [ ] Modular service architecture (plug and play services)
-   [ ] SSL/TLS support for HTTPS development

## Built With

-   Docker

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE) file for details.
