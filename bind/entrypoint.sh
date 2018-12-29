#!/bin/sh
chown -c -R root:named /var/run/named
chmod -c ug+rwx /var/run/named

chown -c -R named /var/cache/bind
chmod -c -R u+rw /var/cache/bind

chgrp -c -R named /etc/bind
chmod -c -R g+r /etc/bind

[ -f /etc/bind/rndc.key ] || rndc-confgen -a -c /var/run/named/rndc.key -r /dev/urandom

# Run in foreground and log to STDERR (console):
exec /usr/sbin/named -c /etc/bind/named.conf -g -u named "$@"
