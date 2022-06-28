# nmscript
A tool for connecting to/switching wifi networks and or managing Ad Hoc through CLI . Made mostly for headless pi set up.

## Installation/Usage
* git clone https://github.com/B3ND1X/nmscript
* cd nmscript
* sudo chmod +x nmscript.sh && chmod +x install.sh
* sudo ./install.sh
* sudo ./nmscript.sh

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

## Uninstall
sudo ./uninstall.sh

## Changelog 
* v 1.0 
- Initial release
