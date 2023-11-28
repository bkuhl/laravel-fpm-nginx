FROM bkuhl/fpm-nginx:8.3.0

# Add default virtualhost
ADD ./default.conf /etc/nginx/conf.d/default.conf
