# Product Context

## Why PHPISH Exists

PHPISH is a pre-configured Docker development environment designed to eliminate the common friction points Laravel developers face when setting up new projects or onboarding team members.

## Problems It Solves

### Development Environment Setup
- **Zero Local Dependencies**: No need to install PHP, Composer, Node.js, PostgreSQL, Redis, or Nginx locally
- **Version Consistency**: Ensures all team members use identical versions of all tools and services
- **Quick Start**: From clone to running Laravel application in minutes, not hours

### Common Development Pain Points
- **Configuration Complexity**: Pre-configured services with optimized settings
- **Service Integration**: PostgreSQL, Redis, and other services work out-of-the-box
- **Asset Building**: Node.js environment ready for Laravel Mix/Vite workflows
- **Database Flexibility**: Support for both PostgreSQL and SQLite

### Team Collaboration
- **Reproducible Environments**: Same environment across development, staging, and team members
- **Onboarding Speed**: New developers can contribute immediately without environment setup
- **Platform Independence**: Works consistently across Windows, macOS, and Linux

## How It Should Work

### Ideal Developer Experience
1. **Clone & Run**: `git clone` → `docker compose up -d` → working Laravel environment
2. **Instant Laravel**: Create new Laravel projects or clone existing ones without setup
3. **Full Stack Ready**: Frontend (Node.js), backend (PHP), database (PostgreSQL), and caching (Redis)
4. **Production-Like**: Environment mirrors production stack for better testing

### Key User Flows
- **New Laravel Project**: Use Composer within container to create fresh Laravel installation
- **Existing Project**: Clone Laravel project into `web/` directory and run dependencies
- **Asset Development**: Use Node.js container for npm workflows and asset compilation
- **Database Work**: Access PostgreSQL and Redis through exposed ports

## Target Users

### Primary Users
- **Laravel Developers**: Individuals and teams building Laravel applications
- **Development Teams**: Organizations needing consistent development environments
- **Laravel Beginners**: Developers new to Laravel who want to focus on learning, not setup

### Use Cases
- **Rapid Prototyping**: Quickly spin up Laravel applications for experiments
- **Client Projects**: Consistent environment for client work
- **Learning & Training**: Educational environments for Laravel workshops
- **Open Source Contributions**: Standardized environment for Laravel package development

## Success Metrics

### Developer Experience
- Time from clone to running Laravel application (target: < 5 minutes)
- Zero local dependency installation required
- Consistent behavior across all platforms

### Technical Quality
- All services healthy and properly configured
- Secure defaults (non-root users, secret management)
- Production-ready patterns and configurations 