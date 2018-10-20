#!/bin/bash

# http://fajne.it/automatyzacja-backupu-routera-mikrotik.html
sshkey=`/opt/farm/ext/keys/get-ssh-device-key.sh mikrotik`
for router in `cat /etc/local/.farm/mikrotik.hosts |grep -v ^#`; do

	if [[ $router =~ ^[a-z0-9.-]+$ ]]; then
		router="$router::"
	elif [[ $router =~ ^[a-z0-9.-]+[:][0-9]+$ ]]; then
		router="$router:"
	fi

	host=$(echo $router |cut -d: -f1)
	port=$(echo $router |cut -d: -f2)

	if [ "$port" = "" ]; then
		port=22
	fi

	ssh -y -i $sshkey -p $port -o StrictHostKeyChecking=no admin@$host export \
		|/opt/farm/ext/versioning/save.sh daily 20 /var/cache/farm mikrotik-$host.config

done


# https://supportforums.cisco.com/document/110946/ssh-using-public-key-authentication-ios-and-big-outputs
sshkey=`/opt/farm/ext/keys/get-ssh-device-key.sh cisco`
for router in `cat /etc/local/.farm/cisco.hosts |grep -v ^#`; do

	if [[ $router =~ ^[a-z0-9.-]+$ ]]; then
		router="$router::"
	elif [[ $router =~ ^[a-z0-9.-]+[:][0-9]+$ ]]; then
		router="$router:"
	fi

	host=$(echo $router |cut -d: -f1)
	port=$(echo $router |cut -d: -f2)

	if [ "$port" = "" ]; then
		port=22
	fi

	ssh -y -i $sshkey -p $port -o StrictHostKeyChecking=no admin@$host "show running-config" \
		|/opt/farm/ext/versioning/save.sh daily 20 /var/cache/farm cisco-$host.config

	ssh -y -i $sshkey -p $port -o StrictHostKeyChecking=no admin@$host "show tech-support" \
		|/opt/farm/ext/versioning/save.sh daily 20 /var/cache/farm cisco-$host.tech

done
