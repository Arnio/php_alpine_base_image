FROM alpine:3.10
ENV PHP_VERSION=7.1
RUN set -x \
# create nginx user/group first, to be consistent throughout docker variants
    && addgroup -g 101 -S nginx \
    && adduser -S -D -H -u 101 -h /var/cache/nginx -s /sbin/nologin -G nginx -g nginx nginx
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone 
RUN apk update && \
    apk upgrade && \
    apk add openssl curl ca-certificates 

RUN printf "%s%s%s\n" \
"http://nginx.org/packages/alpine/v" \
`egrep -o '^[0-9]+\.[0-9]+' /etc/alpine-release` \
"/main" \
| tee -a /etc/apk/repositories 
RUN curl -o /tmp/nginx_signing.rsa.pub https://nginx.org/keys/nginx_signing.rsa.pub && mv /tmp/nginx_signing.rsa.pub /etc/apk/keys/
RUN apk add --no-cache composer \
            bash \
            nginx \
            git \
            unzip \
            php7=${PHP_VERSION} \
            php7-fpm=${PHP_VERSION} \
            php7-pdo_mysql=${PHP_VERSION} \
            php7-session=${PHP_VERSION} \
            php7-simplexml=${PHP_VERSION} \
            php7-xmlwriter=${PHP_VERSION} \
            php7-opcache=${PHP_VERSION} \
            php7-tokenizer=${PHP_VERSION} \
            php7-common=${PHP_VERSION} \
            php7-mbstring=${PHP_VERSION} \
            php7-xml=${PHP_VERSION} \
            php7-soap=${PHP_VERSION} \
            php7-dom=${PHP_VERSION} \
            php7-gd=${PHP_VERSION} \
            php7-json=${PHP_VERSION} \
            php7-xdebug=${PHP_VERSION} \
            php7-curl=${PHP_VERSION} && \
    rm -rf /var/cache/apk/* 

RUN mkdir -p /var/www/html /var/run/php/ && \
    sed -i -e 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php7/php.ini && \
    sed -i "s|;*memory_limit =.*|memory_limit = 256M|i" /etc/php7/php.ini

RUN curl -sS https://getcomposer.org/installer -o composer-setup.php && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer 

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./default /etc/nginx/conf.d/default.conf
COPY ./www.conf /etc/php7/php-fpm.d/www.conf
COPY ./start.sh /usr/local/bin/
COPY ./drush.sh /usr/local/bin/
COPY ./info.php /var/www/html/index.php
RUN chown -R nginx:nginx /var/www/html && \
    chmod u+x /usr/local/bin/start.sh && \
    chmod u+x /usr/local/bin/drush.sh
EXPOSE 80
ENTRYPOINT [ "start.sh" ]
