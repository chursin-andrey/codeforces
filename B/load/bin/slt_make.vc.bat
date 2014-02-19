@echo off


rem VS_HOME - путь к Visual Studio
rem VC_HOME - путь к Visual C++
rem MSDK_HOME - путь к Windows SDK
set VS_HOME=C:\Program Files (x86)\Microsoft Visual Studio 10.0
::set VS_HOME=C:\Program Files\Microsoft Visual Studio 9.0
set VC_HOME=%VS_HOME%\VC
set MSDK_HOME=C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A
::set MSDK_HOME=C:\Program Files\Microsoft SDKs\Windows\v6.0A

rem добавление к путям поиска исполняемых файлов (%PATH%) путей для запуска cl и link
set PATH=%VS_HOME%\Common7\IDE;%VC_HOME%\bin;%PATH%

rem стандартный (из testlib) чекер для решения
set CHECKER=lcmp



echo компиляция (cl):
echo ------------------------------------------------------------
rem компиляция main.cpp
rem ключи:
rem   /Fo<output> - какой объектный файл создавать
rem   /c - только компиляция, без линковки
rem   /F<size> - указать размер стека
rem   /O2 - опримизация для быстродействия
rem   /EHsc - что-то с обработкой исключений (см. http://msdn.microsoft.com/en-us/library/1deeycx5.aspx)
rem   /FI<file> - подключить (#include) заголовочный файл
rem   /I<path> - указать директорию поиска подключаемых файлов (*.h)
cl /Fo.\solution.obj /c /F268435456 /O2 /EHsc /I"%VC_HOME%\include" /FI"%~dp0\solution_patch\solution_include.h" .\solution.cpp
echo. & echo.

echo линковка (link):
echo ------------------------------------------------------------
rem линковка main.obj в исполняемый файл
rem ключи:
rem   /out:<output> - какой файл создавать
rem   /libpath:<path> - указать директорию поиска библиотек (*.lib), ныжных для линковки
link /out:.\solution.exe /libpath:"%MSDK_HOME%\lib" /libpath:"%VC_HOME%\lib" .\solution.obj
echo. & echo.


del .\solution.obj >nul 2>nul
