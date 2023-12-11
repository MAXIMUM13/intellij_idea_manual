@ECHO OFF


REM -- Служебные операции --

SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION


REM -- Основной блок --

set epochDay=0
call epoch_day.bat %1

set epochDay0=%epochDay%
echo epochDay0: %epochDay0%


set epochDay=0
call epoch_day.bat %2

set epochDay1=%epochDay%
echo epochDay1: %epochDay1%


REM -- Служебные операции --

ENDLOCAL
