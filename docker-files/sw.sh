#!/bin/bash

SW_PHAR="/tmp/sw.phar"
PHP_BIN=`which php`
RUN="sh -c"
PARAMS=""
INSTALL_LOCK="/sw.lock"

if [ ! -f $INSTALL_LOCK ]; then

        if [ "" == "$DONT_INSTALL" ]; then
                curl -o $SW_PHAR http://shopwarelabs.github.io/sw-cli-tools/sw.phar

                [[ "" != "$SW_VERSION" ]] && PARAMS="$PARAMS --release=$SW_VERSION" || PARAMS="$PARAMS --release=latest";

                [[ "" != "$DB_HOST" ]] && PARAMS="$PARAMS --db-host=$DB_HOST";
                [[ "" != "$DB_PORT" ]] && PARAMS="$PARAMS --db-port=$DB_PORT";
                [[ "" != "$DB_USER" ]] && PARAMS="$PARAMS --db-user=$DB_USER";
                [[ "" != "$DB_PASSWORD" ]] && PARAMS="$PARAMS --db-password=$DB_PASSWORD";
                [[ "" != "$DB_NAME" ]] && PARAMS="$PARAMS --db-name=$DB_NAME";

                [[ "" != "$SHOP_LOCALE" ]] && PARAMS="$PARAMS --shop-locale=$SHOP_LOCALE";
                [[ "" != "$SHOP_HOST" ]] && PARAMS="$PARAMS --shop-host=$SHOP_HOST";
                [[ "" != "$SHOP_PATH" ]] && PARAMS="$PARAMS --shop-path=$SHOP_PATH";
                [[ "" != "$SHOP_NAME" ]] && PARAMS="$PARAMS --shop-name=$SHOP_NAME";
                [[ "" != "$SHOP_EMAIL" ]] && PARAMS="$PARAMS --shop-email=$SHOP_EMAIL";
                [[ "" != "$SHOP_CURRENCY" ]] && PARAMS="$PARAMS --shop-currency=$SHOP_CURRENCY";

                [[ "" != "$ADMIN_USERNAME" ]] && PARAMS="$PARAMS --admin-username=$ADMIN_USERNAME";
                [[ "" != "$ADMIN_PASSWORD" ]] && PARAMS="$PARAMS --admin-password=$ADMIN_PASSWORD";
                [[ "" != "$ADMIN_EMAIL" ]] && PARAMS="$PARAMS --admin-email=$ADMIN_EMAIL";
                [[ "" != "$ADMIN_LOCALE" ]] && PARAMS="$PARAMS --admin-locale=$ADMIN_LOCALE";
                [[ "" != "$ADMIN_NAME" ]] && PARAMS="$PARAMS --admin-name=$ADMIN_NAME";

                $RUN "$PHP_BIN $SW_PHAR install:release --install-dir=/var/www/html/ $PARAMS"
                chown -R www-data:www-data /var/www/html
        fi

        echo $PARAMS;

        touch $INSTALL_LOCK;
fi
apache2-foreground