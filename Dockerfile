FROM php:7.2.9-fpm-alpine3.6
COPY composer-installer.sh  /opt/
RUN apk add --no-cache freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev zlib-dev \
  && sh /opt/composer-installer.sh \
  && docker-php-ext-configure gd \
    --with-gd \
    --with-freetype-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ && \
  NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
  && docker-php-ext-install -j${NPROC} gd \
  && apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev \
  && docker-php-ext-install -j5 mbstring mysqli pdo pdo_mysql shmop zip
