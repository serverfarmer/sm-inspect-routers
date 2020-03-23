#!/bin/sh

if grep -q /opt/farm/mgr/inspect-routers/cron /etc/crontab; then
	sed -i -e "/\/opt\/farm\/mgr\/inspect-routers\/cron/d" /etc/crontab
fi
