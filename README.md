# 🛸 Cloud Cluster — Live Mission Control & Fleet Monitor

An ultra-lightweight, real-time distributed cluster monitoring dashboard and deadlock detection daemon engineered for Linux microservice architectures.

[![Language: Python 3](https://img.shields.io/badge/Language-Python%203-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![RAM Footprint: <15MB](https://img.shields.io/badge/RAM%20Footprint-%3C15MB-10b981?style=for-the-badge)](https://github.com/nazrisyahmi97/cloud-cluster-monitor)
[![CPU Overhead: <0.1%](https://img.shields.io/badge/CPU%20Overhead-%3C0.1%25-10b981?style=for-the-badge)](https://github.com/nazrisyahmi97/cloud-cluster-monitor)
[![Dependencies: Zero](https://img.shields.io/badge/Dependencies-Zero%20(Stdlib)-6366f1?style=for-the-badge)](https://github.com/nazrisyahmi97/cloud-cluster-monitor)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)](LICENSE)

---

## ⚡ Highlights

* **Zero External Dependencies**: 100% written using the Python 3 standard library (`http.server`, `/proc` parser, `urllib`, `socket`, `threading`). No Flask, Django, Prometheus, or third-party pip dependencies required.
* **Ultra-Low Resource Footprint**: Runs at **<15 MB RAM** and **<0.1% CPU overhead**, making it ideal for high-throughput production nodes without taking memory away from JVM microservices.
* **Spring Boot Actuator Prober**: Actively queries `/actuator/info` across distributed nodes to catch silent application deadlocks or hung instances before end-users notice.
* **Service Discovery Aware**: Integrates directly with Spring Cloud Eureka or custom registry endpoints.
* **Modern Glassmorphism HUD**: Responsive, dark-themed operations dashboard with SVG resource dials, memory saturation meters, live microservice search, and instant modal diagnostics.
* **Built-in Demo Simulation**: Allows instant evaluation on any computer (`python server.py --demo`) without needing a physical 4-node cluster.

---

## 🏗️ Architecture Overview

```
                        [ BROWSER HUD CLIENTS ]
                                   │
                           HTTP 8080 (Single Page)
                                   ▼
                   ┌────────────────────────────────┐
                   │  Cluster Monitor Daemon        │
                   │  server.py (Python 3 Stdlib)   │
                   │  /metrics.json (<15MB RAM)     │
                   └────────────────────────────────┘
                                   │
         ┌─────────────────┬───────┴─────────┬─────────────────┐
         │ (HTTP Actuator) │                 │ (HTTP Actuator) │
         ▼                 ▼                 ▼                 ▼
  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐
  │   Node 01    │  │   Node 02    │  │   Node 03    │  │   Node 04    │
  │ Edge Gateway │  │ Core Svc     │  │ Async Worker │  │ Analytics    │
  │ Auth & Web   │  │ Order/Pay    │  │ Reports      │  │ Telemetry    │
  └──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘
```

---

## 🚀 Quick Start & Local Demo

You can test-drive the live HUD locally on Windows, macOS, or Linux in under 5 seconds:

```bash
# Clone the repository
git clone https://github.com/nazrisyahmi97/cloud-cluster-monitor.git
cd cloud-cluster-monitor

# Run in simulation demo mode (no cluster required!)
python server.py --demo
```

Open your browser to:
👉 **`http://localhost:8080/`**

---

## 📦 Production Deployment

### 1. Installation on Linux (RHEL / Rocky / CentOS / Ubuntu)
```bash
git clone https://github.com/nazrisyahmi97/cloud-cluster-monitor.git
cd cloud-cluster-monitor
chmod +x install.sh uninstall.sh server.py
sudo ./install.sh
```

The installer configures `/opt/cloud-cluster-monitor` and starts the systemd service:
```bash
# Check status
systemctl status cluster-dashboard.service

# View live daemon logs
journalctl -u cluster-dashboard.service -f
```

---

## ⚙️ Configuration (`config.json`)

Configure your nodes, Eureka registry, and Spring Boot Actuator probe endpoints in `config.json`:

```json
{
  "server": {
    "port": 8080,
    "poll_interval_seconds": 4.5
  },
  "nodes": [
    { "id": "node01", "ip": "10.0.0.10", "name": "Node01 — Edge Gateway", "role": "API Gateway / Auth" },
    { "id": "node02", "ip": "10.0.0.11", "name": "Node02 — Core Services", "role": "Order / Payment" }
  ],
  "probes": [
    { "node": "Node03 (.12)", "ip": "10.0.0.12", "port": 8055, "name": "report-worker-primary" }
  ]
}
```

---

## 🛡️ License

Released under the [MIT License](LICENSE). Engineered by [Nazri Syahmi](https://github.com/nazrisyahmi97).
