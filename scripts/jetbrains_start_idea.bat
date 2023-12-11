@ECHO OFF

REM -- Служебные операции --

SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

REM -- Глобальные переменные --

SET WORK_DIR="%~dp0"

REM -- Основной блок --

REM -- 0. Получение даты последнего сброса пробного периода --

SET /P lastResetDay=<"%WORK_DIR%\jetbrains_evaluation.txt"
ECHO lastResetDay: %lastResetDay%

REM -- 1. Вычисление количества дней с начала эпохи для даты последнего сброса пробного периода --

SET epochDay=0
CALL %WORK_DIR%\epoch_day.bat %lastResetDay%

SET epochDay0=%epochDay%
ECHO epochDay0: %epochDay0%

REM -- 2. Вычисление количества дней с начала эпохи для текущей даты --

SET epochDay=0
CALL %WORK_DIR%\epoch_day.bat %date%

SET epochDay1=%epochDay%
ECHO epochDay1: %epochDay1%

REM -- 3. Вычисление разницы в днях между текущей датой и датой последнего сброса пробного периода --

SET /A dayDifference = %epochDay1% - %epochDay0%
ECHO dayDifference: %dayDifference%

REM -- 4. Выполнение проверки, необходимо ли сбросить пробный период

IF %dayDifference% GEQ 30 (
	SET isDay=1
)

IF DEFINED isDay (
	GOTO :resetEvaluation
) ELSE (
	GOTO :continueEvaluation
)

REM -- 5.A. Сброс пробного периода

:resetEvaluation

ECHO Reset evaluation:
ECHO %date%>"%WORK_DIR%\jetbrains_evaluation.txt"
CALL %WORK_DIR%\jetbrains_reset_evaluation.bat

GOTO :startIdea

REM -- 5.B. Продолжение текущего пробного периода

:continueEvaluation

ECHO Evaluation continued

REM -- Служебные операции --

ENDLOCAL

REM -- 6. Запуск IntelliJ IDEA

:startIdea

START idea64.exe
