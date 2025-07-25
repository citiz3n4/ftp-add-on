#!/usr/bin/env bash
set -e

# Démarrage du serveur HTTP
echo "[INFO] Starting HTTP server on port 8080..."
python3 -m http.server 8080 &

# Création du dashboard Lovelace (YAML)
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

# Appel API pour enregistrer le dashboard sans modifier configuration.yaml
echo "[INFO] Creating FTP dashboard via Home Assistant API..."
response=$(curl -w "%{http_code}" -s -X POST \
  -H "Authorization: Bearer \$SUPERVISOR_TOKEN" \
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
      }')
http_code="${response: -3}"
body="${response::-3}"
echo "[DEBUG] HTTP status: \${http_code}"
echo "[DEBUG] Response body: \$body"
if [ "\$http_code" != "201" ]; then
  echo "[ERROR] Failed to create dashboard"
else
  echo "[INFO] Dashboard created successfully"
fi

wait
