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

# Открытие портов
EXPOSE 80