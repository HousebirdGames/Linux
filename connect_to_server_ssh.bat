@echo off
setlocal

rem Read configuration from config.ini
for /f "tokens=1,2 delims==" %%G in (config.ini) do (
    set %%G=%%H
)

ssh %USERNAME%@%SERVER_IP%

rem Keep the window open
pause
