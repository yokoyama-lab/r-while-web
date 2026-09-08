# R-WHILE Playground — 開発用の 1 コンテナ構成。
# 本番（tetsuo.jp）は Apache + mod_php の上に rsync で配置しており、この
# イメージは使っていない。手元で動かすためのもの。

# ---- 1 段目: R-WHILE の処理系（OCaml + BNFC）を作る ----
FROM ubuntu:24.04 AS interpreter

# hadolint ignore=DL3008
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        bnfc \
        libextlib-ocaml-dev \
        make \
        ocaml \
        ocaml-findlib \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src
COPY src/ /src/
RUN make ri

# ---- 2 段目: アプリ本体 ----
FROM php:8.3-apache

# hadolint ignore=DL3008
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libonig-dev \
        libxml2-dev \
        unzip \
    && docker-php-ext-install -j"$(nproc)" mbstring dom \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Laravel のフロントコントローラは public/ にある。
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf \
    && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf \
    && a2enmod rewrite

WORKDIR /var/www/html

COPY composer.json ./
RUN composer install --no-dev --no-interaction --no-progress --no-scripts

COPY . .
COPY --from=interpreter /src/ri /var/www/html/bin/ri

RUN composer dump-autoload --optimize --no-interaction \
    && chown -R www-data:www-data storage bootstrap/cache

EXPOSE 80
