FROM bkuhl/fpm-nginx:8.2.4

# Add default virtualhost
ADD ./default.conf /etc/nginx/conf.d/default.conf
