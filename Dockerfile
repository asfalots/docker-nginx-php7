FROM nginx

MAINTAINER Erwan Grooters

RUN echo "deb http://packages.dotdeb.org jessie all" > /etc/apt/sources.list.d/dotdeb.list
COPY dotdeb.gpg /tmp/ 
RUN apt-key add /tmp/dotdeb.gpg
RUN apt-get update && apt-get install -y php7.0 php7.0-fpm php7.0-curl php7.0-gd php7.0-intl php7.0-json php7.0-pgsql php7.0-phpdbg php7.0-redis php7.0-mysql

RUN sed -i "s/user *nginx/user nginx www-data/g" /etc/nginx/nginx.conf
COPY nginx_conf/* /etc/nginx/conf.d/
EXPOSE 80 443
COPY info.php /usr/share/nginx/html/
RUN rm -rf /tmp/*

CMD /bin/bash -c "service php7.0-fpm start; nginx -g 'daemon off;'"
