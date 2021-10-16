AA25.ORG AMERICAS ARMY 2.5ASSIST DEDICATED SERVER README
WINDOWS SERVER INSTALLATION INSTRUCTIONS

You will need an existing Americas Army 2.5 installation to use the 2.5 assist dedicated server.
You can use a fresh install of aa or you can use the installation from a 2.5Assist GUI install.
If you do not already have aa installed it can be downloaded here:
http://ftp.free.fr/mirrors/AmericasArmy/Windows_v2.5.0/AmericasArmy250_Download.exe



Go into you new AmericasArmy/System folder, or 25Assist/armyops/System folder,
Find server.exe and rename it to serverx.exe

Download 2.5Assist dedicated server from here:
http://sourceforge.net/projects/aa25assist/files/Binaries/wdedisrv.zip/download

Open the Zip file and move the following files and folders from the Zip into your AmericasArmy/System folder:
Server.exe
aa25.ini
Server Libs (folder)

Now edit aa25.ini and set your options.
Most important is setting the Port, choosing a unique processID and choosing an Admin Password.

Now run:
server.exe GLOBAL map-filename 
And your server will start, on later versions of windows you may need to run as administrator.
(Replace map-filename with the map you want, bridge, insurgent_camp, radio_tower etc.)
(Optional command-line arguments  -ID=001  -Port=1716  -Multihome=0.0.0.0  override settings in aa25.ini)

Additional pb commands can be added by creating ServerMessage.cfg in the "pb" folder and adding them there