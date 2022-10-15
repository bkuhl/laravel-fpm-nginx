FROM bkuhl/fpm-nginx:8.1.10

# Add default virtualhost
ADD ./default.conf /etc/nginx/conf.d/default.conf
