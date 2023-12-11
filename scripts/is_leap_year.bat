@ECHO OFF

REM -- Служебные операции --

SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

REM -- Основной блок --

REM -- 0 --

SET year=%1%
ECHO year: %year%

SET /A yearMod4 = %year% %% 4
ECHO yearMod4: %yearMod4%
SET /A yearMod100 = %year% %% 100
ECHO yearMod100: %yearMod100%
SET /A yearMod400 = %year% %% 400
ECHO yearMod400: %yearMod400%

REM -- 1 --

SET /A flag = 0
IF %yearMod4% == 0 (
	IF NOT %yearMod100% == 0 (
		SET /A flag = 1
	)
	IF %yearMod400% == 0 (
		SET /A flag = 1
	)
)

ECHO isLeapYear: %flag%

REM -- Возврат результата --

ENDLOCAL & SET /A isLeapYear = %flag%

REM -- Завершение пакетного файла --

EXIT /B
