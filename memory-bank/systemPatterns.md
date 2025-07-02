# System Patterns

## Architecture Overview

PHPISH uses a microservices architecture with Docker Compose to orchestrate multiple specialized containers that work together to provide a complete Laravel development environment.

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│     nginx       │    │    php-fpm      │    │      node       │
│   (port 80)     │◄──►│   (port 8080)   │    │  (development)  │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                                │
                                ▼
                       ┌─────────────────┐    ┌─────────────────┐
                       │   postgresql    │    │     redis       │
                       │   (port 5432)   │    │   (port 6379)   │
                       └─────────────────┘    └─────────────────┘
```

## Core Design Patterns

### Multi-Stage Docker Build Pattern
The project uses a multi-stage build approach to optimize final image size:

1. **Factory Stage**: Builds and compiles all PHP extensions and tools
2. **Production Stage**: Copies only necessary artifacts from factory stage
3. **Temporary Storage**: Uses intermediate directory for extension management

**Benefits:**
- Smaller final image size
- Faster container startup
- Reduced attack surface (no build tools in final image)

### Service Separation Pattern
Each service has a dedicated container with specific responsibilities:

- **nginx**: HTTP server and reverse proxy
- **php-fpm**: PHP application processing
- **postgresql**: Primary database
- **redis**: Caching and session storage
- **node**: Frontend asset compilation

### Health Check Pattern
All services implement comprehensive health checks:

```yaml
healthcheck:
  test: [ "CMD-SHELL", "service-specific-check" ]
  interval: 30s
  timeout: 10s
  retries: 5
  start_period: 10s
```

**Implementation:**
- **PHP-FPM**: `php-fpm -t` configuration test
- **Nginx**: `curl -f http://localhost` connectivity test
- **PostgreSQL**: `pg_isready` database readiness
- **Redis**: `redis-cli ping` service availability

## Security Patterns

### Non-Root User Execution
All services run as non-root users for security:

- **PHP-FPM**: Runs as `www-data` user
- **Node**: Runs as `node` user
- **Supervisord**: Process management as non-root
- **File Permissions**: Proper ownership with `chown -R www-data:www-data`

### Secret Management Pattern
Sensitive data handled through Docker secrets:

```yaml
secrets:
  DB_DATABASE:
    environment: DB_DATABASE
  DB_USERNAME:
    environment: DB_USERNAME
  DB_PASSWORD:
    environment: DB_PASSWORD
```

**Benefits:**
- Prevents secrets in container environment variables
- Secure secret distribution to containers
- Environment-specific secret management

## Volume and Data Patterns

### Application Code Mounting
```yaml
volumes:
  - ./web:/var/www/html
```
- **Development**: Live code editing with immediate reflection
- **Consistency**: Same path across all containers that need application code

### Persistent Data Storage
```yaml
volumes:
  postgres-data:
  redis-data:
```
- **Data Persistence**: Database and cache data survives container restarts
- **Performance**: Optimized storage for database workloads

## Network Architecture

### Custom Network Pattern
```yaml
networks:
  mainnet:
```

**Benefits:**
- **Service Discovery**: Containers can communicate using service names
- **Isolation**: Application services isolated from host network
- **Security**: Internal communication doesn't traverse external networks

### Port Mapping Strategy
- **HTTP (80)**: Public web access
- **PHP-FPM (8080)**: Internal service communication
- **PostgreSQL (5432)**: Database client access
- **Redis (6379)**: Cache client access

## Configuration Management

### PHP Configuration Layering
1. **Base**: PHP development INI file
2. **Custom**: Additional configuration in `99_extra.ini`
3. **Extensions**: Dynamic extension loading

### Nginx Configuration
- **Custom Config**: `./docker/nginx/nginx.conf` mounted as default
- **Laravel Optimized**: Configured for Laravel routing and static assets
- **PHP-FPM Integration**: FastCGI configuration for PHP processing

## Process Management Pattern

### Supervisord Architecture
```ini
[supervisord]
nodaemon=true
user=www-data

[program:php-fpm]
command=php-fpm
```

**Benefits:**
- **Process Monitoring**: Automatic restart of failed processes
- **Non-Root Execution**: Secure process management
- **Single Container**: Multiple processes in PHP container

## Extension and Customization Patterns

### Configurable Build Arguments
```dockerfile
ARG PHP_VERSION=8.3
ARG COMPOSER_VERSION=2.8.9
ARG XDEBUG_VERSION=3.3.2
ARG REDIS_VERSION=6.1.0
```

**Benefits:**
- **Flexibility**: Support for different versions
- **Customization**: Teams can specify required versions
- **Future-Proofing**: Easy updates to new versions

### Extension Installation Pattern
1. **Compile**: Build extensions in factory stage
2. **Extract**: Copy compiled extensions to temporary location
3. **Install**: Move extensions to final image
4. **Enable**: Activate extensions in PHP configuration

This pattern ensures clean separation between build dependencies and runtime requirements. 