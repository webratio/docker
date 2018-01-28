#!/bin/sh

echo "Copy run-logrotate in 15 m periodic cron"
cp -f /run-logrotate.sh /etc/periodic/15min/

echo "Start crond"
#start cron
crond -b -d 2

echo "Start rsyslogd"
#start rsyslogd
rsyslogd -n