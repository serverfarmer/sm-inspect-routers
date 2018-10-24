#!/bin/sh

# http://fajne.it/automatyzacja-backupu-routera-mikrotik.html
sshkey=`/opt/farm/ext/keys/get-ssh-device-key.sh mikrotik`
for router in `cat /etc/local/.farm/mikrotik.hosts |grep -v ^#`; do

	host=`/opt/farm/ext/farm-manager/internal/decode.sh host $router`
	port=`/opt/farm/ext/farm-manager/internal/decode.sh port $router`

	ssh -y -i $sshkey -p $port -o StrictHostKeyChecking=no admin@$host export \
		|/opt/farm/ext/versioning/save.sh daily 20 /var/cache/farm mikrotik-$host.config

done


# https://supportforums.cisco.com/document/110946/ssh-using-public-key-authentication-ios-and-big-outputs
sshkey=`/opt/farm/ext/keys/get-ssh-device-key.sh cisco`
for router in `cat /etc/local/.farm/cisco.hosts |grep -v ^#`; do

	host=`/opt/farm/ext/farm-manager/internal/decode.sh host $router`
	port=`/opt/farm/ext/farm-manager/internal/decode.sh port $router`

	ssh -y -i $sshkey -p $port -o StrictHostKeyChecking=no admin@$host "show running-config" \
		|/opt/farm/ext/versioning/save.sh daily 20 /var/cache/farm cisco-$host.config

	ssh -y -i $sshkey -p $port -o StrictHostKeyChecking=no admin@$host "show tech-support" \
		|/opt/farm/ext/versioning/save.sh daily 20 /var/cache/farm cisco-$host.tech

done


sshkey=`/opt/farm/ext/keys/get-ssh-device-key.sh usg`
for router in `cat /etc/local/.farm/usg.hosts |grep -v ^#`; do

	host=`/opt/farm/ext/farm-manager/internal/decode.sh host $router`
	port=`/opt/farm/ext/farm-manager/internal/decode.sh port $router`

	ssh -y -i $sshkey -p $port -o StrictHostKeyChecking=no admin@$host "mca-ctrl -t dump-cfg" \
		|/opt/farm/ext/versioning/save.sh daily 20 /var/cache/farm usg-$host.json

done
