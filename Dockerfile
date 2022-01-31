FROM bkuhl/fpm-nginx:8.0.7

RUN apk add --update --no-cache python3 \
    # allows us to build front-end dependencies
    yarn \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \

# Add default virtualhost
ADD ./default.conf /etc/nginx/conf.d/default.conf
