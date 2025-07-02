# Project Brief

## Project Overview

**PHPISH** is a pre-configured Docker development environment that enables Laravel developers to build apps faster by eliminating local setup requirements. It includes PHP, Nginx, PostgreSQL, Redis, and Node.js in a containerized stack, allowing developers to start coding immediately without installing or configuring anything locally.

## Core Mission

Eliminate the friction and complexity of Laravel development environment setup, enabling developers to focus on building applications rather than managing infrastructure.

## Key Value Propositions

### Zero Configuration Setup
- No local PHP, Composer, Node.js, database, or web server installation required
- One command to get a fully functional Laravel development environment
- Consistent environment across all team members and platforms

### Complete Development Stack
- **Backend**: PHP 8.3 with all necessary extensions
- **Frontend**: Node.js 22 with npm for asset compilation  
- **Database**: PostgreSQL 17 + SQLite 3 support
- **Caching**: Redis 8 for sessions and application caching
- **Web Server**: Nginx 1.28 optimized for Laravel applications

### Production-Ready Patterns
- Security-focused architecture (non-root users, secret management)
- Health checks and monitoring for all services
- Multi-stage Docker builds for optimized images
- Scalable microservices architecture

## Project Scope

### In Scope
- **Development Environment**: Complete Laravel development stack
- **Multiple Use Cases**: New projects, existing projects, learning, prototyping
- **Cross-Platform Support**: Windows, macOS, and Linux compatibility
- **Security Best Practices**: Non-root execution, secret management
- **Documentation**: Comprehensive guides for all features
- **Version Flexibility**: Configurable component versions

### Out of Scope (Current Version)
- Production deployment automation
- CI/CD pipeline integration
- Multi-application orchestration
- Custom domain management
- SSL/TLS certificate automation

## Success Criteria

### Developer Experience
- **Setup Time**: < 5 minutes from clone to working Laravel application
- **Learning Curve**: Minimal - standard Docker Compose commands
- **Platform Consistency**: Identical behavior across Windows, macOS, Linux

### Technical Quality
- **Reliability**: All services consistently healthy and operational
- **Security**: No services running as root, secure credential handling
- **Performance**: Optimized image sizes, fast startup times
- **Maintainability**: Clear architecture, comprehensive documentation

## Target Outcomes

### For Individual Developers
- Faster project startup and prototyping
- Consistent development environment across projects
- Reduced local machine complexity and conflicts

### For Development Teams
- Standardized development environments
- Faster developer onboarding
- Reduced "works on my machine" issues

### For Laravel Community
- Lower barrier to entry for new Laravel developers
- Standardized environment for tutorials and learning
- Reliable platform for open source contributions

## Project Evolution

### Current Phase: v2.0.0 Development
- **Focus**: Major architectural improvements and breaking changes
- **Status**: Release candidate preparation
- **Key Changes**: Directory restructure, service upgrades, security enhancements

### Future Phases
- **Production Support**: Production-ready configurations and deployment
- **Modular Architecture**: Optional service components
- **Advanced Features**: SSL/TLS, custom domains, advanced monitoring

This project brief serves as the foundation for all other memory bank documentation and guides decision-making throughout the development process.
