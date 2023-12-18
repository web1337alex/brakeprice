FROM php:7.4-apache

# Установка необходимых модулей PHP
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libwebp-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libxpm-dev \
        libgmp-dev \
        libbz2-dev \
        libkrb5-dev \
        libicu-dev \
        libxml2-dev \
        libzip-dev \
        libcurl4-openssl-dev \
        libonig-dev \
        && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp --with-xpm \
        && docker-php-ext-install -j$(nproc) gd bcmath bz2 exif gettext gmp mysqli soap sockets xmlrpc zip intl opcache pdo pdo_mysql

# Активация модулей mod_rewrite и mod_headers для Apache
RUN a2enmod rewrite headers

# Установка Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

# Установка прав доступа для папок и файлов
RUN chmod -R 664 /var/www/html/ \
    && find /var/www/html/ -type d -exec chmod 775 {} \; \
    && chown -R www-data:www-data /var/www/html/ \
    && find /var/www/html -type d -exec chmod 755 {} \; \
    && find /var/www/html -type f -exec chmod 644 {} \;

# Настройка прав доступа и владельца для папки source/
RUN chmod -R 664 /var/www/html/ \
    && find /var/www/html/ -type d -exec chmod 775 {} \; \
    && chown -R www-data:www-data /var/www/html/

# Открытие портов
EXPOSE 80
