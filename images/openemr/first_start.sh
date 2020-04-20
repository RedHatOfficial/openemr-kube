#!/bin/bash
set -x -e -o pipefail


auto_setup() {
    CONFIGURATION="server=${MYSQL_HOST} rootpass=${MYSQL_ROOT_PASS} loginhost=%"
    if [ "$MYSQL_ROOT_USER" != "" ]; then
        CONFIGURATION="${CONFIGURATION} root=${MYSQL_ROOT_USER}"
    fi
    if [ "$MYSQL_USER" != "" ]; then
        CONFIGURATION="${CONFIGURATION} login=${MYSQL_USER}"
        CUSTOM_USER="$MYSQL_USER"
    else
        CUSTOM_USER="openemr"
    fi
    if [ "$MYSQL_PASS" != "" ]; then
        CONFIGURATION="${CONFIGURATION} pass=${MYSQL_PASS}"
        CUSTOM_PASSWORD="$MYSQL_PASS"
    else
        CUSTOM_PASSWORD="openemr"
    fi
    if [ "$MYSQL_DATABASE" != "" ]; then
        CONFIGURATION="${CONFIGURATION} dbname=${MYSQL_DATABASE}"
        CUSTOM_DATABASE="$MYSQL_DATABASE"
    else
        CUSTOM_DATABASE="openemr"
    fi
    if [ "$OE_USER" != "" ]; then
        CONFIGURATION="${CONFIGURATION} iuser=${OE_USER}"
    fi
    if [ "$OE_PASS" != "" ]; then
        CONFIGURATION="${CONFIGURATION} iuserpass=${OE_PASS}"
    fi

    php auto_configure.php -f ${CONFIGURATION} || return 1

    echo "OpenEMR configured."
    CONFIG=$(php -r "require_once('/var/www/localhost/htdocs/openemr/sites/default/sqlconf.php'); echo \$config;")
    if [ "$CONFIG" == "0" ]; then
        echo "Error in auto-config. Configuration failed."
        exit 2
    fi

    #Turn on API from docker
    if [ "$ACTIVATE_API" == "yes" ]; then
        mysql -u "$CUSTOM_USER"  --password="$CUSTOM_PASSWORD" -h "$MYSQL_HOST" -e "UPDATE globals SET gl_value = 1 WHERE gl_name = \"rest_api\"" "$CUSTOM_DATABASE"
    fi
}


[ -d /var/www/localhost/htdocs/openemr/sites/default/ ] || cp -a /var/www/localhost/htdocs/openemr/sites-seed/* /var/www/localhost/htdocs/openemr/sites

echo "Running quick setup!"

while ! auto_setup; do
    echo "Couldn't set up. Any of these reasons could be what's wrong:"
    echo " - You didn't spin up a MySQL container or connect your OpenEMR container to a mysql instance"
    echo " - MySQL is still starting up and wasn't ready for connection yet"
    echo " - The Mysql credentials were incorrect"
    sleep 1;
done
echo "Setup Complete!"
