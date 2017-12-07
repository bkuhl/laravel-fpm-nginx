FROM bkuhl/fpm-nginx:v7.2.0

RUN apk add --update --no-cache yarn \

    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \

# Add default virtualhost
# Still needs work
ADD ./default.conf /etc/nginx/conf.d/default.conf