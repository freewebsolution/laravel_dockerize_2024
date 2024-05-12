FROM php:8.3 as php

# Aggiorniamo il gestore pacchetti
RUN apt-get update -y

# Installiamo le dipendenze necessarie
RUN apt-get install -y unzip libpq-dev libcurl4-gnutls-dev

# Installiamo le estensioni PHP richieste per Laravel
RUN docker-php-ext-install pdo pdo_mysql
RUN docker-php-ext-enable pdo pdo_mysql

# Installiamo l'estensione bcmath
RUN docker-php-ext-install bcmath

# Installiamo e abilitiamo Xdebug per il debug delle nostre applicazioni PHP
RUN pecl install xdebug && docker-php-ext-enable xdebug

WORKDIR /var/www
COPY . .
COPY --from=composer:2.7.6 /usr/bin/composer /usr/bin/composer

ENV PORT=8000
ENTRYPOINT [ "Docker/entrypoint.sh" ]