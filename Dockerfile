FROM bkuhl/fpm-nginx:8.4.5

# Add default virtualhost
ADD ./default.conf /etc/nginx/conf.d/default.conf
