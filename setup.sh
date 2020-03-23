#!/bin/sh

/opt/farm/scripts/setup/extension.sh sf-versioning
/opt/farm/scripts/setup/extension.sh sf-farm-manager
/opt/farm/scripts/setup/extension.sh sf-binary-ssh-client

echo "setting up base directories and files"
mkdir -p   /etc/local/.farm /var/cache/farm

touch      /etc/local/.farm/cisco.hosts /etc/local/.farm/mikrotik.hosts /etc/local/.farm/usg.hosts
chmod 0600 /etc/local/.farm/cisco.hosts /etc/local/.farm/mikrotik.hosts /etc/local/.farm/usg.hosts
chmod 0700 /etc/local/.farm

chmod 0710 /var/cache/farm
chown root:www-data /var/cache/farm

if ! grep -q /opt/farm/mgr/inspect-routers/cron /etc/crontab; then
	echo "49 6 * * * root /opt/farm/mgr/inspect-routers/cron/inspect.sh" >>/etc/crontab
fi
