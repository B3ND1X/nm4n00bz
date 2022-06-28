#!/bin/bash

# Ensure we are being ran as root
if [ $(id -u) -ne 0 ]; then
	echo "This script must be ran as root"
	exit 1
fi

clear
Red="\e[1;91m"      ##### Colors Used #####
Green="\e[0;92m"
Yellow="\e[0;93m"
Blue="\e[1;94m"
White="\e[0;97m"





checkWiFiStatus () {        ##### Check if $foo is enabled or not #####
WiFiStatus=`nmcli radio wifi`
if [ "$WiFiStatus" == "disabled" ]; then
nmcli radio wifi on
echo -e "[${Green}$foo${White}] Enabled!"
fi
}



banner () {        ##### Banner #####
echo -e "${Green}



______________¶¶¶
_____________¶¶_¶¶¶¶
____________¶¶____¶¶¶
___________¶¶¶______¶¶
___________¶¶¶_______¶¶
__________¶¶¶¶________¶¶
__________¶_¶¶_________¶¶
__________¶__¶¶_________¶¶____¶¶
__________¶__¶¶__________¶¶¶¶¶¶¶
_________¶¶__¶¶¶______¶¶¶¶¶¶___¶
_________¶¶___¶¶__¶¶¶¶¶¶__¶¶
_______¶¶_¶____¶¶¶¶________¶¶
______¶¶__¶¶___¶¶__________¶¶
_____¶¶____¶¶___¶¶__________¶¶
___¶¶_______¶¶___¶¶_________¶¶
___¶¶¶¶¶¶¶¶¶¶¶¶¶__¶¶_________¶
_¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶_¶¶________¶¶
¶¶__¶¶¶¶¶¶____¶¶¶¶¶¶¶¶¶______¶¶
¶¶¶¶¶___¶______¶___¶¶¶¶¶_____¶¶
________¶¶¶¶¶¶¶¶______¶¶¶¶¶_¶¶
______¶¶¶¶¶¶¶¶¶¶¶________¶¶¶¶
______¶¶¶¶¶¶¶¶¶¶¶¶
______¶__¶¶_¶¶¶¶¶¶
_____¶¶______¶___¶
_____¶¶_____¶¶___¶
_____¶______¶¶___¶
____¶¶______¶¶___¶¶
____¶¶______¶¶___¶¶
___¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶
__¶¶¶¶¶¶¶¶¶_¶¶¶¶¶¶¶¶
__¶¶________¶¶¶____¶¶
____¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶
 
                                                             "
echo -e "${Yellow} \n            Network Manager for noobz"
echo -e "${Green}\n           v 1.0 By Liam Bendix (liam@liambendix.com) "
}

menu () {        ##### Display available options #####
echo -e "\n${Yellow}                      [ Select Option To Continue ]\n\n"
echo -e "      ${Red}[${Blue}1${Red}] ${Green}List WiFi Networks"
echo -e "      ${Red}[${Blue}2${Red}] ${Green}Connect to a WiFi"
echo -e "      ${Red}[${Blue}3${Red}] ${Green}Show Saved Connections"
echo -e "      ${Red}[${Blue}4${Red}] ${Green}Start Ad Hoc Network"
echo -e "      ${Red}[${Blue}5${Red}] ${Green}Stop Ad Hoc Network"
echo -e "      ${Red}[${Blue}6${Red}] ${Green}Exit\n\n"
while true; do
echo -e "${Green}┌─[${Red}Select Option${Green}]──[${Red}~${Green}]─[${Yellow}Menu${Green}]:"
read -p "└─────►$(tput setaf 7) " option
case $option in
  1) echo -e "\n[${Green}Selected${White}] Option 1 List All Networks"
    ScanList
    exit 0
     ;;
  2) echo -e "\n[${Green}Selected${White}] Option 2 Connect To Network"
    connect
    exit 0
     ;;
  3) echo -e "\n[${Green}Selected${White}] Option 3 Show Saved Connections"
    known
    exit 0
     ;;
       4) echo -e "\n[${Green}Selected${White}] Option 4 Start Ad Hoc Network"
    startADHOC
    exit 0
     ;;
       5) echo -e "\n[${Green}Selected${White}] Option 5 Stop Ad Hoc Network"
    stopADHOC
    exit 0
     ;;
  6) echo -e "${Red}\n\033[1mThank You for using the script,\n:)\n"
     exit 0
     ;;
  *) echo -e "${White}[${Red}Error${White}] Please select correct option...\n"
     ;;
esac
done
}

ScanList () {
systemctl start NetworkManager
nmcli d wifi list
menu

}

connect () {
systemctl start NetworkManager
echo "Enter network name: " SSID
read SSID
sudo nmcli --ask dev wifi connect $SSID

}



known () {
systemctl start NetworkManager
nmcli c

}

startADHOC () {
echo 'system will automatically reboot in 10 seconds(Ctrl+C to cancel)'
sleep 10
cp rc.local /etc
cp udhcpd.conf /etc
cp dhcpcd.conf /etc
echo "$(tput setaf 2)System needs to reboot, restarting..."
sleep 5
sudo reboot
}

stopADHOC () {
if [ -e /etc/rc.local.adhoc_bak ]
then
    cp /etc/rc.local.adhoc_bak /etc/rc.local
fi
rm /etc/rc.local.adhoc_bak

if [ -e /etc/udhcpd.conf.adhoc_bak ]
then
    cp /etc/udhcpd.conf.adhoc_bak /etc/udhcpd.conf
else 
    rm /etc/udhcpd.conf
fi
rm /etc/udhcpd.conf.adhoc_bak

if [ -e /etc/dhcpcd.conf.adhoc_bak ]
then
    cp /etc/dhcpcd.conf.adhoc_bak /etc/dhcpcd.conf
else 
    rm /etc/dhcpcd.conf
fi
rm /etc/dhcpcd.conf.adhoc_bak

echo "Please reboot now for changes to take effect."
exit 0
}

############# End of tool ########################################################

checkme () {
banner
menu
checkWiFiStatus
}

checkme