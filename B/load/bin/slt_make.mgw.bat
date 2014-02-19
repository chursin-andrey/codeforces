@echo off


rem MINGW_HOME - ���� � MinGW
set MINGW_HOME=C:\Program_Files\MinGW

rem ���������� � ���� ���᪠ �ᯮ��塞�� 䠩��� (%PATH%) ��⥩ ��� ����᪠ gcc
set PATH=%MINGW_HOME%\bin;%PATH%



echo ��������� (gcc):
echo ------------------------------------------------------------
rem ��������� main.cpp
rem ����:
rem   -o <output> - ����� 䠩� ᮧ������
rem   -c - ⮫쪮 ���������, ��� ��������
rem   -Wl,--stack=<size> - 㪠���� ࠧ��� �⥪�
rem   -O3 - ���ᨬ��쭠� ��⨬�����
rem   -include <file> - ��������� (#include) ���������� 䠩�
g++ -o .\solution.o -c -Wl,--stack=268435456 -O3 -include "%~dp0\solution_patch\solution_include.h" .\solution.cpp
echo. & echo.

echo �������� (gcc):
echo ------------------------------------------------------------
rem �������� main.o � �ᯮ��塞� 䠩�
rem ����:
rem   -o <output> - ����� 䠩� ᮧ������
rem   -s - 㤠���� ��� ᨬ������ ���ଠ�� � ���ଠ�� � ࠧ��饭��
rem        (remove all symbol table and relocation information from the executable)
rem   -static - ����᪠� ��������
g++ -o .\solution.exe -s -static .\solution.o
echo. & echo.


del .\solution.o >nul 2>nul
