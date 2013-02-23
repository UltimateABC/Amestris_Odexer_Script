#!/system/bin/sh
#Amestris Odexer Script V4.0
#By M Javad Nazari

#permissions
chmod 777 /system/bin/zip
chmod 777 /system/bin/zipalign
chmod 777 /system/bin/dexopt-wrapper
#variables
logfile=/system/odex.log
fmf=/system/framework
appf=/system/app
zip=/system/bin/zip
zipalign=/system/bin/zipalign
dexwrpr=/system/bin/dexopt-wrapper
BOOTCLASSPATH=$fmf/core.jar:$fmf/core-junit.jar:$fmf/bouncycastle.jar:$fmf/ext.jar:$fmf/framework.jar:$fmf/framework2.jar:$fmf/android.policy.jar:$fmf/services.jar:$fmf/apache-xml.jar:$fmf/sec_edm.jar:$fmf/seccamera.jar

# Starting
echo "-------------------------------------------------------------------------">>$logfile
echo "-------------------------------------------------------------------------">>$logfile
echo "-------------- A M E S T R I S    O D E X E R    V 4.0 ------------------">>$logfile
echo " ">>$logfile
date >>$logfile
echo 'Starting  ' >>$logfile
# Mounting
echo 'Mounting ' >>$logfile
mount /dev/block/mmcblk0p9 /system >>$logfile
echo "">>$logfile
####Framework Files####
echo "---| Framework Jar Files |------------------------" >>$logfile
cd /
cd $fmf	
for btcf in core.jar core-junit.jar bouncycastle.jar ext.jar framework.jar framework2.jar android.policy.jar services.jar apache-xml.jar sec_edm.jar seccamera.jar
do  
    if [ -f `echo $btcf | sed 's/\(.*\.\)jar/\1odex/'` ]
	then
		echo "$btcf already odexed."
	    echo "$btcf is already odexed." >>$logfile
	else
		amestris=`echo $btcf | sed -e 's/.jar/.odex/g'`
		echo "Odexing $amestris"
		echo "Odexing  $amestris">>$logfile
        $dexwrpr $btcf /system/$amestris $BOOTCLASSPATH
        if [ $? -eq 0 ]
        then
            $zip -d $btcf classes.dex
            mv /system/$amestris $fmf/$amestris
		else
		    echo " "
			rm -f /system/$amestris
		    echo "    $btcf isnt odexed !!!!!" >>$logfile
			echo "    $btcf isnt odexed !!!!!"
			sleep 1
        fi 
    
	fi
    echo "----------------------------------------------------------------">>$logfile
	echo "----------------------------------------------------------------"
	sleep 1
done
##
for i in *.jar
do  
    if [ -f `echo $i | sed 's/\(.*\.\)jar/\1odex/'` ]
	then
	    echo "$i already odexed." >>$logfile
		echo "$i already odexed."
	else
		amestris=`echo $i | sed -e 's/.jar/.odex/g'`
        echo "Odexing  $amestris" >>$logfile
		echo "Odexing  $amestris"
        $dexwrpr $i /system/$amestris $BOOTCLASSPATH
        if [ $? -eq 0 ]
        then
            $zip -d $i classes.dex
            mv /system/$amestris $fmf/$amestris
		else
		    echo " "
			rm -r /system/$amestris
		    echo "---------------$i isnt odexed , maybe doesn't have any smali file. !!!!!" >>$logfile
			echo "---------------$i isnt odexed !!!!!"
			sleep 1
        fi 
    
	fi
    echo "----------------------------------------------------------------">>$logfile
	echo "----------------------------------------------------------------"
	sleep 1
done
mv libvtmanage.odex.odex libvtmanagerjar.odex
cd /

echo " ">>$logfile
###System Apps###
echo "---| System Applications |------------------------">>$logfile
cd /
cd $appf	
for i in *.apk
do  
    if [ -f `echo $i | sed 's/\(.*\.\)apk/\1odex/'` ]
	then
	    echo "$i is already odexed." >>$logfile
		echo "$i is already odexed." 
	else
		amestrisapp=`echo $i | sed -e 's/.apk/.odex/g'`
        echo "Odexing $amestrisapp" >>$logfile
		echo "Odexing  $amestrisapp"
        $dexwrpr $i /system/$amestrisapp $BOOTCLASSPATH
        if [ $? -eq 0 ]
        then
		echo "ZipAlign $$i " >>$logfile
			echo "ZipAlign $i"
            $zip -d $i classes.dex
            mv /system/$amestrisapp $appf/$amestrisapp
			$zipalign -f 4 $i /system/$i.new
			cat /system/$i.new >$appf/$i
			rm /system/$i.new
			echo "Done" >>$logfile
			echo "Done."
		else
		    echo " "
			rm -f /system/$amestrisapp
		    echo "---------------$i isnt odexed , maybe doesn't have any smali file. !!!!!" >>$logfile
			echo "---------------$i isnt odexed !!!!!"
			sleep 1
        fi
	fi
    echo "----------------------------------------------------------------">>$logfile
	echo "----------------------------------------------------------------"
	sleep 1
done
cd /
echo " ">>$logfile
echo "Deleting dalvik-cache" >>$logfile
rm -r /data/dalvik-cache/*	
echo " "
echo "Done.....">>$logfile
date >>$logfile
echo " "
echo " "
echo "-------------- A M E S T R I S    O D E X E R  V 4.0 --------------------">>$logfile
echo "-------------------------------------------------------------------------">>$logfile
echo "-------------------------------------------------------------------------">>$logfile
