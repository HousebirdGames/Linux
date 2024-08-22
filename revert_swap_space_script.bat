@echo off
setlocal EnableDelayedExpansion

rem Read configuration from config.ini
for /f "tokens=1,2 delims==" %%G in (config.ini) do (
    set %%G=%%H
)

:copy_script
set /p confirm="Do you want to copy the swap space revert script to the server? (Y/n): "
if /i "!confirm!"=="n" goto end
echo Copying swap space revert script to server...
scp "%SWAP_REVERT_SCRIPT_PATH%" %USERNAME%@%SERVER_IP%:/home/%USERNAME%/revert_swap_increase.sh
if errorlevel 1 (
    echo Failed to copy the script. Please check your connection and try again.
    goto end
)

:make_executable
echo Making the script executable...
ssh %USERNAME%@%SERVER_IP% "chmod +x /home/%USERNAME%/revert_swap_increase.sh"
if errorlevel 1 (
    echo Failed to make the script executable. Please check your connection and try again.
    goto end
)

:run_script
set /p confirm="Do you want to run the swap space revert script now? (Y/n): "
if /i "!confirm!"=="n" goto end
echo Running swap space revert script...
ssh %USERNAME%@%SERVER_IP% "sudo /home/%USERNAME%/revert_swap_increase.sh"
if errorlevel 1 (
    echo Failed to run the script. Please check the script contents and your sudo privileges.
    goto end
)

:end
echo Revert process completed.
pause
