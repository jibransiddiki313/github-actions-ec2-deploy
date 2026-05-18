#!/bin/bash
set -e
 
cd /var/www/myapp
npm install --production
 
# Start app in background
nohup node app.js > /var/log/myapp.log 2>&1 &
 
echo "Server started on port 3000"
