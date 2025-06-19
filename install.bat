@echo off
echo Installing InternalBooks...

docker pull nishindudu/internalbooks:latest
if %ERRORLEVEL% NEQ 0 (
    echo Failed to pull the InternalBooks Docker image. Error code: %ERRORLEVEL%
    exit /b %ERRORLEVEL%
)

docker-compose -f docker-compose.yml up -d
if %ERRORLEVEL% NEQ 0 (
    echo Failed to start InternalBooks using Docker Compose. Error code: %ERRORLEVEL%
    exit /b %ERRORLEVEL%
)

echo InternalBooks has been installed and is running.

for /f  "tokens=2 delims=:" %%A in ('ipconfig ^| findstr /i "IPv4"') do (
    set ip=%%A
)

echo Your IP address is : %ip:~1%
pause