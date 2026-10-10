@echo off
rem Double-click to start DOTOPIA (a private world on this computer) and open it in your browser.
rem Close this window, or press Ctrl+C, to stop. The world is saved and carries on next time.
title DOTOPIA
cd /d "%~dp0"

rem find Node.js: on the PATH, or where the nodejs.org installer puts it when the PATH is not refreshed yet
set "NODE="
where node >nul 2>nul && set "NODE=node"
if not defined NODE if exist "%ProgramFiles%\nodejs\node.exe" set "NODE=%ProgramFiles%\nodejs\node.exe"
if not defined NODE if exist "%LocalAppData%\Programs\nodejs\node.exe" set "NODE=%LocalAppData%\Programs\nodejs\node.exe"
if not defined NODE (
  echo.
  echo DOTOPIA needs Node.js, which is not installed on this computer yet.
  echo Opening nodejs.org: download the LTS version, install it with the default options,
  echo then double-click this file again.
  echo.
  start "" "https://nodejs.org/"
  pause
  exit /b 1
)

"%NODE%" server\launch.mjs
echo.
echo DOTOPIA has stopped.
pause
