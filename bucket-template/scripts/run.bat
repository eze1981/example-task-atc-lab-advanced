@echo off
SET APP_PATH="/Apps/ATCLab"
SET APP_BUCKET="atc-lab-app"
SET DATA_BUCKET="atc-lab-data"

cd "%APP_PATH%"

REM 1. download app, scenarios, scripts and config file
CALL download.bat %APP_PATH% %APP_BUCKET%

echo "Starting..."
REM 2. running the task
CALL pact.exe "Demo.xml"

echo "Saving data into the data bucket..."
REM 3. save task output into S3
REM storing date and time into the "timestamp" variable
for /f "tokens=2-8 delims=.:/ " %%a in ("%date% %time%") do set timestamp=%%c-%%a-%%b_%%d-%%e-%%f.%%g

REM pushing Demo.xml.csv into the S3 data bucket including the timestamp in the filename
aws s3 cp Demo.xml.csv "s3://%DATA_BUCKET%/Demo.xml.%timestamp%.csv" --profile appstream_machine_role

REM the line below prevents the console window from closing
PAUSE
