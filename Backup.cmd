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
adb pull /system/app backup/app
adb pull /system/framework/ backup/framework
echo.
echo.
echo.
echo. Finished.
pause