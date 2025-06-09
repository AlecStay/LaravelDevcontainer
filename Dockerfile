FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libxml2-dev \
    libxslt1-dev \
    libicu-dev \
    libonig-dev \
    libpq-dev \
    zlib1g-dev \
    git \
    unzip \
    wget

# Instalar extensiones PHP necesarias para Laravel
RUN docker-php-ext-install \
    gd \
    pdo_pgsql \
    mbstring \
    bcmath \
    exif \
    pcntl \
    zip \
    intl \
    xml

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Crear usuario appuser (opcional para desarrollo)
ARG UID=1000
ARG GID=1000
RUN groupadd -g ${GID} appuser && \
    useradd -u ${UID} -g appuser -m appuser

USER appuser
WORKDIR /var/www
