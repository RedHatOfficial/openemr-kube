FROM registry.access.redhat.com/ubi8 as builder

RUN dnf update -y
RUN dnf install -y @php php-mysqlnd php-soap php-gd php-pecl-zip wget git npm && dnf clean all
RUN wget https://getcomposer.org/installer -O composer-installer.php
RUN wget https://raw.githubusercontent.com/openemr/openemr-devops/master/docker/openemr/5.0.3/php.ini https://raw.githubusercontent.com/openemr/openemr-devops/master/docker/openemr/5.0.3/openemr.conf
RUN php composer-installer.php --filename=composer --install-dir=/usr/local/bin

RUN git clone https://github.com/openemr/openemr.git --depth 1

WORKDIR openemr
RUN composer install --no-dev
RUN npm install --unsafe-perm \
    && npm run build
RUN composer global require phing/phing \
    && /root/.composer/vendor/bin/phing vendor-clean \
    && /root/.composer/vendor/bin/phing assets-clean \
    && composer global remove phing/phing \
    && composer dump-autoload -o \
    && composer clearcache \
    && npm cache clear --force \
    && rm -fr node_modules

FROM registry.access.redhat.com/ubi8
RUN dnf install -y @php php-mysqlnd php-soap php-gd httpd mod_ssl && dnf clean all
COPY --from=builder /php.ini /etc/php7/php.ini
COPY --from=builder /openemr /var/www/localhost/htdocs/openemr

COPY openemr.conf /etc/httpd/conf.d/openemr.conf
COPY ssl.conf /etc/httpd/conf.d/ssl.conf

# left-over from upstream, do we really need this?
ENV APACHE_LOG_DIR=/var/log/httpd

RUN chmod 0777 /run/httpd
RUN chmod 0770 /var/log/httpd

RUN sed -i 's/^Listen 80/Listen 8080/' /etc/httpd/conf/httpd.conf
CMD exec /usr/sbin/httpd -D FOREGROUND

EXPOSE 8080 8443
