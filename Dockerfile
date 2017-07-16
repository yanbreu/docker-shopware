FROM php:7.0-apache

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        unzip \
    && docker-php-ext-install -j$(nproc) iconv mcrypt zip pdo pdo_mysql \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && a2enmod rewrite \
    && curl -o ioncube.tar.gz https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz \
    && tar xfz ioncube.tar.gz \
    && mv ioncube/ioncube_loader_lin_7.0.so ioncube.so \
    && mv ioncube.so `php -i | grep "extension_dir" | awk 'NR==1{print $3}'` \
    && echo "zend_extension=ioncube.so" > /usr/local/etc/php/conf.d/docker-php-ext-ioncube.ini \
    && echo "memory_limit=256M" > /usr/local/etc/php/conf.d/docker-php-shopware.ini \
    && echo "upload_max_filesize=6M" >> /usr/local/etc/php/conf.d/docker-php-shopware.ini \
    && rm -Rf ioncube.tar.gz ioncube

ADD ./docker-files /install
CMD ["bash", "/install/sw.sh"]
