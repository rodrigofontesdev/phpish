# Release Notes

## v2.0.0 - YYYY-MM-DD

### Added

- Check services health on startup
- Support for other PHP versions, Xdebug and Redis extension
- Support for other Composer versions
- Support for Laravel Reverb
- Enable bcmath, intl and zip in PHP extensions

### Changed

- **[Breaking Change]** Move application directory from `./app` to `./web`
- **[Breaking Change]** Upgrade Nginx to version 1.28
- **[Breaking Change]** Upgrade Node.js to version 22
- **[Breaking Change]** Upgrade PostgreSQL to version 17
- **[Breaking Change]** Upgrade Redis to version 8
- Optimize Docker image size
- Execute supervisord as non-root user

### Fixed

- Prevent PostgreSQL from receiving entire .env file content
- Load missing PHP extensions

## v1.3.0 - 2025-05-22

### Added

- Enable pcntl in PHP extensions

## v1.2.2 - 2025-05-22

### Fixed

- Protect against sensitive data leaks in containers

## v1.2.1 - 2025-02-28

### Fixed

- Composer download

## v1.2.0 - 2024-11-03

### Added

- Add Redis

### Changed

- Decrease `upload_max_filesize` in php.ini directives

### Removed

- Remove OPcache from PHP extensions

## v1.1.2 - 2024-10-18

### Fixed

- Run Node as non-root user

## v1.1.1 - 2024-10-16

### Fixed

- Start Postgres even without environment variables

## v1.1.0 - 2024-10-08

### Added

- Add PostgreSQL 16
- Add Node 20.18.0

### Changed

- Rename services name in docker-compose.yml

### Fixed

- Run Supervisord and PHP-FPM as non-root user

## v1.0.0 - 2024-10-02

Initial stable release.
