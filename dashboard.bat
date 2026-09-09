@echo off
title WarfaceBot Dashboard
cd /d "%~dp0"
if exist "%ProgramFiles%\Git\bin\bash.exe" (
    "%ProgramFiles%\Git\bin\bash.exe" "%~dp0wb_dashboard.sh" %*
) else (
    bash "%~dp0wb_dashboard.sh" %*
)
