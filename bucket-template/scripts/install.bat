@echo off
SET APP_PATH="/Apps/ATCLab"
SET APP_BUCKET="atc-lab-app"

REM create the installation directory
CD /
if not exist "%APP_PATH%" mkdir "%APP_PATH%"
CD "%APP_PATH%"

REM download config file, and scripts (python and batch)
aws s3 sync s3://%APP_BUCKET%/scripts . --profile appstream_machine_role
CALL download.bat %APP_PATH% %APP_BUCKET%

REM you can include any other instalation step after this line
REM ....

ECHO "Installation complete."
PAUSE
