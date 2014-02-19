@echo off


rem VS_HOME - ���� � Visual Studio
rem VC_HOME - ���� � Visual C++
rem MSDK_HOME - ���� � Windows SDK
set VS_HOME=C:\Program Files (x86)\Microsoft Visual Studio 10.0
::set VS_HOME=C:\Program Files\Microsoft Visual Studio 9.0
set VC_HOME=%VS_HOME%\VC
set MSDK_HOME=C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A
::set MSDK_HOME=C:\Program Files\Microsoft SDKs\Windows\v6.0A

rem ���������� � ���� ���᪠ �ᯮ��塞�� 䠩��� (%PATH%) ��⥩ ��� ����᪠ cl � link
set PATH=%VS_HOME%\Common7\IDE;%VC_HOME%\bin;%PATH%

rem �⠭����� (�� testlib) 祪�� ��� �襭��
set CHECKER=lcmp



echo ��������� (cl):
echo ------------------------------------------------------------
rem ��������� main.cpp
rem ����:
rem   /Fo<output> - ����� ��ꥪ�� 䠩� ᮧ������
rem   /c - ⮫쪮 ���������, ��� ��������
rem   /F<size> - 㪠���� ࠧ��� �⥪�
rem   /O2 - ��ਬ����� ��� ����த���⢨�
rem   /EHsc - ��-� � ��ࠡ�⪮� �᪫�祭�� (�. http://msdn.microsoft.com/en-us/library/1deeycx5.aspx)
rem   /FI<file> - ��������� (#include) ���������� 䠩�
rem   /I<path> - 㪠���� ��४��� ���᪠ ������砥��� 䠩��� (*.h)
cl /Fo.\solution.obj /c /F268435456 /O2 /EHsc /I"%VC_HOME%\include" /FI"%~dp0\solution_patch\solution_include.h" .\solution.cpp
echo. & echo.

echo �������� (link):
echo ------------------------------------------------------------
rem �������� main.obj � �ᯮ��塞� 䠩�
rem ����:
rem   /out:<output> - ����� 䠩� ᮧ������
rem   /libpath:<path> - 㪠���� ��४��� ���᪠ ������⥪ (*.lib), �릭�� ��� ��������
link /out:.\solution.exe /libpath:"%MSDK_HOME%\lib" /libpath:"%VC_HOME%\lib" .\solution.obj
echo. & echo.


del .\solution.obj >nul 2>nul
