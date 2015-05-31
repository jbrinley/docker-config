FROM php:5.5-apache

# for compatibility with boot2docker mounts
RUN usermod -u 1000 www-data

# required libs for extensions
RUN apt-get update && apt-get install -y \
        build-essential wget libmemcached-dev \
        zlib1g-dev libpng12-dev less \
    && rm -rf /var/lib/apt/lists/*

# memcached extension
RUN echo '' | pecl install memcached
RUN echo "extension=memcached.so" > /usr/local/etc/php/conf.d/ext-memcached.ini

# xdebug extension
RUN pecl install xdebug
COPY ext-xdebug.ini /usr/local/etc/php/conf.d/ext-xdebug.ini

RUN docker-php-ext-install mbstring \
    && docker-php-ext-install gd \
    && docker-php-ext-install exif \
    && docker-php-ext-install gettext \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install opcache \
    && docker-php-ext-install pdo_mysql

RUN a2enmod rewrite

RUN echo "\nInclude /etc/apache2/sites-enabled/*" >> /etc/apache2/apache2.conf
RUN echo "\n<Directory /srv/www/>\n\tOptions Indexes FollowSymLinks\n\tAllowOverride All\n\tRequire all granted\n</Directory>" >> /etc/apache2/apache2.conf

# WP CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp
