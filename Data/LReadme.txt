AA25.ORG AMERICAS ARMY 2.5ASSIST DEDICATED SERVER README
LINUX SERVER INSTRUCTIONS

First you must have an existing americas army 2.5 installation,
If you do not follow these instuctions to download and install it...
------------
Login to your server on the console or remotely using SSH:
Move into your home folder:
	cd ~

Download the installation package:
	wget http://ftp.free.fr/mirrors/AmericasArmy/Linux_v2.5.0/armyops250-linux.run

Set executable and execute:
	chmod +x armyops250-linux.run
	./armyops250-linux.run

When asked for an installation path enter: ~/armyops
Say no to symbolic links
Select Base Install
Say no to startup menu entrys

After some time the installation will complete.
You may now delete the installation package:
	rm armyops250-linux.run
------------


2.5ASSIST DEDEICATE SERVER INSTALLATION:
Move into your americas army 'System' folder
On our fresh install you would use:
	cd ~/armyops/System

On an existing 25Assist(GUI) Installation use:
	cd ~/25Assist/armyops/System

IMPORTANT, Rename server-bin to serverx
	mv server-bin serverx
	chmod +x serverx

Download and extract 2.5assist:
	wget http://downloads.sourceforge.net/project/aa25assist/Binaries/ldedisrv.zip
	unzip ldedisrv.zip
	chmod +x server-bin

Now edit the aa25.ini file with your required settings:
	nano aa25.ini

Start the Server:
	./server-bin GLOBAL map-filename 

(replace map-filename with your choosen map, bridge, insurgent_camp, radio_tower, etc.)
(Optional command-line arguments  -Port=1716  -Multihome=0.0.0.0  override settings in aa25.ini)


Additional pb commands can be added by creating ServerMessage.cfg in the "pb" folder and adding them there.

You might have to install this to get it to work:
apt-get install lib32stdc++6