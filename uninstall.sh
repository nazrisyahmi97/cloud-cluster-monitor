#!/bin/bash
set -euo pipefail

echo "=========================================================="
echo "Uninstalling Cloud Cluster Real-Time Health & Ops Dashboard"
echo "=========================================================="

SYSTEMD_FILE="/etc/systemd/system/cluster-dashboard.service"
INSTALL_DIR="/opt/cloud-cluster-monitor"

if systemctl is-active --quiet cluster-dashboard.service; then
    systemctl stop cluster-dashboard.service
fi

if systemctl is-enabled --quiet cluster-dashboard.service 2>/dev/null; then
    systemctl disable cluster-dashboard.service
fi

[ -f "$SYSTEMD_FILE" ] && rm -f "$SYSTEMD_FILE"
systemctl daemon-reload

if [ -d "$INSTALL_DIR" ]; then
    rm -rf "$INSTALL_DIR"
fi

echo "✅ Uninstallation complete!"
echo "=========================================================="
