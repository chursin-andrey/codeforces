@echo off


rem MINGW_HOME - ���� � MinGW
set MINGW_HOME=C:\Program_Files\MinGW

rem ���������� � ���� ���᪠ �ᯮ��塞�� 䠩��� (%PATH%) ��⥩ ��� ����᪠ gcc
set PATH=%MINGW_HOME%\bin;%PATH%

rem �⠭����� (�� testlib) 祪�� ��� �襭��
set CHECKER=lcmp



echo ��������� (gcc):
echo ------------------------------------------------------------
rem ��������� main.cpp
rem ����:
rem   -o <output> - ����� 䠩� ᮧ������
rem   -c - ⮫쪮 ���������, ��� ��������
rem   -Wl,--stack=<size> - 㪠���� ࠧ��� �⥪�
rem   -O3 - ���ᨬ��쭠� ��⨬�����
rem   -include <file> - ��������� (#include) ���������� 䠩�
rem   -I<path> - ���� ��� ���᪠ ������砥��� 䠩���
g++ -o .\solution.o -c -Wl,--stack=268435456 -O3 -include "%~dp0\checker_patch\solution_include.h" .\solution.cpp
g++ -o .\checker.o -c -Wl,--stack=268435456 -O3 -include "%~dp0\checker_patch\checker_include.h" -I"%~dp0\testlib" "%~dp0\testlib\checkers\%CHECKER%.cpp"
echo. & echo.

echo �������� (gcc):
echo ------------------------------------------------------------
rem �������� main.o � �ᯮ��塞� 䠩�
rem ����:
rem   -o <output> - ����� 䠩� ᮧ������
rem   -s - 㤠���� ��� ᨬ������ ���ଠ�� � ���ଠ�� � ࠧ��饭��
rem        (remove all symbol table and relocation information from the executable)
rem   -static - ����᪠� ��������
g++ -o .\checker.exe -s -static .\solution.o .\checker.o
echo. & echo.


del .\solution.o .\checker.o >nul 2>nul
