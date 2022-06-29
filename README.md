# nm4n00bz (Network Manager 4 n00bz)
A tool for connecting to/switching wifi networks and or managing Ad Hoc through CLI . 

## Installation/Usage
* git clone https://github.com/B3ND1X/nm4noobz
* cd nm4noobz
* sudo chmod +x run.sh && chmod +x install.sh
* sudo ./install.sh
* sudo ./run.sh

##  Connecting to your ad-hoc network from another Raspberry Pi
If you have more than one Raspberry Pi, you can use one to serve up the ad-hoc network as shown above,
and the other(s) to connect to the network as clients.  To do that, you'll want the <tt>/etc/rc.local</tt>
file on your client(s) to look like this:

<pre>
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.

# Make me a client on the wireless ad-hoc network being served by Raspberry-Pi-1
iwconfig wlan0 mode Ad-Hoc
ifconfig wlan0 essid Raspberry-Pi-1

exit 0
</pre>

Now when you open the network preferences on your desktop or laptop computer, you should see <b>Raspberry-Pi-1</b>
as a wifi network you can join.  From there, you can connect to the Raspberry Pi using ssh:

<pre>
% ssh pi@192.168.2.2
</pre>

## Important note

If you have an <tt>/etc/udhcpd.conf</tt> on your client, you should make sure that it is empty 
(so that the client is not trying to serve up an ad-hoc network).  You should also make sure
that the <tt>/etc/network/interfaces</tt> on the Raspberry Pi has no
specifications for <tt>wlan0</tt> (since those are being specified in
<tt>/etc/rc.local</tt>). Otherwise you will likely see a different IP address
(169.254....) instead of the expected 192.168.2.2.

## WEP Key

If you would like to prevent anyone in range from connecting to your ad-hoc network, you can add a WEP key by adding this line:
<pre>
iwconfig wlan0 key 3b205742624039762d586f4f3e
</pre>
under 
<pre>
ifconfig wlan0 essid Raspberry-Pi-1
</pre>
where 3b205742624039762d586f4f3e is your key.
This key must be a hex-key and you can generate one here: http://www.andrewscompanies.com/tools/wep.asp
Use a 128 bit key.  A 256 bit key does not seem to work.

## Uninstall
sudo ./uninstall.sh

## Changelog 
### v 1.0 
- Initial release



### v 1.0.1
- Updated installer script to make a backup /etc in case of damage and you need to revert to original. 

## Screenshots
![95468CA7-A112-4695-85FC-655A51695DD8](https://user-images.githubusercontent.com/48177481/176324912-3fcf993b-7895-4797-900f-5e9ecb2635ff.png)
![265B353B-1E0F-4613-9E1C-C13061F20856](https://user-images.githubusercontent.com/48177481/176330723-4a4a37b1-14de-468a-954f-0e985e20daa0.jpeg)

## Credits
This is a somewhat forked/modified version of https://github.com/simondlevy/RPiAdHocWiFi/
