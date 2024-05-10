FROM php:8.0-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    adduser \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create a non-root user to run the application
ARG user=www-data
ARG group=www-data
ARG uid=1000
ARG gid=1000


# Set the working directory
WORKDIR /var/www

# Copy Laravel files to the container
COPY . /var/www

# Install Laravel dependencies
RUN composer install --no-scripts --optimize-autoloader --no-dev \
    && chown -R ${user}:${group} /var/www \
    && chmod -R 775 /var/www/storage /var/www/bootstrap/cache

# Switch to the non-root user
USER root

# Expose port 9000
EXPOSE 9000

# Command to run the PHP-FPM server
CMD ["php-fpm"]