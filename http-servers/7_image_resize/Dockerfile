FROM webdevops/nginx

COPY ./conf/default /opt/docker/etc/nginx/vhost.conf
COPY ./images /images

RUN mkdir -p /var/nginx/cache
RUN chown -R www-data /images && chown -R www-data /var/nginx/cache

WORKDIR /images
