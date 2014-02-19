@echo off


rem MINGW_HOME - путь к MinGW
set MINGW_HOME=C:\Program_Files\MinGW

rem добавление к путям поиска исполняемых файлов (%PATH%) путей для запуска gcc
set PATH=%MINGW_HOME%\bin;%PATH%

rem стандартный (из testlib) чекер для решения
set CHECKER=lcmp



echo компиляция (gcc):
echo ------------------------------------------------------------
rem компиляция main.cpp
rem ключи:
rem   -o <output> - какой файл создавать
rem   -c - только компиляция, без линковки
rem   -Wl,--stack=<size> - указать размер стека
rem   -O3 - максимальная оптимизация
rem   -include <file> - подключить (#include) заголовочный файл
rem   -I<path> - путь для поиска подключаемых файлов
g++ -o .\solution.o -c -Wl,--stack=268435456 -O3 -include "%~dp0\checker_patch\solution_include.h" .\solution.cpp
g++ -o .\checker.o -c -Wl,--stack=268435456 -O3 -include "%~dp0\checker_patch\checker_include.h" -I"%~dp0\testlib" "%~dp0\testlib\checkers\%CHECKER%.cpp"
echo. & echo.

echo линковка (gcc):
echo ------------------------------------------------------------
rem линковка main.o в исполняемый файл
rem ключи:
rem   -o <output> - какой файл создавать
rem   -s - удалить всю символьную информацию и информацию о размещении
rem        (remove all symbol table and relocation information from the executable)
rem   -static - статическая линковка
g++ -o .\checker.exe -s -static .\solution.o .\checker.o
echo. & echo.


del .\solution.o .\checker.o >nul 2>nul
