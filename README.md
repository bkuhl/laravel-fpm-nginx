# FPM/Nginx for Laravel

> [!WARNING]
> This project has been deprecated, we recommend using https://serversideup.net images instead.

This container is intended to run Laravel applications and build front-end dependencies.  Check out https://hub.docker.com/r/bkuhl/laravel-fpm-nginx for a full list of tags.  It includes:
 
 * PHP-FPM
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

RUN composer install  --no-interaction --optimize-autoloader --no-dev --no-cache --prefer-dist \
```

If you need to install frontend dependencies, you can do so using a builder container...

```
FROM node:18-alpine AS frontend

RUN mkdir -p /opt/app
WORKDIR /opt/app
ADD . .

RUN npm ci
RUN npm run production

FROM bkuhl/laravel-fpm-nginx:8.2.3

COPY --from=frontend /opt/app/public/css public/css
COPY --from=frontend /opt/app/public/js public/js
COPY --from=frontend /opt/app/public/fonts public/fonts
COPY --from=frontend /opt/app/public/mix-manifest.json public/mix-manifest.json

```
