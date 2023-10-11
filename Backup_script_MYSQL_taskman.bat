@echo off

REM Get the current date and time
REM set mydate=%date:~6,4%-%date:~3,2%-%date:~0,2%
for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)
set mytime=%time%


REM Check if the hour part of the time is one digit
if "%mytime:~0,1%"==" " (
    set mytime=0%mytime:~1%
)

REM Remove the seconds and milliseconds from the time string
set mytime=%mytime:~0,5%

REM Replace spaces and colons with underscores and dashes, respectively
set mytime=%mytime: =_%"
set mytime=%mytime::=-%
set mytime=%mytime:"=%

REM Set the backup directory
SET backupdir=c:\backup\mysql\

mkdir %backupdir%


echo mydate: %mydate% > %backupdir%time.txt
echo mytime: %mytime% >> %backupdir%time.txt

REM Set the MySQL username and password
SET mysqlusername=root
SET mysqlpassword=root


REM Backup all databases
c:\MAMP\bin\mysql\bin\mysql.exe -u%mysqlusername% -p%mysqlpassword% -e "show databases;" | findstr /v "Database information_schema mysql performance_schema" > %backupdir%databases.txt

for /f "tokens=1" %%i in (%backupdir%databases.txt) do (
    c:\MAMP\bin\mysql\bin\mysqldump.exe -u%mysqlusername% -p%mysqlpassword% --default-character-set=utf8mb4 --add-drop-database -B %%i > %backupdir%\%%i_%mydate%_%mytime%.sql
)

REM Delete the temporary file
del %backupdir%databases.txt

echo All databases have been backed up successfully!


:: Get the script directory
set "currentDir=%~dp0"

CALL %currentDir%zip.bat
