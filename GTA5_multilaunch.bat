:label_batch_start




:: set your game directory here, make sure it's not "\Epic\GTAV\" but whatever folder GTAV folder is in
::                YOU NEED TO CHANGE THIS!
set install_dir=S:\GAMES\Epic\

:: set your profile name here, it's usually a folder name with numbers and letter in "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\"
::                    YOU NEED TO CHANGE THIS!
set ROCKSTAR_PROFILE=AAAA2222








@echo off

:: Check if GTAV.exe is running

tasklist /fi "ImageName eq GTA5.exe" /fo csv 2>NUL | find /I "GTA5.exe">NUL
if "%ERRORLEVEL%"=="0" GOTO label_error_running


:: check if game profile directory exists 
:: %USERPROFILE%\Documents\Rockstar Games\GTA V
if not exist "%USERPROFILE%\Documents\Rockstar Games\GTA V" GOTO label_profile_not_exists



::check if flag file exists
IF EXIST "%USERPROFILE%\Documents\Rockstar Games\GTA V\_PROFILE_FLAG_*" (GOTO label_PROFILE_FLAG_exist)

:label_PROFILE_FLAG_not_exist
echo. 
echo _PROFILE_FLAG_something file not found. This isn't good. Please check files.
echo.
pause
exit

:label_PROFILE_FLAG_exist
echo.
REM echo...debug.. _PROFILE_FLAG_something file found, continue script.
REM pause
echo.




:: check if game directory exists
if not exist "%install_dir%\GTAV" GOTO label_game_dir_err

:MENU
COLOR 0A
cls
ECHO.
ECHO .......................................................................................................
ECHO        PRESS 1, 2 OR 3 to select your task, or 4 to EXIT.
ECHO .......................................................................................................
ECHO.
ECHO 		1 - start game
ECHO 		2 - 2D profile settings 1 and change game directory (\GTAV\_ONLINE_FLAG.txt)
ECHO 		3 - MOD profile settings and change game directory (\GTAV\_MOD_FLAG.txt)
ECHO 		4 - 2D profile settings 2 (no change of game directory)
ECHO 		---------------
ECHO 		9 - EXIT
ECHO.
ECHO .......................................................................................................
ECHO.
SET /P M= Make a selection with regular number keys, then press ENTER: 
ECHO.
ECHO.
ECHO.
IF %M%==1 GOTO label_start_game
IF %M%==2 GOTO label_2D_1
IF %M%==3 GOTO label_MOD_1
IF %M%==4 GOTO label_2D_2
::IF %M%==9 GOTO EOF
IF %M%==9 GOTO label_normal_exit

CLS
ECHO ============INVALID INPUT============
ECHO -------------------------------------
ECHO Please select a number from the Main
echo Menu [1-9]
ECHO -------------------------------------
ECHO ======PRESS ANY KEY TO CONTINUE======

PAUSE > NUL
GOTO MENU

goto label_normal_exit

:label_start_game


:MENU_STARTGAME
COLOR 0B
cls
ECHO.
ECHO .......................................................................................................
ECHO        PRESS 1-5, or 9 to go back to main menu
ECHO .......................................................................................................
ECHO.
ECHO 		1 - epic
ECHO 		2 - steam
ECHO 		3 - rockstar (launch PlayGTAV.exe)
ECHO 		4 - GTA5.exe directly
ECHO 		9 - Main Menu
ECHO.
SET /P M= Make a selection with regular number keys, then press ENTER: 
ECHO.
ECHO.
IF %M%==1 GOTO epic_start
IF %M%==2 GOTO steam_start
IF %M%==3 GOTO rockstar_start
IF %M%==4 GOTO GTA5_exe_start
::IF %M%==9 GOTO EOF
IF %M%==9 GOTO menu

CLS
ECHO ============INVALID INPUT============
ECHO -------------------------------------
ECHO Please select a number from the 
echo Menu [1-9]
ECHO -------------------------------------
ECHO ======PRESS ANY KEY TO CONTINUE======

PAUSE > NUL
GOTO MENU_STARTGAME

::return to main menu
goto menu


::rockstar launcher==================================================
:rockstar_start
cd /d %install_dir%\GTAV\
start PlayGTAV.exe
pause
exit

::GTA5.exe directly======================================================
:GTA5_exe_start

::not sure why
::start %install_dir%\GTAV\GTA5.exe
::doesnt work but this does:
cd /d %install_dir%\GTAV\
start GTA5.exe
pause
exit

::steam version=========================================================
:steam_start
start steam://rungameid/271590
pause
exit


::epic games============================================================
:epic_start

::check if EpicGamesLauncher.exe is running already
tasklist /fi "ImageName eq EpicGamesLauncher.exe" /fo csv 2>NUL | find /I "EpicGamesLauncher.exe">NUL
if "%ERRORLEVEL%"=="1" (

::start epic games itself
:: has to be opened like a website link
start "" com.epicgames.launcher://apps

::clears screen not to confuse user during timeout due to weird start command error ("The system cannot find the drive specified.")
cls
echo EpicGamesLauncher.exe is NOT running!
echo Starting Epic Game Launcher...
:: waits x seconds for epic launcher to load, increase this value if epic loads too slowly, decrease the value for faster loading times,
:: again, this is only if launcher isnt already open
TIMEOUT /T 45

)

::this will start if epic games is open, if not it will just open epic games itself, need double %% because this is a batch file
::       com.epicgames.launcher://apps/0584d2013f0149a791e7b9bad0eec102%3A6e563a2c0f5f46e3b4e88b5f4ed50cca%3A9d2d0eb64d5c44529cece33fe2a46482?action=launch&silent=true
start "" com.epicgames.launcher://apps/0584d2013f0149a791e7b9bad0eec102%%3A6e563a2c0f5f46e3b4e88b5f4ed50cca%%3A9d2d0eb64d5c44529cece33fe2a46482^?action=launch^&silent=true


exit


:label_2D_1

::check if already set to 2D flag in install directory
if  exist "%install_dir%\GTAV\_ONLINE_FLAG.txt" (
echo...debug.. online flag file in install dir found, no operation needed

::check for mod flas as well just in case
if exist "%install_dir%\GTAV\_MOD_FLAG.txt" (
echo mod flag also found, make sure you renamed and copied folders and files right
pause
exit
)

goto label_set_online_profile

pause
)

::check all other error cases
if not exist "%install_dir%\GTAV\_ONLINE_FLAG.txt" (
echo...debug.. online flag not file found, looking for gta online folder...
echo.
)

if not exist "%install_dir%\GTAV_online\_ONLINE_FLAG.txt" (
echo online folder not found, make sure you renamed and copied folders right
echo %install_dir%\GTAV_online\_ONLINE_FLAG.txt missing
echo.
pause
exit
)

if not exist "%install_dir%\GTAV\_MOD_FLAG.txt" (
echo MOD_FLAG.txt is also missing, make sure you renamed and copied folders right
echo %install_dir%\GTAV\_MOD_FLAG.txt missing
echo.
pause
exit
)

::MOD must be the current directory, rename it to GTA_MOD

if exist "%install_dir%\GTAV\_MOD_FLAG.txt" (
echo...debug.. renaming GTAV to GTA_MOD
echo.
ren "%install_dir%\GTAV\" "GTAV_MOD"

)

::all is good, now rename online to GTAV
echo...debug.. renaming GTAV_online to GTAV
echo.
echo...debug.. Set online as main GTAV folder
ren "%install_dir%\GTAV_online\" "GTAV"
echo.


goto label_set_online_profile



:label_set_online_profile
::============================================================================================================PROFILE SET ONLINE

::IF ONLINE flag exists, make sure other flags don't exist 
if exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\_PROFILE_FLAG_ONLINE.txt" (

::check if mod flag also exists
if exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\_PROFILE_FLAG_MOD.txt" (
echo _MOD_PROFILE_FLAG_FLAG.txt also exists, profile not setup right
pause
GOTO MENU
)

::check if second flag also exists
if exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\_PROFILE_FLAG_SECOND.txt" (
echo _PROFILE_FLAG_SECOND.txt also exists profile not setup right
pause
GOTO MENU
)

::also make sure that there's no _online files present
if exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\settings_online.xml" goto label_online_misconfigured
if exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\cfg_online.dat" goto label_online_misconfigured
if exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\cloudsavedata_online.dat" goto label_misconfigured
if exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\pc_settings_online.bin" goto label_online_misconfigured

echo. profile already set to online, everything seems to be configured properly
echo. You can launch the game now.
pause
goto menu

)


::_PROFILE_FLAG_ONLINE.txt doesn't exist, then we check which does exist and rename accordingly
echo...debug.. now checking what files exists, and then rename the files with their proper suffixes 
echo.

if	exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\_PROFILE_FLAG_MOD.txt" (
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\settings.xml" settings_mod.xml
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\cfg.dat" cfg_mod.dat
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\cloudsavedata.dat" cloudsavedata_mod.dat
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\pc_settings.bin" pc_settings_mod.bin
)

if	exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\_PROFILE_FLAG_SECOND.txt" (
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\settings.xml" settings_second.xml
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\cfg.dat" cfg_second.dat
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\cloudsavedata.dat" cloudsavedata_second.dat
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\pc_settings.bin" pc_settings_second.bin
)

echo...debug.. make sure all online files exist
echo.
if not exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\settings_online.xml" goto label_online_config_missing
if not exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\cfg_online.dat" goto label_online_config_missing
if not exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\cloudsavedata_online.dat" goto label_online_config_missing
if not exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\pc_settings_online.bin" goto label_online_config_missing

echo...debug.. no missing online files 
echo.


echo...debug.. now rename _online to normal gta files
echo.

ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\settings_online.xml" settings.xml
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\cfg_online.dat" cfg.dat
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\cloudsavedata_online.dat" cloudsavedata.dat
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\pc_settings_online.bin" pc_settings.bin

echo.
echo...debug.. Set flag to online mode by renaming _PROFILE_FLAG_ file
echo. 

ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\_PROFILE_FLAG_*" "_PROFILE_FLAG_ONLINE.txt"

echo.----------------------------------------------------
echo. Done. Ready to start the game with online profile.
echo.----------------------------------------------------
pause
goto menu



:label_set_mod_profile
::============================================================================================================PROFILE SET MOD

::read the flag and check for other flags

::IF MOD  flag exists, make sure other flags don't exist 
if exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\_PROFILE_FLAG_MOD.txt" (

::check if online flag also exists
if exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\_PROFILE_FLAG_ONLINE.txt" (
echo _PROFILE_FLAG_ONLINE.txt also exists, profile not setup right
pause
GOTO MENU
)

::check if second flag also exists
if exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\_PROFILE_FLAG_SECOND.txt" (
echo _PROFILE_FLAG_SECOND.txt also exists profile not setup right
pause
GOTO MENU
)

::also make sure that there's no _mod files present
if exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\settings_mod.xml" goto label_mod_misconfigured
if exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\cfg_mod.dat" goto label_mod_misconfigured
if exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\cloudsavedata_mod.dat" goto label_mod_misconfigured
if exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\pc_settings_mod.bin" goto label_mod_misconfigured

echo profile already set to mod, everything seems to be configured properly
echo. launch the game
pause
goto menu

)


::_PROFILE_FLAG_MOD.txt doesn't exist, then we check which does exist and rename accordingly
echo...debug.. now check which files exists, and then rename the files with that suffix

if	exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\_PROFILE_FLAG_ONLINE.txt" (
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\settings.xml" settings_online.xml
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\cfg.dat" cfg_online.dat
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\cloudsavedata.dat" cloudsavedata_online.dat
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\pc_settings.bin" pc_settings_online.bin
)

if	exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\_PROFILE_FLAG_SECOND.txt" (
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\settings.xml" settings_second.xml
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\cfg.dat" cfg_second.dat
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\cloudsavedata.dat" cloudsavedata_second.dat
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\pc_settings.bin" pc_settings_second.bin
)

echo...debug.. Now let's make sure all mod files exist
echo.
if not exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\settings_mod.xml" goto label_online_config_missing
if not exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\cfg_mod.dat" goto label_online_config_missing
if not exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\cloudsavedata_mod.dat" goto label_online_config_missing
if not exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\pc_settings_mod.bin" goto label_online_config_missing

echo...debug.. no missing mod files 
echo.

echo...debug.. now rename _mod to normal gta files
echo.

ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\settings_mod.xml" settings.xml
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\cfg_mod.dat" cfg.dat
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\cloudsavedata_mod.dat" cloudsavedata.dat
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\pc_settings_mod.bin" pc_settings.bin

echo.
echo...debug.. Set flag to mod mode by renaming _PROFILE_FLAG_ file
echo. 

ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\_PROFILE_FLAG_*" "_PROFILE_FLAG_MOD.txt"

pause

echo.----------------------------------------------------
echo  Good to go start the game with modded config
echo.----------------------------------------------------
pause
goto menu


:label_2D_2
:label_set_second_profile
::============================================================================================================PROFILE SET SECOND
echo.
echo. Setting profile configs to second.
echo. 
::read the flag and check for other flags
::IF SECOND flag exists, make sure other flags don't exist 
if exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\_PROFILE_FLAG_SECOND.txt" (

::check if online flag also exists
if exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\_PROFILE_FLAG_ONLINE.txt" (
echo _PROFILE_FLAG_ONLINE.txt also exists, profile not setup right
pause
GOTO MENU
)

::check if mod flag also exists
if exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\_PROFILE_FLAG_MOD.txt" (
echo _PROFILE_FLAG_MOD.txt also exists profile not setup right
pause
GOTO MENU
)

::also make sure that there's no _second files present
if exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\settings_second.xml" goto label_second_misconfigured
if exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\cfg_second.dat" goto label_second_misconfigured
if exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\cloudsavedata_second.dat" goto label_second_misconfigured
if exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\pc_settings_second.bin" goto label_second_misconfigured

echo  Profile already set to second, everything seems to be configured properly
echo. launch the game
echo.
pause
goto menu

)

pause
::_PROFILE_FLAG_SECOND.txt doesn't exist, then we check which does exist and rename accordingly
echo...debug.. Now checking what file exists, and then rename the files with that name

::something isn't working here, a rogue character or something,not sure, adding labels and gotos

if	exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\_PROFILE_FLAG_ONLINE.txt" (
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\settings.xml" settings_online.xml
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\cfg.dat" cfg_online.dat
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\cloudsavedata.dat" cloudsavedata_online.dat
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\pc_settings.bin" pc_settings_online.bin
)

if	exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\_PROFILE_FLAG_MOD.txt" (
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\settings.xml" settings_mod.xml
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\cfg.dat" cfg_mod.dat
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\cloudsavedata.dat" cloudsavedata_mod.dat
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\pc_settings.bin" pc_settings_mod.bin
)




echo...debug.. Now let's sure all second files exist
echo.

if not exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\settings_second.xml" goto label_second_config_missing
if not exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\cfg_second.dat" goto label_second_config_missing
if not exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\cloudsavedata_second.dat" goto label_second_config_missing
if not exist "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\pc_settings_second.bin" goto label_second_config_missing

echo...debug.. no missing second files 
pause


echo...debug.. now rename _second to normal gta files
pause

ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\settings_second.xml" settings.xml
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\cfg_second.dat" cfg.dat
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\cloudsavedata_second.dat" cloudsavedata.dat
ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\Profiles\%ROCKSTAR_PROFILE%\pc_settings_second.bin" pc_settings.bin


echo.
echo...debug.. Set flag to second mode by renaming _PROFILE_FLAG_ file
echo. 

ren "%USERPROFILE%\Documents\Rockstar Games\GTA V\_PROFILE_FLAG_*" _PROFILE_FLAG_SECOND.txt

echo.----------------------------------------------------
echo Good to go start the game with second profile settings
echo.----------------------------------------------------

pause
goto menu


:label_second_config_missing
echo. one of the _second profile files are missing, please make sure everything is configured correctly
echo.
pause
goto menu

:label_online_config_missing
echo. one of these is missing, please make sure everything is configured correctly
echo. GTA V\settings_online.xml, GTA V\Profiles\%ROCKSTAR_PROFILE%\cfg_online.dat, Profiles\%ROCKSTAR_PROFILE%\cloudsavedata_online.dat, GTA V\Profiles\%ROCKSTAR_PROFILE%\pc_settings_online.bin
echo.
pause
goto menu


:label_second_misconfigured
echo something is wrong, files found that shouldn't exist
pause
goto menu

:label_online_misconfigured
echo something is wrong, files found that shouldn't exist
pause
goto menu


:label_mod_misconfigured
echo something is wrong, files found that shouldn't exist
pause
goto menu



:label_MOD_1


::check if already set to MOD flag in install directory
if exist "%install_dir%\GTAV\_MOD_FLAG.txt" (
pause 
echo mod file found, no operation needed
pause
if exist "%install_dir%\GTAV\_ONLINE_FLAG.txt" (
echo online flag also found, make sure you renamed and copied folders and files right
pause
exit
)
echo...debug.. all ok, set profile next
goto label_set_mod_profile
pause
)

::check all other error cases
if not exist "%install_dir%\GTAV\_MOD_FLAG.txt" (
echo...debug.. MOD flag not file found, looking for gtav_mod folder...
echo.
)

if not exist "%install_dir%\GTAV_MOD\_MOD_FLAG.txt" (
echo MOD flag file not found, make sure you renamed and copied folders right
echo %install_dir%\GTAV_MOD\_MOD_FLAG.txt missing
echo.
pause
exit
)

if not exist "%install_dir%\GTAV\_ONLINE_FLAG.txt" (
echo _ONLINE_FLAG.txt is also missing, make sure you renamed and copied folders right
echo %install_dir%\GTAV\_ONLINE_FLAG.txt missing
echo.
pause
exit
)

::online must be the current directory, rename it to GTA_online

if exist "%install_dir%\GTAV\_ONLINE_FLAG.txt" (
echo...debug.. renaming GTAV to GTA_ONLINE
echo.
ren "%install_dir%\GTAV\" "GTAV_ONLINE"
echo.

)

::all is good, now rename MOD to GTAV
echo...debug.. renaming GTAV_MOD to GTAV
echo.
ren "%install_dir%\GTAV_MOD\" "GTAV"
echo.
 


goto label_set_mod_profile

pause 
goto menu




:label_game_dir_err
echo.
echo error game directory not exists
echo %install_dir%\GTAV
echo. 

pause 
exit


:label_profile_not_exists
echo.
echo error profile not exists
echo "%USERPROFILE%\Documents\Rockstar Games\GTA V" not found
echo. 

pause
exit

:label_error_running
cls
echo.
echo GTA5 is already running, please close it first.
echo.
pause 
GOTO label_batch_start



echo.
echo. ----------------
echo error, bad exit
echo. ----------------
echo.
pause
exit


