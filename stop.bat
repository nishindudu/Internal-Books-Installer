@echo off
echo Stopping InternalBooks...

docker-compose stop
if %ERRORLEVEL% NEQ 0 (
    echo Failed to stop InternalBooks using Docker Compose. Error code: %ERRORLEVEL%
    pause
    exit /b %ERRORLEVEL%
)

echo InternalBooks has been stopped.
pause