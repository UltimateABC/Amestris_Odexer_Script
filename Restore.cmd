@echo off

cd >root.txt
set /p root=<root.txt
del root.txt

path=%path%;%root%\adb
adb root
adb remount
echo.
echo.
echo  Press Any Key for Backup 
Pause
adb shell rm -r /system/app
adb shell rm -r /system/framework
adb push backup/app /system/app
adb push backup/framework /system/framework/ 
echo.
echo.
echo.
echo. Finished.
pause