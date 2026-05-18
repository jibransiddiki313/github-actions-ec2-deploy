#!/bin/bash
set -e
 
if pgrep -f "node app.js" > /dev/null; then
  pkill -f "node app.js"
  echo "Server stopped"
else
  echo "Server was not running — skipping"
fi
