REM Add windows scheduler task that will run every 30 minutes
REM Programm:
REM "C:\Program Files\Git\git-bash.exe"
REM Args:
REM %currentDir%exec_all_run.repo



@echo off
:: Check if the script is running as administrator
net session >nul 2>&1
if %errorLevel% == 0 (
    goto :runScript
) else (
    echo Requesting administrative privileges...
    goto :getAdmin
)

:getAdmin
:: Request administrative privileges
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /b



:runScript
:: Get the script directory
set "currentDir=%~dp0"

:: Create the scheduled task
schtasks /create /tn "Backup_script_MYSQL_taskman" /tr "\"%currentDir%Backup_script_MYSQL_taskman.bat\"" /sc minute /mo 30 /ru System

