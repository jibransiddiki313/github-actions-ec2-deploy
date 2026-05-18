#!/bin/bash
set -e
 
# Install Node.js if not present
if ! command -v node &> /dev/null; then
  curl -fsSL https://rpm.nodesource.com/setup_18.x | bash -
  yum install -y nodejs
fi
 
# Create app directory
mkdir -p /var/www/myapp
 
echo "Before install complete"
 
