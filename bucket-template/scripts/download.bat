@echo off
SET APP_PATH=%1%
SET APP_BUCKET=%2%

CD "%APP_PATH%"

REM download app from the S3 bucket
ECHO "Downloading latest app version, and configuration files..."
aws s3 sync "s3://%APP_BUCKET%/app" . --profile appstream_machine_role

REM download config file and scripts
aws s3 sync "s3://%APP_BUCKET%/scripts" . --profile appstream_machine_role
