# Use official PHP image
FROM php:8.2-cli

# Set working directory
WORKDIR /app

# Install required PHP extensions and dependencies
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    && docker-php-ext-install pdo pdo_mysql

# Copy composer files before installing dependencies
COPY composer.json composer.lock ./

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install dependencies
RUN composer install --no-dev --optimize-autoloader

# Copy the rest of the project files
COPY . .

# Default command to run the seeding script
CMD ["php", "Faker.php"]