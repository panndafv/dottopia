@echo off
rem Double-click to start DOTOPIA (a private world on this computer) and open it in your browser.
rem Close this window, or press Ctrl+C, to stop. The world is saved and carries on next time.
title DOTOPIA
cd /d "%~dp0"
where node >nul 2>nul
if errorlevel 1 (
  echo.
  echo DOTOPIA needs Node.js, which is not installed on this computer yet.
  echo Opening nodejs.org: download the LTS version, install it with the default options,
  echo then double-click this file again.
  echo.
  start "" "https://nodejs.org/"
  pause
  exit /b 1
)
node server\launch.mjs
echo.
echo DOTOPIA has stopped.
pause
