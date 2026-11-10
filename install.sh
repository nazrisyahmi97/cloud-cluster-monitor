#!/bin/bash
set -euo pipefail

echo "=========================================================="
echo "Installing Cloud Cluster Real-Time Health & Ops Dashboard"
echo "=========================================================="

INSTALL_DIR="/opt/cloud-cluster-monitor"
SYSTEMD_FILE="/etc/systemd/system/cluster-dashboard.service"

mkdir -p "$INSTALL_DIR"
if [ "$(cd "$(dirname "$0")" && pwd)" != "$INSTALL_DIR" ]; then
    cp server.py "$INSTALL_DIR/server.py"
    cp index.html "$INSTALL_DIR/index.html"
    [ -f config.json ] && cp config.json "$INSTALL_DIR/config.json"
    [ -f known_services.json ] && cp known_services.json "$INSTALL_DIR/known_services.json"
fi
chmod 755 "$INSTALL_DIR/server.py"

cp cluster-dashboard.service "$SYSTEMD_FILE"

# Open firewall port if firewalld is active
if systemctl is-active --quiet firewalld; then
    echo "Configuring firewalld for port 8080..."
    firewall-cmd --zone=public --add-port=8080/tcp --permanent >/dev/null 2>&1 || true
    firewall-cmd --reload >/dev/null 2>&1 || true
fi

systemctl daemon-reload
systemctl enable cluster-dashboard.service
systemctl restart cluster-dashboard.service

echo ""
echo "✅ Installation complete!"
echo "Service status: systemctl status cluster-dashboard.service"
echo "Dashboard running at: http://localhost:8080"
echo "=========================================================="
