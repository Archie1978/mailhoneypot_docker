FROM debian:stretch-slim 
#
# docker build -t idesi/mailhoneypot .
#
#
LABEL description "Honey mail server: catch mail"
	maintainer "VALMIR Chsitophe <christophe.valmir@idesi.fr>"

# RUN apk add --no-cache bash postfix dovecot postfix-pcre rsyslog roundcubemail apache2
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -y install apache2 postfix postfix-pcre rsyslog roundcube roundcube-sqlite3  dovecot-imapd dovecot-pop3d -qq && \
	mkdir /var/vmail&& chown dovecot:dovecot /var/vmail && chmod 02770 /var/vmail && a2ensite default-ssl && adduser postfix dovecot
#COPY start.sh	/start.sh
#COPY apache/000-default.conf /etc/apache2/sites-enabled/000-default.conf
#COPY roundcube/config.inc.php  /etc/roundcube/config.inc.php
#RUN chmod 640 /etc/roundcube/config.inc.php
#RUN chown root:www-data /etc/roundcube/config.inc.php
#COPY postfix/vmailbox		/etc/postfix/vmailbox.dist
#COPY postfix/vmaildomain	/etc/postfix/vmaildomain.dist
#COPY postfix/main.cf		/etc/postfix/main.cf
#COPY postfix/master.cf            /etc/postfix/master.cf
#COPY dovecot/10-mail.conf	/etc/dovecot/conf.d/10-mail.conf
#COPY dovecot/10-ssl.conf       /etc/dovecot/conf.d/10-ssl.conf
#COPY dovecot/10-mail-stack-delivery.conf	/etc/dovecot/conf.d/10-mail-stack-delivery.conf 
#COPY dovecot/auth-system.conf.ext		/etc/dovecot/conf.d/auth-system.conf.ext
#COPY fakesasl.sh		/usr/local/bin/fakesasl.sh
#COPY configure.pl		/configure.pl
COPY rootfs /
#RUN mkdir  /var/vmail && chown dovecot:dovecot  /var/vmail && chmod 02770 /var/vmail 
VOLUME /conf
CMD [ "/start.sh" ]
