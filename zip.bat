@echo off

REM Set the source and destination directories
set "sourcedir=c:\backup\mysql\"
set "destdir=c:\backup\mysql_zip\"

mkdir %destdir%

REM Get the current date and time
set "mydate=%date:~6,4%-%date:~3,2%-%date:~0,2%"
set "mytime=%time:~0,2%-%time:~3,2%"

REM Replace any spaces and forward slashes in the time with underscores
set "mytime=%mytime: =_%"
set "mytime=%mytime:/=_%"

REM Create a separate archive for each file
for %%i in ("%sourcedir%\*.*") do (
    "C:\Program Files\7-Zip\7z.exe" a -tzip "%destdir%\%%~ni.zip" "%%i"
	del %%i
)

echo All files have been archived successfully!


