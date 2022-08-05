FROM php:8.1-fpm

ENV TZ="Europe/London"

# Update
RUN apt-get update -y
RUN apt-get upgrade -y

# Packages
RUN apt install -y nano git wget zip unzip libicu-dev zlib1g-dev libpng-dev libonig-dev curl libzip-dev libfreetype6-dev libjpeg-dev

# PHP Exts
RUN docker-php-ext-configure gd --with-jpeg
RUN docker-php-ext-install exif pdo_mysql intl opcache gd mysqli mbstring bcmath zip pcntl

# PHP Imagick
RUN apt install -y libmagickwand-dev --no-install-recommends && pecl install imagick && docker-php-ext-enable imagick

# PHP Redis
RUN pecl install -o -f redis && docker-php-ext-enable redis

# PHP FPM Settings
RUN echo "php_admin_value[memory_limit] = 512M" >> /usr/local/etc/php-fpm.d/www.conf
RUN echo "php_admin_value[upload_max_filesize] = 100M" >> /usr/local/etc/php-fpm.d/www.conf
RUN echo "php_admin_value[max_input_vars] = 5000" >> /usr/local/etc/php-fpm.d/www.conf
RUN echo "php_admin_value[max_execution_time] = 300" >> /usr/local/etc/php-fpm.d/www.conf

# PHP CLI Settings
RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini
RUN echo "memory_limit = 1024M" >> /usr/local/etc/php/php.ini
RUN echo "max_execution_time = 0" >> /usr/local/etc/php/php.ini

# Composer2
RUN cd /tmp; curl -sS https://getcomposer.org/installer -o composer-setup.php; php composer-setup.php --install-dir=/usr/bin --filename=composer

# Node16
RUN cd /tmp; curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt install -y nodejs

USER www-data