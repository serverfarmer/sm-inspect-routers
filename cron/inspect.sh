#!/bin/sh

SSH=/opt/farm/ext/binary-ssh-client/wrapper/ssh


# http://fajne.it/automatyzacja-backupu-routera-mikrotik.html
sshkey=`/opt/farm/ext/keys/get-ssh-device-key.sh mikrotik`
for router in `grep -v ^# ~/.serverfarmer/inventory/mikrotik.hosts`; do

	host=`/opt/farm/mgr/farm-manager/internal/decode.sh host $router`
	port=`/opt/farm/mgr/farm-manager/internal/decode.sh port $router`

	$SSH -y -i $sshkey -p $port -o StrictHostKeyChecking=no admin@$host export \
		|/opt/farm/ext/versioning/save.sh daily 20 ~/.serverfarmer/inspection mikrotik-$host.config

done


# https://supportforums.cisco.com/document/110946/ssh-using-public-key-authentication-ios-and-big-outputs
sshkey=`/opt/farm/ext/keys/get-ssh-device-key.sh cisco`
for router in `grep -v ^# ~/.serverfarmer/inventory/cisco.hosts`; do

	host=`/opt/farm/mgr/farm-manager/internal/decode.sh host $router`
	port=`/opt/farm/mgr/farm-manager/internal/decode.sh port $router`

	$SSH -y -i $sshkey -p $port -o StrictHostKeyChecking=no admin@$host "show running-config" \
		|/opt/farm/ext/versioning/save.sh daily 20 ~/.serverfarmer/inspection cisco-$host.config

	$SSH -y -i $sshkey -p $port -o StrictHostKeyChecking=no admin@$host "show tech-support" \
		|/opt/farm/ext/versioning/save.sh daily 20 ~/.serverfarmer/inspection cisco-$host.tech

done


sshkey=`/opt/farm/ext/keys/get-ssh-device-key.sh usg`
for router in `grep -v ^# ~/.serverfarmer/inventory/usg.hosts`; do

	host=`/opt/farm/mgr/farm-manager/internal/decode.sh host $router`
	port=`/opt/farm/mgr/farm-manager/internal/decode.sh port $router`

	$SSH -y -i $sshkey -p $port -o StrictHostKeyChecking=no admin@$host "mca-ctrl -t dump-cfg" \
		|/opt/farm/ext/versioning/save.sh daily 20 ~/.serverfarmer/inspection usg-$host.json

done
