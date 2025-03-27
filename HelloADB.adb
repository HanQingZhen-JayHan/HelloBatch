adb shell "ls -a"

adb push source_file destination_folder
adb pull source destination

adb shell chmod +x script.sh
adb shell dos2unix script.sh

adb shell mkdir folder

adb remount

adb shell ln -s physical_file softlink

adb shell sync
adb shell start
adb shell stop
adb shell reboot

#keep screen on
adb shell svc power stayon true

adb shell "dumpsys SurfaceFlinger | grep xxx"

adb devices

adb kill-server
adb start-server
