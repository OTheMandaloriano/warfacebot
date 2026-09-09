@echo off
title WarfaceBot Dashboard
if exist "%ProgramFiles%\Git\bin\bash.exe" (
    "%ProgramFiles%\Git\bin\bash.exe" wb_dashboard.sh
) else (
    bash wb_dashboard.sh
)
pause

