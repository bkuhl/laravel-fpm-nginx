# FPM/Nginx for Laravel

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

RUN composer install  --no-interaction --optimize-autoloader --no-dev --no-cache --prefer-dist
```

If you need to install node modules and compile frontend assets, you can use a node builder step in your Dockerfile, as shown here:

```
FROM node:18-alpine AS frontend

RUN mkdir -p /opt/patchbot
WORKDIR /opt/patchbot
ADD . .

RUN npm ci
RUN npm run production

FROM bkuhl/laravel-fpm-nginx:latest

WORKDIR /var/www/html

# Copy the application files to the container
ADD --chown=www-data:www-data  . /var/www/html

USER www-data

RUN composer install  --no-interaction --optimize-autoloader --no-dev --no-cache --prefer-dist

COPY --from=frontend /opt/patchbot/public/css public/css
COPY --from=frontend /opt/patchbot/public/js public/js
COPY --from=frontend /opt/patchbot/public/mix-manifest.json public/mix-manifest.json
```