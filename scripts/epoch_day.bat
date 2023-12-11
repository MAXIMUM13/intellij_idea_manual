@ECHO OFF

REM -- Служебные операции --

SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

REM -- Глобальные переменные --

SET WORK_DIR="%~dp0"

SET /A DAYS_PER_CYCLE = 146097
ECHO DAYS_PER_CYCLE: %DAYS_PER_CYCLE%

SET /A DAYS_0000_TO_1970 = (DAYS_PER_CYCLE * 5) - (30 * 365 + 7)
ECHO DAYS_0000_TO_1970: %DAYS_0000_TO_1970%

REM -- Основной блок --

REM -- 0 --

SET localDate=%1%
ECHO localDate: %localDate%

SET year=%localDate:~6%
ECHO year: %year%

SET month=%localDate:~3,2%
IF %month:~0,1% == 0 (
	SET month=%month:~1%
)
ECHO month: %month%

SET day=%localDate:~0,2%
IF %day:~0,1% == 0 (
	SET day=%day:~1%
)
ECHO day: %day%

SET /A total = 365 * %year%
ECHO total0: %total%

REM -- 1 --

IF %year% GEQ 0 GOTO :if0 ELSE GOTO :if1

:if0

SET /A total = %total% + ((%year% + 3) / 4 - (%year% + 99) / 100 + (%year% + 399) / 400)
GOTO :afterIf1

:if1

SET /A total = %total% - (%year% / -4 - %year% / -100 + %year% / -400)

:afterIf1

ECHO total1: %total%

REM -- 2 --

SET /A total = %total% + ((367 * %month% - 362) / 12)
ECHO total2: %total%

REM -- 3 --

SET /A total = %total% + (%day% - 1)
ECHO total3: %total%

REM -- 4 --

IF %month% GTR 02 (
	GOTO :gtThanFebruary
) ELSE (
	GOTO :leThanFebruary
)

:gtThanFebruary

set isLeapYear=0
call %WORK_DIR%\is_leap_year.bat %year%

SET /A total = %total% - 1
IF %isLeapYear% == 0 (
	SET /A total = %total% - 1
)

:leThanFebruary

ECHO total4: %total%

REM -- 5 --

SET /A total = %total% - %DAYS_0000_TO_1970%
ECHO total5: %total%

REM -- Возврат результата --

ENDLOCAL & SET /A epochDay = %total%

REM -- Завершение пакетного файла --

EXIT /B
