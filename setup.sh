#!/bin/sh

/opt/farm/scripts/setup/extension.sh sf-versioning
/opt/farm/scripts/setup/extension.sh sm-farm-manager
/opt/farm/scripts/setup/extension.sh sf-binary-ssh-client

echo "setting up base directories and files"
mkdir -p ~/.serverfarmer/inspection ~/.serverfarmer/inventory
chmod 0710 ~/.serverfarmer ~/.serverfarmer/inspection
chown root:www-data ~/.serverfarmer ~/.serverfarmer/inspection

touch      ~/.serverfarmer/inventory/cisco.hosts ~/.serverfarmer/inventory/mikrotik.hosts ~/.serverfarmer/inventory/usg.hosts
chmod 0600 ~/.serverfarmer/inventory/cisco.hosts ~/.serverfarmer/inventory/mikrotik.hosts ~/.serverfarmer/inventory/usg.hosts
chmod 0700 ~/.serverfarmer/inventory

if ! grep -q /opt/farm/mgr/inspect-routers/cron /etc/crontab; then
	echo "49 6 * * * root /opt/farm/mgr/inspect-routers/cron/inspect.sh" >>/etc/crontab
fi
