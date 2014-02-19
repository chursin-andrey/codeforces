@echo off

setlocal enabledelayedexpansion


for /f "usebackq tokens=2 delims= " %%T in (`"%~dp0\sf_load.bat" %*`) do (
  set TASK=%%T
)

cd .\%TASK%

cmd /c "%~dp0\slt_make.vc.bat"
cmd /c "%~dp0\chk_make.vc.bat"

cmd /c "%~dp0\test_make.bat"
