# FTP Dashboard Add-on

This Home Assistant add-on creates a new Lovelace UI dashboard called **FTP**.

## Usage
1. Install the add-on.
2. Add the following to your `configuration.yaml`:
```yaml
lovelace:
  dashboards:
    ftp-dashboard:
      mode: yaml
      title: "FTP"
      icon: mdi:server
      show_in_sidebar: true
      filename: lovelace-ftp.yaml
```
3. Restart Home Assistant.
