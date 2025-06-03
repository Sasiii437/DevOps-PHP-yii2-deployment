# Use official PHP image with Apache and required extensions
FROM php:8.1-apache

# Install PHP extensions required by Yii2
RUN docker-php-ext-install pdo pdo_mysql mysqli

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy Yii2 app files to container
COPY . /var/www/html

# Set file permissions (optional, recommended)
RUN chown -R www-data:www-data /var/www/html

# Expose port 80
EXPOSE 80
