# PHPISH

Develop Laravel applications faster with this pre-configured Docker image. It includes PHP, Nginx, PostgreSQL and Redis, so you can start coding without installing or configuring anything locally.

## Prerequisites

-   Docker
-   Git

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
-   [x] Composer
-   [x] Nginx
-   [x] Supervisord
-   [x] PostgreSQL 16
-   [x] SQLite 3
-   [x] Redis
-   [x] Node 20
-   [x] npm

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

> [!IMPORTANT]
> TODO

### Clone an Existing Laravel Project

Clone your Laravel project into the `app` folder. Please, ensure that you have the following folder structure `/app/public/index.php`.

```sh
git clone git@github.com:username/repo-name.git app
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

> [!IMPORTANT]
> TODO

### Use PostgreSQL as Database

> [!IMPORTANT]
> TODO

### Use Redis as Database

> [!IMPORTANT]
> TODO

## Coming Soon

-   [ ] Check services health on startup
-   [ ] Work with others PHP versions
-   [ ] Use in production environment
-   [ ] Plug and play services

## Built With

-   Docker

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE) file for details.
