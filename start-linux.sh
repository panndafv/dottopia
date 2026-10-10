#!/bin/bash
# Starts DOTOPIA (a private world on this computer) and opens it in your browser. Ctrl+C stops it.
cd "$(dirname "$0")" || exit 1
if ! command -v node >/dev/null 2>&1; then
  echo
  echo "DOTOPIA needs Node.js 20 or newer, which is not installed on this computer yet."
  echo "Get it from https://nodejs.org/ (or your package manager), then run this again."
  echo
  exit 1
fi
exec node server/launch.mjs
