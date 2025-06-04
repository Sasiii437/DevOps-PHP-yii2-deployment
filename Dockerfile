FROM php:8.2-apache

# 1) Install PHP extensions needed by Yii2
RUN apt-get update && apt-get install -y \
    libsqlite3-dev libpng-dev libjpeg-dev libonig-dev libzip-dev libcurl4-openssl-dev libxml2-dev default-mysql-client \
  && docker-php-ext-install pdo pdo_mysql pdo_sqlite \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# 2) Install Composer inside the container
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# 3) Copy application code into container
COPY yii2-app/ /var/www/html/

WORKDIR /var/www/html

# 4) Install PHP dependencies (composer install will generate /var/www/html/vendor)
RUN composer install --no-interaction --optimize-autoloader

# 5) Expose port 8000 (PHP’s built-in server)
EXPOSE 8000

# 6) Default command: run PHP built-in server pointing at web/
CMD ["php", "-S", "0.0.0.0:8000", "-t", "web"]
