# Gunakan image dasar PHP versi 8.2
FROM php:8.2-fpm

# Install dependencies sistem
RUN apt-get update && apt-get install -y \
    git curl zip unzip libpng-dev libonig-dev libxml2-dev libzip-dev \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory di dalam container
WORKDIR /var/www

# Copy semua file project Laravel ke container
COPY . .

# Install dependency Laravel
RUN composer install

# Set permission folder storage dan bootstrap/cache
RUN chmod -R 775 storage bootstrap/cache

# Jalankan server Laravel default
CMD php artisan serve --host=0.0.0.0 --port=8000

# Expose port 8000 agar bisa diakses dari luar
EXPOSE 8000
