### Overview

`sf-inspect-routers` extension provides tools for inspecting Cisco IOS and MikroTik RouterOS devices configuration.

#### Setting up passwordless ssh authentication on router

##### Cisco IOS:

https://supportforums.cisco.com/document/110946/ssh-using-public-key-authentication-ios-and-big-outputs

##### MikroTik RouterOS:

http://fajne.it/automatyzacja-backupu-routera-mikrotik.html - in polish language, short version below:

First, you need to generate ssh DSA (not RSA) key pair and install public key on all routers you plan to connect to.

```
ssh-keygen -t dsa -f /etc/local/.ssh/id_backup_mikrotik
```

Now, you have 2 files:

`/etc/local/.ssh/id_backup_mikrotik` is the private key, and you should protect it before any unauthorized access

`/etc/local/.ssh/id_backup_mikrotik.pub` is the public key, and you should install it on your routers:

```
scp -P 10022 /etc/local/.ssh/id_backup_mikrotik.pub admin@router.yourdomain.com:
```

Then log in to your router using ssh (authenticating with password for the last time), and import the key to your user:

```
ssh -p 10022 admin@router.yourdomain.com
[admin@router] > user ssh-keys import public-key-file=id_backup_mikrotik.pub user=admin
```
