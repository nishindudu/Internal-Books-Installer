@echo off
echo Starting InternalBooks...

docker-compose start
if %ERRORLEVEL% NEQ 0 (
    echo Failed to start InternalBooks using Docker Compose. Error code: %ERRORLEVEL%
    pause
    exit /b %ERRORLEVEL%
)

echo InternalBooks has been started.

for /f  "tokens=2 delims=:" %%A in ('ipconfig ^| findstr /i "IPv4"') do (
    set ip=%%A
)

echo Your IP address is : %ip:~1%
pause