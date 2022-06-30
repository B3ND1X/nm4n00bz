#!/bin/bash

# Ensure we are being ran as root
if [ $(id -u) -ne 0 ]; then
	echo "This script must be ran as root"
	exit 1
fi

clear
echo 'Uninstalling please wait..'
sleep 2

apt purge udhcpd busybox 

sudo rm -rf /home/*/nm4n00bz


