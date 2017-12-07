# FPM/Nginx for Laravel

[![Build Status](https://travis-ci.org/bkuhl/laravel-fpm-nginx.svg?branch=master)](https://travis-ci.org/bkuhl/laravel-fpm-nginx)

This container is intended to run Laravel applications and build front-end dependencies.  It includes:
 
 * PHP-FPM
 * Yarn (uses nodejs/npm)
   
For non-Laravel applications, see [bkuhl/fpm-nginx](https://github.com/bkuhl/fpm-nginx).

For a container to run cron and other CLI tasks, check out [bkuhl/php](https://github.com/bkuhl/php).

## Example Dockerfile

```
FROM bkuhl/laravel-fpm-nginx:latest

WORKDIR /var/www/html

# Copy the application files to the container
ADD --chown=www-data:www-data  . /var/www/html

USER www-data

    # production-ready dependencies
RUN composer install  --no-interaction --optimize-autoloader --no-dev --prefer-dist \

    # keep the container light weight
    && rm -rf /home/www-data/.composer/cache \
    
    # compile front-end assets
    && yarn install \
    && yarn run production \
    && yarn cache clean

USER root
```
