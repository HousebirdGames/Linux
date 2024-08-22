@echo off
setlocal EnableDelayedExpansion

rem Read configuration from config.ini
for /f "tokens=1,2 delims==" %%G in (config.ini) do (
    set %%G=%%H
)

:copy_script
set /p confirm="Do you want to copy the swap space increase script to the server? (Y/n): "
if /i "!confirm!"=="n" goto ssh_connect
echo Copying swap space increase script to server...
scp "%SWAP_SPACE_SCRIPT_PATH%" %USERNAME%@%SERVER_IP%:/home/%USERNAME%/increase_swap_space.sh
if errorlevel 1 (
    echo Failed to copy the script. Please check your connection and try again.
    goto end
)

:make_executable
set /p confirm="Do you want to make the script executable on the server? (Y/n): "
if /i "!confirm!"=="n" goto run_script
echo Making the script executable...
ssh %USERNAME%@%SERVER_IP% "chmod +x /home/%USERNAME%/increase_swap_space.sh"
if errorlevel 1 (
    echo Failed to make the script executable. Please check your connection and try again.
    goto end
)

:run_script
set /p confirm="Do you want to run the swap space increase script now? (Y/n): "
if /i "!confirm!"=="n" goto ssh_connect
echo Running swap space increase script...
ssh %USERNAME%@%SERVER_IP% "sudo /home/%USERNAME%/increase_swap_space.sh"
if errorlevel 1 (
    echo Failed to run the script. Please check your connection and try again.
    goto end
)

:ssh_connect
set /p confirm="Do you want to connect to the server via SSH? (Y/n): "
if /i "!confirm!"=="n" goto end
echo Connecting to server...
echo Remember to check the new swap space with 'free -m' after connecting!
ssh %USERNAME%@%SERVER_IP%

:end
echo Setup process completed.
pause
