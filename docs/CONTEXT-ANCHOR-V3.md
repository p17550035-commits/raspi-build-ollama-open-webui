# Context Anchor V3 — Full System Snapshot (Hybrid)

This file restores the full Raspberry Pi AI Stack context.  
It merges Context Anchor V2 with the complete Pi Deep Dive (system scan) you captured on Aug 26, 2026.

If all other context is lost, this file restores the entire architecture, services, ports, DNS, Docker, roadmap, and long‑term vision.

============================================================
1. PROJECT IDENTITY AND PHILOSOPHY
============================================================

Name: Raspberry Pi AI Stack — Pi Edition
Hardware: Raspberry Pi 4 Model B Rev 1.1 (4× Cortex‑A72, ARMv8, Revision c03111)

Core goals:
- Sovereign, offline‑first AI stack
- Tarball‑driven, deterministic installs
- External‑drive‑safe, repairable, transparent
- No hidden automation; user‑controlled updates
- Expandable into full local cloud and enterprise stack

============================================================
2. FILES, REPOS, AND DOCUMENTATION (V2 STRUCTURE)
============================================================

GitHub-style tree:

docs/
  index.html
  indexold.md
  MODEL-COMPATIBILITY.md
  ARCHITECTURE.md
  INSTALLER-SPEC.md
  README.md
  ROADMAP_V2.1.md
  ROADMAP_V2.2.md
  ROADMAP_DIAGRAMS.md
  ROADMAP_ARCHITECTURE_MASTER.md
  ROADMAP_PORTMAP_MASTER.md
  ROADMAP_DNS_MASTER.md
  ROADMAP_REVERSE_PROXY_MASTER.md
  ROADMAP_SERVICE_DEPENDENCY_MASTER.md
  ROADMAP_WIZARDSTACK_MASTER.md
  ROADMAP_SAFEZONE_MASTER.md
  ROADMAP_RUNNER_MASTER.md
  ROADMAP_TARBALL_MASTER.md
  ROADMAP_ENTERPRISE_MASTER.md
  index.md

  _includes/
    footer.html

  _layouts/
    default.html

  assets/
    css/
      style.css
      custom.css

scripts/
  install-docker-only.sh
  install-drive-check.sh
  install-gitea.sh
  install-minio.sh
  install-ollama-only.sh
  install-openwebui-only.sh
  install-postgres.sh
  install-qdrant.sh
  install-qwen-only.sh
  install-redis.sh

  core/
    install-basic-no-ollama.sh
    install-basic-with-ollama.sh
    install-basic.sh
    install-cleanup.sh
    install-enterprise-no-ollama.sh
    install-enterprise-with-ollama.sh
    install-enterprise.sh
    install-self-update.sh
    install-skeleton.sh
    install-upgrade-docker.sh
    install-upgrade-ollama.sh
    install-upgrade-manual.sh
    uninstall.sh

  models/
    ollama/
      install-model-llama3-8b-ollama.sh
      install-model-phi3-mini-ollama.sh
      install-model-phi3-small-ollama.sh
      install-model-qwen2.5-7b-ollama.sh

    openwebui/
      install-model-gemma2-2b-openwebui.sh
      install-model-mistral7b-openwebui.sh
      install-model-phi3-mini-openwebui.sh
      index.md
      .keep

  tarballs/
    .keep

index.html
INSTALLERS.html
INSTALLER-SPEC.html
ARCHITECTURE.html
TARBALLS.html
MODELS.html
MODEL-COMPATIBILITY.html
SYSTEMS.html
ROADMAP.html
README.html

============================================================
3. LIVE SYSTEM STATE (PI DEEP DIVE SNAPSHOT)
============================================================

-------------------------
3.1 Storage and Memory
-------------------------

Disks (lsblk):
- mmcblk0p1 → bootfs (/boot/firmware)
- mmcblk0p2 → rootfs (/), 21.9G free, 77% used
- loop0 swap
- zram0 swap

Memory:
- Total: ~3.8 GB
- Available: ~3.0 GB
- Swap: ~2.0 GB total, ~1.4 GB free

-------------------------
3.2 Core Services (systemd + processes)
-------------------------

Active services:
- NSD (authoritative DNS)
- Unbound (recursive DNS)
- AdGuardHome (network blocker)
- Caddy (reverse proxy)
- Docker + containerd
- Ollama
- Prometheus node exporter
- NetworkManager
- SSH
- Avahi

Key processes:
- /usr/sbin/nsd -d
- /usr/sbin/unbound -d -p
- /home/redeye89/AdGuardHome/AdGuardHome -s run
- /usr/bin/caddy run --config /etc/caddy/Caddyfile
- /usr/bin/dockerd
- /usr/local/bin/ollama serve
- open_webui (uvicorn inside Docker)

-------------------------
3.3 Ports and Exposure
-------------------------

UDP:
- *:53 (NSD/AdGuard)
- 0.0.0.0:5300
- 127.0.0.1:5335 (Unbound)
- *:5353 (mDNS)

TCP:
- 22 (SSH)
- 2019 (Caddy admin)
- 8000 (Open WebUI Docker)
- 5300 / 5335 (DNS chain)
- 53 (NSD/AdGuard)
- 80 (Caddy HTTP)
- 3000 (future Gitea)
- 9090 / 9100 (Prometheus)
- 11434 (Ollama)

============================================================
4. DOCKER AND APPLICATION STACK
============================================================

Images:
- ghcr.io/open-webui/open-webui:latest (6.5GB)
- ghcr.io/open-webui/open-webui:main (same ID)
- ghcr.io/open-webui/open-webui:v0.11.1
- openwebui-arm64:latest (custom, 5.14GB)

Containers:
- openwebui (healthy, 8000→8080)

Volumes:
- openwebui

Networks:
- bridge
- host
- none

Non-Docker apps:
- AdGuardHome
- Ollama
- Caddy

============================================================
5. DNS, REVERSE PROXY, AND SOVEREIGNTY CHAIN
============================================================

NSD config:
- /etc/nsd/nsd.conf
- /etc/nsd/nsd.conf.d/
- /etc/nsd/sovereign.us.eu.org.zone
- nsd_control.key / pem
- nsd_server.key / pem

Zone file:

$ORIGIN sovereign.us.eu.org.
$TTL 3600

@   IN SOA ns1.sovereign.us.eu.org. hostmaster.sovereign.us.eu.org. (
        2026081702
        7200
        3600
        1209600
        3600 )

    IN NS ns1.sovereign.us.eu.org.
    IN NS ns2.sovereign.us.eu.org.

ns1 IN A 75.117.5.218
ns2 IN A 75.117.5.218

DNS chain:

Client → AdGuard → Unbound → Root
Client → AdGuard → NSD → Local Zone → Caddy → Services

Reverse proxy routing (planned):

ui.domain        → Open WebUI
git.domain       → Gitea
s3.domain        → MinIO
vector.domain    → Qdrant
db.domain        → Postgres
code.domain      → VS Code Server
wizard.domain    → Wizard Stack UI
bots.domain      → Automation Bots

============================================================
6. ARCHITECTURE, STACKS, AND FUTURE EXPANSION
============================================================

Current components:
- Open WebUI
- Ollama
- AdGuardHome
- Unbound
- NSD
- Caddy
- Docker
- Prometheus node exporter

Planned enterprise stack:
- Postgres
- Redis
- Qdrant
- MinIO
- Gitea
- VS Code Server
- Wizard Stack UI
- Automation bots

Wizard stack:
- wizardctl CLI
- CUE schema engine
- Module registry
- Tool registry
- Tarball builder
- DNS generator
- Reverse proxy generator
- Health checks
- Repair logic
- Safezone integration

Runners:
- Proot runners (Ubuntu, Debian, Alpine, Arch, Fedora)
- Docker ARM64 runners

Safezone:
- Filesystem sandbox
- Network sandbox
- Resource controller
- Permission engine
- Audit/logging

============================================================
7. TARBALL SYSTEM AND INSTALLER LOGIC
============================================================

Tarball types:
- Service tarballs
- Model tarballs
- Upgrade tarballs

Workflow:
Download → Checksum → Smart Installer → Extract → Deploy → Store → Upgrade

Smart installer features:
- Drive detection
- Safe overwrite rules
- SHA256 validation
- Docker loader integration
- Repair and self-update logic

============================================================
8. ENVIRONMENT AND USER CONTEXT
============================================================

User: redeye89
Home: /home/redeye89
Shell: /bin/bash
PATH: standard Debian/Raspberry Pi path
Session: SSH from 192.168.254.104 → Pi 192.168.254.110

============================================================
9. LONG-TERM VISION
============================================================

The Pi becomes:
- Sovereign dev environment
- Local cloud and AI workstation
- Git hosting + CI/CD
- DNS + reverse proxy hub
- Model server and workflow engine
- Tarball-based deployment platform
- Multi-OS build farm
- VS Code Server IDE
- Fully offline AI ecosystem

============================================================
10. MEMO
============================================================

This V3 anchor merges V2 design with the full Pi Deep Dive.  
If context is ever lost, paste this entire file to restore the system.
