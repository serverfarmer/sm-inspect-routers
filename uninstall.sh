#!/bin/sh

if grep -q /opt/farm/ext/inspect-routers/cron /etc/crontab; then
	sed -i -e "/\/opt\/farm\/ext\/inspect-routers\/cron/d" /etc/crontab
fi
