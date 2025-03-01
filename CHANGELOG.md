# Release Notes

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
