@echo off

cd >root.txt
set /p root=<root.txt
del root.txt

path=%path%;%root%\adb
adb root
adb remount
adb shell rm -f /system/odex.log
cls
echo.
echo.
echo.
echo.                                            www.pda-planet.com/forum
echo.          A M E S T R I S    O D E X E R  Version 4.0
echo. 
echo.Requirements:
echo. 1- Rooted Phone.
echo. 2- installed adb drivers.
echo. 3- Enable USB debugging fro Developer Options.
echo. 4- Custom Kernel.[if not works for you]
echo.
echo.
echo.
echo.
echo Hit any key to install the data.
echo.
pause
adb push Amestris_Odexer /system/bin
echo.
echo.
echo.
echo.
echo.           www.pda-planet.com/forum
echo.
pause
adb shell chmod 755 /system/bin/dexopt-wrapper
adb shell chmod 755 /system/bin/zip
adb shell chmod 755 /system/bin/zipalign
adb shell chmod 755 /system/bin/odex-framework.sh
adb shell chmod 755 /system/bin/odex-script.sh
adb shell /system/bin/odex-script.sh
adb pull /system/odex.log Amestris_Log.xml
echo.
echo.
echo.
echo. Check the Amestris_Log.xml for more info!
echo. hit any key to reboot your phone now!
echo.
echo. Amestris Team.
echo.
echo.
echo.
pause
adb reboot reboot

