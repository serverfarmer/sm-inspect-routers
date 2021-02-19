#!/bin/sh

/opt/farm/scripts/setup/extension.sh sf-versioning
/opt/farm/scripts/setup/extension.sh sm-farm-manager
/opt/farm/scripts/setup/extension.sh sf-binary-ssh-client

echo "setting up base directories and files"
mkdir -p   ~/.farm /var/cache/farm

touch      ~/.farm/cisco.hosts ~/.farm/mikrotik.hosts ~/.farm/usg.hosts
chmod 0600 ~/.farm/cisco.hosts ~/.farm/mikrotik.hosts ~/.farm/usg.hosts
chmod 0700 ~/.farm

chmod 0710 /var/cache/farm
chown root:www-data /var/cache/farm

if ! grep -q /opt/farm/mgr/inspect-routers/cron /etc/crontab; then
	echo "49 6 * * * root /opt/farm/mgr/inspect-routers/cron/inspect.sh" >>/etc/crontab
fi
