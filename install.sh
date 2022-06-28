#!/bin/bash

# Ensure we are being ran as root
if [ $(id -u) -ne 0 ]; then
	echo "This script must be ran as root"
	exit 1
fi


chmod -R 755 *
clear
echo "$(tput setaf 2)Installing everything for you! Please wait..."
sleep 5
clear
sudo apt-get update 
sudo apt-get install network-manager
apt install udhcpd
touch /var/lib/misc/udhcpd.leases
clear
echo 'Making backups of exsiting files...'
# make backups of existing files
if [ -e /etc/rc.local ]
then
    cp /etc/rc.local /etc/rc.local.adhoc_bak
fi

if [ -e /etc/udhcpd.conf ]
then
    cp /etc/udhcpd.conf /etc/udhcpd.conf.adhoc_bak
fi

if [ -e /etc/dhcpcd.conf ]
then
    cp /etc/dhcpcd.conf /etc/dhcpcd.conf.adhoc_bak
fi
clear
echo "$(tput setaf 2)DONE! Please reboot for installation to finish."
sleep 2



}





