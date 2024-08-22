@echo off
setlocal EnableDelayedExpansion

rem Read configuration from config.ini
for /f "tokens=1,2 delims==" %%G in (config.ini) do (
    set %%G=%%H
)

:copy_script
set /p confirm="Do you want to copy the update script to the server? (Y/n): "
if /i "!confirm!"=="n" goto ssh_connect
echo Copying update script to server...
scp "%UPDATE_SCRIPT_PATH%" %USERNAME%@%SERVER_IP%:/home/%USERNAME%/update_script.sh
if errorlevel 1 (
    echo Failed to copy the script. Please check your connection and try again.
    goto end
)

:make_executable
set /p confirm="Do you want to make the script executable on the server? (Y/n): "
if /i "!confirm!"=="n" goto add_to_profile
echo Making the script executable...
ssh %USERNAME%@%SERVER_IP% "chmod +x /home/%USERNAME%/update_script.sh"
if errorlevel 1 (
    echo Failed to make the script executable. Please check your connection and try again.
    goto end
)

:add_to_profile
set /p confirm="Do you want to add the script to .bash_profile? (Y/n): "
if /i "!confirm!"=="n" goto ssh_connect
echo Updating .bash_profile...
ssh %USERNAME%@%SERVER_IP% "sed -i '/update_script.sh/d' ~/.bash_profile && echo '/home/%USERNAME%/update_script.sh' >> ~/.bash_profile"
if errorlevel 1 (
    echo Failed to update .bash_profile. Please check your connection and try again.
    goto end
)

:ssh_connect
set /p confirm="Do you want to connect to the server via SSH? (Y/n): "
if /i "!confirm!"=="n" goto end
echo Connecting to server...
ssh %USERNAME%@%SERVER_IP%

:end
echo Setup process completed.
pause