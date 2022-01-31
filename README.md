# FPM/Nginx for Laravel

This container is intended to run Laravel applications and build front-end dependencies.  Check out https://hub.docker.com/r/bkuhl/laravel-fpm-nginx for a full list of tags.  It includes:
 
 * PHP-FPM
 * Yarn (uses nodejs/npm)
 * xdebug (when enabled)
 * opcache (when in production)
   
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
RUN composer install  --no-interaction --optimize-autoloader --no-dev --no-cache --prefer-dist \
    
    # compile front-end assets
    && yarn install \
    && yarn run production \
    && yarn cache clean
```
