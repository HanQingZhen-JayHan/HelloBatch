@echo off
for /f "tokens=2 delims==" %%G in ('wmic os get localdatetime /value') do set datetime=%%G

set year=%datetime:~0,4%
set month=%datetime:~4,2%
set day=%datetime:~6,2%

set hour=%datetime:~8,2%
set minute=%datetime:~10,2%
set second=%datetime:~12,2%

set TIMESTAMP=%year%-%month%-%day%_%hour%-%minute%-%second%

::input arguments
set INPUT="Hello"

if "%1" NEQ "" set INPUT=%1

::%cd% refers to current path which the script is executed
set WORKSPACE=%cd%

timeout /t 20 /nobreak

echo Hello

python hello.py

pause
LOG=log\adb.log
adb shell "ls -al" > %LOG%

::print log
type %LOG%

::create folder
DOC=.\test_doc

if not exist %DOC% mkdir %DOC%


::copy files with WinSCP
::prerequisite: install WinSCP.exe(after login, click Tabs->GenerateSessionURL/Code -> Script)
"C:\Program Files (x86)\WinSCP\WinSCP.com"^
    /log="%CD%\WinSCP.log" /ini=null ^
    /comand ^
        "open sftp:://username:pwd -hostkey""ssh-ed25519 ****""" ^
        "get linux_source_path/folder/ windows_destination_path\folder" ^
        "exit"
set WINSCP_RESULT=%ERRORLEVEL%
if %WINSCP_RESULT% equ 0 (
    echo WinSCP download file Successfully.
) else (
    echo WinSCP download file with Error. Please check WinSCP.log
)

::fuction call
call :fuc

pause
exit

:fuc
    echo This is a fuction.
    goto:eof

:clean_log
    echo -----Clean Logs
    adb shell rm -rf /data/log/android_logs
    adb shell rm -rf /data/anr
    adb shell rm -rf /data/tombstones
    adb shell logcat -c
    goto:eof

:collect_log
    echo -----Collect Logs
    adb shell pull /data/log/android_logs .
    adb shell pull /data/anr .
    adb shell pull /data/tombstones .
    adb shell logcat -c
    goto:eof
