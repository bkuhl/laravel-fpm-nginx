FROM bkuhl/fpm-nginx:8.2.6

# Add default virtualhost
ADD ./default.conf /etc/nginx/conf.d/default.conf
