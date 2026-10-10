#!/bin/bash
# Double-click to start DOTOPIA (a private world on this computer) and open it in your browser.
# If macOS refuses to open this file, right-click it and choose Open.
cd "$(dirname "$0")" || exit 1
# a double-clicked script does not always see where Node.js was installed
export PATH="$PATH:/usr/local/bin:/opt/homebrew/bin"
if ! command -v node >/dev/null 2>&1; then
  echo
  echo "DOTOPIA needs Node.js, which is not installed on this computer yet."
  echo "Opening nodejs.org: download the LTS version, install it, then double-click this file again."
  echo
  open "https://nodejs.org/"
  read -r -p "Press Enter to close this window."
  exit 1
fi
node server/launch.mjs
echo
read -r -p "DOTOPIA has stopped. Press Enter to close this window."
