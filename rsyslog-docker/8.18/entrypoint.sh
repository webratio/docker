#!/bin/sh

echo "Copy run-logrotate in 15 m periodic cron"
cp -f /run-logrotate /etc/periodic/15min/run-logrotate

echo "Start crond"
#start cron
crond -b -d 2

echo "Start rsyslogd"
#start rsyslogd
rsyslogd -n