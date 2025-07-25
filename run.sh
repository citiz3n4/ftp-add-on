#!/usr/bin/env bash
set -e

echo "[INFO] Starting HTTP server on port 8080..."
python3 -m http.server 8080 &

FTP_DASHBOARD_FILE="/config/lovelace-ftp.yaml"

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

echo "[INFO] Creating FTP dashboard via Home Assistant API..."
curl -s -X POST \
  -H "Authorization: Bearer $SUPERVISOR_TOKEN" \
  -H "Content-Type: application/json" \
  http://supervisor/core/api/lovelace/dashboards \
  -d '{
        "id": "ftp-dashboard",
        "url_path": "ftp",
        "mode": "yaml",
        "filename": "lovelace-ftp.yaml",
        "title": "FTP",
        "icon": "mdi:server",
        "show_in_sidebar": true
      }' || echo "[WARNING] Could not create dashboard (it may already exist)."

wait
