@echo off

setlocal enabledelayedexpansion


for %%F in (".\temp\input.??.txt") do (
  set FILENAME=%%~nxF
  for /f "tokens=2 delims=." %%A in ("!FILENAME!") do set NUM=%%A
)


md .\test
copy /y .\temp\input.??.txt .\test
echo 1 | findstr 2 >.\test\empty.txt
copy /y .\checker.exe .\test
(
  echo DIR_TESTS_INPUT = "input.*.txt"
  echo DIR_TESTS_ANSWER = "empty.txt"
  echo TESTER_PROGRAM = "checker.exe"
  echo FILE_INPUT = "input.txt"
  echo FILE_OUTPUT = "output.txt"
  echo NUM_TESTS = !NUM!

  echo.

  for %%F in (".\temp\input.??.txt") do (
    set FILENAME=%%~nxF
    for /f "tokens=2 delims=." %%A in ("!FILENAME!") do set NUM=%%A
    echo "!NUM!" 1 ""
  )

  echo.
  echo.
  echo.

  echo Time_Limit = 2
) >.\test\problem.cfg
