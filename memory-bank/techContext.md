# Technology Context

## Core Technology Stack

### Container Platform
- **Docker**: Container runtime and image building
- **Docker Compose**: Multi-container orchestration
- **Alpine Linux**: Base image for minimal footprint

### PHP Environment
- **PHP Version**: 8.3 (configurable via build args)
- **PHP-FPM**: FastCGI Process Manager for web applications
- **Composer**: 2.8.9 (configurable via build args)

### Web Server
- **Nginx**: 1.28-alpine
- **Configuration**: Custom Laravel-optimized configuration
- **FastCGI**: Integration with PHP-FPM

### Database Stack
- **PostgreSQL**: 17-alpine (primary database)
- **SQLite**: 3 (embedded database option)
- **Redis**: 8-alpine (caching and sessions)

### Frontend Tooling
- **Node.js**: 22-alpine
- **npm**: Package manager for frontend dependencies
- **User Context**: Runs as `node` user for security

### Development Tools
- **Xdebug**: 3.3.2 (configurable) for debugging
- **Supervisord**: Process management within containers

## PHP Extensions

### Core Extensions
- **bcmath**: Arbitrary precision mathematics
- **intl**: Internationalization support
- **pcntl**: Process control (for Laravel queues)
- **pdo_mysql**: MySQL database connectivity
- **pdo_pgsql**: PostgreSQL database connectivity
- **zip**: Archive handling

### Third-Party Extensions
- **redis**: Redis client (v6.1.0 configurable)
- **xdebug**: Debugging and profiling

## Port Configuration

### External Access
- **HTTP**: `80` → nginx web server
- **PostgreSQL**: `5432` → database client access
- **Redis**: `6379` → cache client access

### Internal Communication
- **PHP-FPM**: `8080` → nginx to PHP-FPM communication

## Development Environment Setup

### Prerequisites
- **Docker**: Latest stable version with Compose support
- **Git**: Version control for project cloning
- **System Requirements**: 
  - Minimum 4GB RAM recommended
  - 2GB available disk space for images and volumes

### Quick Start Commands
```bash
# Clone and setup
git clone git@github.com:rodrigofontesdev/phpish.git example-app
cd example-app
docker compose up -d

# Access containers
docker exec -it example-app-php-fpm-1 sh    # PHP environment
docker exec -it example-app-node-1 sh       # Node.js environment
```

## Build Arguments and Customization

### Configurable Versions
```dockerfile
ARG PHP_VERSION=8.3          # PHP version selection
ARG COMPOSER_VERSION=2.8.9   # Composer version
ARG XDEBUG_VERSION=3.3.2     # Xdebug version
ARG REDIS_VERSION=6.1.0      # Redis PHP extension version
```

### Environment Variables
```yaml
# Node.js environment
NODE_ENV: development

# PostgreSQL (via Docker secrets)
POSTGRES_DB_FILE: /run/secrets/DB_DATABASE
POSTGRES_USER_FILE: /run/secrets/DB_USERNAME  
POSTGRES_PASSWORD_FILE: /run/secrets/DB_PASSWORD
```

## File System Structure

### Application Directory
- **Path**: `./web/` (changed from `./app/` in v2.0.0)
- **Mount Point**: `/var/www/html` inside containers
- **Purpose**: Laravel application code and assets

### Configuration Files
```
docker/
├── Dockerfile              # Main application image
├── nginx/nginx.conf        # Nginx configuration
├── php/php.ini            # PHP additional settings
└── supervisord/supervisord.conf  # Process management
```

### Persistent Storage
```yaml
volumes:
  postgres-data:    # PostgreSQL data persistence
  redis-data:       # Redis data persistence
```

## Security Configuration

### User Management
- **PHP-FPM**: Runs as `www-data` (non-root)
- **Node.js**: Runs as `node` user (non-root)
- **Supervisord**: Process management as `www-data`

### Secret Management
- **Database Credentials**: Docker secrets instead of environment variables
- **File Permissions**: Proper ownership and permissions set
- **Image Security**: Multi-stage builds remove build dependencies

## Performance Considerations

### Image Optimization
- **Multi-stage Builds**: Separate build and runtime stages
- **Alpine Base**: Minimal base images for smaller size
- **Extension Management**: Efficient copying of compiled extensions

### Runtime Performance
- **Health Checks**: Ensure services are ready before accepting traffic
- **Volume Mounts**: Direct file system access for development
- **Network Isolation**: Custom network for service communication

## Development vs Production

### Current State
- **Development Focus**: Optimized for development workflow
- **Production Ready**: Planned for future versions
- **Configuration**: Development PHP settings enabled

### Planned Production Features
- **Environment-specific configurations**
- **Production-optimized PHP settings**
- **Security hardening for production deployment**

## Technical Constraints

### Version Dependencies
- **PHP 8.3+**: Modern PHP features and performance
- **Docker Compose v2**: Required for current syntax
- **Host OS**: Windows 10+, macOS 10.14+, Linux kernel 3.10+

### Resource Requirements
- **Memory**: Minimum 4GB RAM (8GB recommended)
- **Storage**: 2GB for Docker images and volumes
- **Network**: Internet access for initial image building

### Known Limitations
- **Windows**: File permission handling differences
- **Performance**: Volume mounts slower on Windows/macOS
- **Resource Usage**: Multiple containers consume more resources than native development 