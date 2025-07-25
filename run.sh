#!/usr/bin/env bash
set -e

FTP_DASHBOARD_FILE="/config/lovelace-ftp.yaml"

# 1. Crée le fichier de dashboard si inexistant
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

# 2. Ajoute automatiquement le dashboard via l'API
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
        "title": "FTP"
      }' || echo "[WARNING] Could not create dashboard (it may already exist)."
