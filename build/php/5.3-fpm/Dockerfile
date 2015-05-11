FROM debian:jessie
# persistent / runtime deps
RUN apt-get update && apt-get install -y ca-certificates curl libpcre3 librecode0 libsqlite3-0 libxml2 --no-install-recommends && rm -r /var/lib/apt/lists/*

# phpize deps
RUN apt-get update && apt-get install -y autoconf file gcc libc-dev make pkg-config re2c --no-install-recommends && rm -r /var/lib/apt/lists/*

ENV PHP_INI_DIR /usr/local/etc/php
RUN mkdir -p $PHP_INI_DIR/conf.d

ENV PHP_EXTRA_CONFIGURE_ARGS --enable-fpm --with-fpm-user=www-data --with-fpm-group=www-data
# ENV PHP_EXTRA_BUILD_DEPS libmysqlclient-dev

ENV GPG_KEYS 0B96609E270F565C13292B24C13C70B87267B52D 0A95E9A026542D53835E3F3A7DEC4E69FC9C83D7
RUN set -xe \
 && for key in $GPG_KEYS; do \
  gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
 done

ENV PHP_VERSION 5.3.29

# --enable-mysqlnd is included below because it's harder to compile after the fact the extensions are (since it's a plugin for several extensions, not an extension in itself)
RUN buildDeps=" \
    $PHP_EXTRA_BUILD_DEPS \
    bzip2 \
    libcurl4-openssl-dev \
    libpcre3-dev \
    libreadline6-dev \
    librecode-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-dev \
  " \
  && set -x \
  && apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/* \
  && curl -SL "http://php.net/get/php-$PHP_VERSION.tar.bz2/from/this/mirror" -o php.tar.bz2 \
  && curl -SL "http://php.net/get/php-$PHP_VERSION.tar.bz2.asc/from/this/mirror" -o php.tar.bz2.asc \
  && gpg --verify php.tar.bz2.asc \
  && mkdir -p /usr/src/php \
  && tar -xof php.tar.bz2 -C /usr/src/php --strip-components=1 \
  && rm php.tar.bz2* \
  && cd /usr/src/php \
  && ./configure \
    --with-config-file-path="$PHP_INI_DIR" \
    --with-config-file-scan-dir="$PHP_INI_DIR/conf.d" \
    $PHP_EXTRA_CONFIGURE_ARGS \
    --disable-cgi \
    --enable-mysqlnd \
    --with-mysql=mysqlnd \
    --with-mysqli=mysqlnd \
    --with-pdo-mysql=mysqlnd \
    --with-curl \
    --with-readline \
    --with-recode \
    --with-zlib \
  && make -j"$(nproc)" \
  && make install \
  && { find /usr/local/bin /usr/local/sbin -type f -executable -exec strip --strip-all '{}' + || true; } \
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false $buildDeps \
  && make clean

COPY docker-php-ext-* /usr/local/bin/

WORKDIR /var/www/html
COPY php-fpm.conf /usr/local/etc/

EXPOSE 9000
CMD ["php-fpm"]

###############################################################
# Above adapted from php:5.4-fpm, below are my customizations
###############################################################

# required libs for extensions
RUN apt-get update && apt-get install -y \
        build-essential wget libmemcached-dev \
        zlib1g-dev libpng12-dev less \
    && rm -rf /var/lib/apt/lists/*

# memcached extension
RUN echo '' | pecl install memcached
RUN echo "extension=memcached.so" > /usr/local/etc/php/conf.d/ext-memcached.ini

RUN docker-php-ext-install mbstring \
    && docker-php-ext-install gd \
    && docker-php-ext-install exif \
    && docker-php-ext-install gettext

# WP CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# xdebug requires php 5.4+