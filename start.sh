#!/bin/bash

/configure.pl

rm -f /var/run/rsyslogd.pid

/etc/init.d/postfix start
/etc/init.d/dovecot start
apache2ctl start

exec rsyslogd -n
