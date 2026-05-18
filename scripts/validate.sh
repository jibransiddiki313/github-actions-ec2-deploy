#!/bin/bash
set -e
 
sleep 5
 
# Check if app is running
if pgrep -f "node app.js" > /dev/null; then
  echo "Validation passed — app is running"
  exit 0
else
  echo "Validation FAILED — app did not start"
  exit 1
fi
 
