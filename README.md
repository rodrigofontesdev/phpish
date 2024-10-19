# PHPISH

> [!IMPORTANT]
> TODO

# Prerequisites

-   Docker
-   Git

# Getting Started

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

Open an interactive shell for the **php-fpm service**:

```sh
docker exec -it example-app-php-fpm-1 sh
```

Now, you are able to create a new Laravel project inside the container. See the [How to Use section](#how-to-use).

# Features

-   [x] PHP 8.3
-   [x] Composer
-   [x] Nginx
-   [x] Supervisord
-   [x] PostgreSQL 16
-   [x] SQLite 3
-   [x] Node 20
-   [x] npm

# How to Use

In this part, you will learn how to work properly with the **PHPISH** and be able to interact correctly with your Laravel application.

### Install Laravel With Composer

Execute the follow command into the **php-fpm service** shell:

```sh
composer create-project laravel/laravel .
```

After the installation finish, open your browser and visit [http://localhost](http://localhost).

### Install Laravel With Laravel Installer

> [!IMPORTANT]
> TODO

### Clone an Existing Laravel Project

> [!IMPORTANT]
> TODO

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

# Todo

-   [ ] Check containers health on startup

# Built With

-   Docker

# License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE) file for details.
