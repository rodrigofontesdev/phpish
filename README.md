# PHPISH

> [!IMPORTANT]
> TODO

# Prerequisites

-   Docker
-   Git

# Getting Started

-   Clone the repository (`git clone git@github.com:rodrigofontesdev/phpish.git example-app`)
-   Enter the project folder (`cd example-app`)
-   Run Docker containers (`docker compose up -d`)
-   Open an interactive shell on the PHP-FPM container (`docker exec -it example-app-php-fpm-1 sh`)
-   Install the Laravel Installer on the PHP-FPM container (`composer global require laravel/installer`)

# Features

-   [x] PHP 8.3
-   [x] Composer
-   [x] Nginx
-   [x] Supervisord
-   [x] PostgreSQL 16
-   [x] SQLite 3
-   [x] Node 20
-   [x] npm

# Todo

-   [ ] Check containers health on startup

# Built With

-   Docker

# License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE) file for details.
