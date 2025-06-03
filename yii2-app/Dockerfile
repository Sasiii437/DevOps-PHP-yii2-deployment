FROM php:8.2-apache

# Install system dependencies needed for PHP extensions
RUN apt-get update && apt-get install -y \
    libsqlite3-dev \
    libpng-dev \
    libjpeg-dev \
    libonig-dev \
    libzip-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    default-mysql-client \
    && docker-php-ext-install pdo pdo_mysql pdo_sqlite \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy app files
COPY . /var/www/html/

# Set working directory
WORKDIR /var/www/html

# Expose port
EXPOSE 8000

# Command to start built-in PHP server
CMD ["php", "-S", "0.0.0.0:8000", "-t", "web"]
