#!/bin/bash
# Ensure redis-function-logging (rflog) is installed globally.
# Exits 0 if already installed or successfully installed; 1 on failure.

if command -v rflog &>/dev/null; then
  exit 0
fi

echo "rflog not found. Installing redis-function-logging globally..."
npm install -g redis-function-logging 2>&1

if command -v rflog &>/dev/null; then
  echo "rflog installed successfully."
  exit 0
else
  echo "ERROR: Failed to install redis-function-logging. Try: npm install -g redis-function-logging"
  exit 1
fi
