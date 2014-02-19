@echo off


rem MINGW_HOME - путь к MinGW
set MINGW_HOME=C:\Program_Files\MinGW

rem добавление к путям поиска исполняемых файлов (%PATH%) путей для запуска gcc
set PATH=%MINGW_HOME%\bin;%PATH%



echo компиляция (gcc):
echo ------------------------------------------------------------
rem компиляция main.cpp
rem ключи:
rem   -o <output> - какой файл создавать
rem   -c - только компиляция, без линковки
rem   -Wl,--stack=<size> - указать размер стека
rem   -O3 - максимальная оптимизация
rem   -include <file> - подключить (#include) заголовочный файл
g++ -o .\solution.o -c -Wl,--stack=268435456 -O3 -include "%~dp0\solution_patch\solution_include.h" .\solution.cpp
echo. & echo.

echo линковка (gcc):
echo ------------------------------------------------------------
rem линковка main.o в исполняемый файл
rem ключи:
rem   -o <output> - какой файл создавать
rem   -s - удалить всю символьную информацию и информацию о размещении
rem        (remove all symbol table and relocation information from the executable)
rem   -static - статическая линковка
g++ -o .\solution.exe -s -static .\solution.o
echo. & echo.


del .\solution.o >nul 2>nul
