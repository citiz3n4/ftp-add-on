#!/usr/bin/env bash
set -e

FTP_DASHBOARD_FILE="/config/lovelace-ftp.yaml"

# Create the FTP dashboard if it doesn't exist
if [ ! -f "$FTP_DASHBOARD_FILE" ]; then
    cat <<EOL > $FTP_DASHBOARD_FILE
title: FTP
views:
  - title: FTP Dashboard
    path: ftp
    cards:
      - type: markdown
        content: |
          # Welcome to the FTP Dashboard
          This dashboard was created by the FTP Add-on.
EOL
fi

echo "[INFO] FTP Dashboard created (lovelace-ftp.yaml)."
