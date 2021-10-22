GTAV_multilaunch
Allows to quickly swithc between 2 installs and profile settings while preserving savegame data
Also a bonus third profile for additional configurations


Have clean install directory, make new textfile:
"_ONLINE_FLAG.txt"
in

..\GTAV\_ONLINE_FLAG.txt


Have game directory with mods (like VR mod)
rename it to 
GTAV_MOD instead of GTAV 
 make new textfile: "_MOD_FLAG.txt"
in 
..\GTAV_MOD\_MOD_FLAG.txt 


Browse 
C:\Users\YOURNAME\Documents\Rockstar Games\GTA V\ 
 make new textfile: "_PROFILE_FLAG_ONLINE.txt"
in 
C:\Users\YOURNAME\Documents\Rockstar Games\GTA V\_PROFILE_FLAG_ONLINE.txt 


C:\Users\YOURNAME\Documents\Rockstar Games\GTA V\

should have 4 files:

_PROFILE_FLAG_ONLINE.txt
settings.xml (your current online settings)
settings_mod.xml (the settings you want to use with modified gta install, like \High\settings.xml settings from VR mod)
settings_second.xml (for secondary settings, like another control scheme or for a different TV/monitor)


Browse
C:\Users\YOURNAME\Documents\Rockstar Games\GTA V\Profiles\YOUR_ROCKSTAR_PROFILE\

should have 9 files:

cfg.dat (current online settings)
cloudsavedata.dat (current online settings)
pc_settings.bin (current online settings)
cfg_mod.dat
cloudsavedata_mod.dat
pc_settings_mod.bin
cfg_second.dat
cloudsavedata_second.dat
pc_settings_second.bin


it's OK to just make copies of your online ones and rename them, they will all be induvidually saved ingame

edit GTA5_multilaunch.bat

set your id from profiles folder here
ROCKSTAR_PROFILE=YOUR_ROCKSTAR_PROFILE

For example:
set ROCKSTAR_PROFILE=A1B2C3D4

set your game install directory where GTAV folder resides for example, if your GTAV is in C:\GAMES\Epic\GTAV then

set install_dir=C:\GAMES\Epic\


close and save GTA5_multilaunch.bat
