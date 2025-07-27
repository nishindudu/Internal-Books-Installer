@echo off
echo Checking for updates to InternalBooks...
echo.

docker pull nishindudu/internalbooks:latest
if %ERRORLEVEL% NEQ 0 (
    echo Failed to pull the latest InternalBooks Docker image. Error code: %ERRORLEVEL%
    pause
    exit /b %ERRORLEVEL%
)
echo.

echo Stopping current instance
docker-compose -f docker-compose.yml down
if %ERRORLEVEL% NEQ 0 (
    echo Failed to stop the current InternalBooks instance. Error code: %ERRORLEVEL%
    echo Continuing with update...
    echo.
)


REM check if updates.txt has changed and download if needed. (Used to check for manual updates)
curl -s -z updates.txt -w "%%{http_code}" -o updates.txt "https://raw.githubusercontent.com/nishindudu/Internal-Books-Installer/refs/heads/main/updates.txt" > status.tmp
if %ERRORLEVEL% NEQ 0 (
    echo Failed to download the latest updates.txt. Error code: %ERRORLEVEL%
    pause
    exit /b %ERRORLEVEL%
)

set /p status=<status.tmp
del status.tmp

if "%status%" NEQ "200" (
    echo No changes detected in updates.txt. Continuing with update...
) else (
    echo Updated updates.txt downloaded successfully.
    type updates.txt
    pause
    echo.
)


docker-compose -f docker-compose.yml up -d
if %ERRORLEVEL% NEQ 0 (
    echo Failed to start InternalBooks with the updated Docker image. Error code: %ERRORLEVEL%
    pause
    exit /b %ERRORLEVEL%
)

echo InternalBooks has been updated and is running.

for /f "tokens=2 delims=:" %%A in ('ipconfig ^| findstr /i "IPv4"') do (
    set ip=%%A
)
echo Your IP address is : %ip:~1%

pause