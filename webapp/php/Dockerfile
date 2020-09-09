FROM php:7.3-apache


RUN apt-get update && apt-get install -y git unzip wget gnupg && apt-get clean

# debugger
RUN pecl install xdebug apcu && docker-php-ext-enable xdebug apcu

# newrelic
ARG NEWRELIC_KEY
ARG NEWRELIC_APP_NAME
RUN echo 'deb http://apt.newrelic.com/debian/ newrelic non-free' | tee /etc/apt/sources.list.d/newrelic.list
RUN wget -O- https://download.newrelic.com/548C16BF.gpg | apt-key add -
RUN apt-get update && apt-get -y install newrelic-php5 && NR_INSTALL_SILENT=1 newrelic-install install
RUN sed -i \
    -e "s/REPLACE_WITH_REAL_KEY/$NEWRELIC_KEY/" \
    -e "s/newrelic.appname[[:space:]]=[[:space:]].*/newrelic.appname=\"${NEWRELIC_APP_NAME}\"/" \
    -e '$anewrelic.transaction_tracer.explain_threshold=0' \
    -e '$anewrelic.transaction_tracer.stack_trace_threshold=100' \
    -e '$anewrelic.transaction_tracer.threshold=100'\
    -e '$anewrelic.distributed_tracing_enabled=true' \
        $(php -r "echo(PHP_CONFIG_FILE_SCAN_DIR);")/newrelic.ini

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_NO_INTERACTION 1

ADD php.ini /usr/local/etc/php/

RUN docker-php-ext-install pdo_mysql mysqli mbstring iconv

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN a2enmod rewrite

RUN sed -i 's/Listen 80/Listen 8000/' /etc/apache2/ports.conf
RUN sed -i 's/:80/:8000/' /etc/apache2/sites-available/000-default.conf
RUN sed -i 's_/var/www/html_/var/www/html/public_' /etc/apache2/sites-available/000-default.conf

ADD entrypoint.sh /var/www/html

CMD ["bash", "-xe", "entrypoint.sh"]
