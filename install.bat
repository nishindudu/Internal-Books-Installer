@echo off
echo Installing InternalBooks...


echo.
echo ============= END USER LICENSE AGREEMENT =============
type EULA.md
echo ======================================================
echo.

set /p agree="Do you agree to the terms of the EULA? (yes/no): "
if /i "%agree%" NEQ "yes" (
    echo You must agree to the EULA to proceed with the installation.
    echo Installation aborted.
    pause
    exit /b 1
)

docker pull nishindudu/internalbooks:latest
if %ERRORLEVEL% NEQ 0 (
    echo Failed to pull the InternalBooks Docker image. Error code: %ERRORLEVEL%
    pause
    exit /b %ERRORLEVEL%
)

docker-compose -f docker-compose.yml up -d
if %ERRORLEVEL% NEQ 0 (
    echo Failed to start InternalBooks using Docker Compose. Error code: %ERRORLEVEL%
    pause
    exit /b %ERRORLEVEL%
)

echo InternalBooks has been installed and is running.

for /f  "tokens=2 delims=:" %%A in ('ipconfig ^| findstr /i "IPv4"') do (
    set ip=%%A
)

echo Your IP address is : %ip:~1%
pause