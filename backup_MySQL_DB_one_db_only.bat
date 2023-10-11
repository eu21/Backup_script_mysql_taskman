@echo off
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)
For /f "tokens=1-2 delims=/:" %%a in ("%TIME%") do (set mytime=%%a%%b)

SET backupdir=c:\1\backup\mysql\site1\
SET mysqluername=root
SET mysqlpassword=root
SET database=site1

c:\MAMP\bin\mysql\bin\mysqldump.exe -u%mysqluername% -p%mysqlpassword%  --default-character-set=utf8mb4 --add-drop-database -B %database% > %backupdir%\%database%_%mydate%_%mytime%.sql

