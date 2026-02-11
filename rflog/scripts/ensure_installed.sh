#!/bin/bash
# Ensure redis-function-logging (rflog) is installed globally and up to date.
# Exits 0 if ready; 1 on failure.

PACKAGE="redis-function-logging"

if command -v rflog &>/dev/null; then
  # Check for updates
  installed=$(rflog --version 2>/dev/null)
  latest=$(npm view "$PACKAGE" version 2>/dev/null)

  if [ -n "$latest" ] && [ "$installed" != "$latest" ]; then
    echo "rflog $installed installed, $latest available. Updating..."
    npm install -g "$PACKAGE@latest" 2>&1
  fi
  exit 0
fi

echo "rflog not found. Installing $PACKAGE globally..."
npm install -g "$PACKAGE" 2>&1

if command -v rflog &>/dev/null; then
  echo "rflog installed successfully."
  exit 0
else
  echo "ERROR: Failed to install $PACKAGE. Try: npm install -g $PACKAGE"
  exit 1
fi
