---
layout: default
title: Context Anchor — Full System & Future Plan Snapshot
---

# Context Anchor — Full System & Future Plan Snapshot  
**This page is the master context restore point for the entire Raspberry Pi AI Stack (Pi Edition).**  
It contains everything required to fully reconstruct the system’s architecture, roadmap, design philosophy, repo layout, installers, tarball system, enterprise stack, wizard stack, runners, safezone, DNS chain, reverse proxy, and future expansion plans.

If all other context is lost, this page restores 100% of the system’s intent and structure.

---

# 🧩 1. Core Identity of the Project

**Project Name:** Raspberry Pi AI Stack — Pi Edition  
**Primary Goal:** A fully offline, sovereign AI development environment running on Raspberry Pi.  
**Design Philosophy:**  
- Offline‑first  
- Tarball‑driven  
- Deterministic installs  
- External‑drive‑safe  
- Modular  
- Repairable  
- Transparent  
- No hidden automation  
- User‑controlled updates  
- Enterprise‑grade architecture  
- Expandable into a full local cloud

---

# 🧱 2. Current System Components (as of today)

### ✔ Open WebUI — Pi Edition  
- Prebuilt venv  
- Prebuilt frontend  
- Extracts via tarball  
- Runs on port **8080**

### ✔ Open WebUI — Docker ARM64 Edition  
- Prebuilt Docker image  
- Runs on port **8000**

### ✔ Ollama  
- LLM runtime  
- GGUF model support  
- Port **11434**

### ✔ Smart Installer  
- Install + repair + health‑check  
- External‑drive detection  
- Safe‑mode overwrite protection  
- Checksum validation  
- Docker image loader  
- Tarball validator

### ✔ Tarball System  
- openwebui‑pi‑edition.tar.gz  
- openwebui‑arm64.tar  
- SHA256 validation  
- Predictable extraction  
- No dependency hell

### ✔ Folder Structure  
```
/mnt/pidrive/stack/
    openwebui/
    logs/
    backups/
    models/
    postgres/
    redis/
    qdrant/
    minio/
    gitea/
    docker-compose.yml
```

Fallback:
```
~/pistack/stack/
```

### ✔ Documentation System  
All pages stored as `.html` under GitHub Pages.

---

# 🧭 3. Enterprise Architecture (Future Mode)

The Pi Edition will expand into a **full enterprise stack**:

### ✔ Core Services  
- **Postgres** (5432)  
- **Redis** (6379)  
- **Qdrant** (6333)  
- **MinIO** (9000/9001)  
- **Gitea** (3000 / 222 SSH)  
- **VS Code Server** (reverse‑proxied)  
- **Open WebUI** (8080/8000)  
- **Ollama** (11434)

### ✔ Reverse Proxy  
- **Caddy or Nginx**  
- Ports **80/443**  
- Handles all public‑facing subdomains

### ✔ DNS Sovereignty  
- **NSD** — authoritative DNS (53)  
- **AdGuard Home** — LAN DNS (53)  
- **Unbound** — recursive DNS (5335)

### ✔ Subdomain Routing  
```
ui.domain → Open WebUI
git.domain → Gitea
s3.domain → MinIO
vector.domain → Qdrant
db.domain → Postgres
code.domain → VS Code Server
wizard.domain → Wizard Stack UI
bots.domain → Automation Dashboards
```

---

# 🧙 4. Wizard Stack (Full Version)

This is the **real Wizard Stack** originally built in Termux using proot‑Ubuntu:

### ✔ Components  
- wizardctl CLI  
- CUE schema engine  
- Module registry  
- Tool registry  
- Build orchestrator  
- Multi‑OS runner manager  
- Tarball builder  
- DNS config generator  
- Installer engine  
- Wizard Stack UI  
- Automation bots  
- Safezone integration

### ✔ Capabilities  
- Build pipelines  
- Test pipelines  
- Tarball creation  
- Tarball publishing  
- Service installers  
- DNS zone generation  
- Reverse proxy route generation  
- Runner orchestration  
- Workflow automation  
- Health checks  
- Repair logic

---

# 🏃 5. Multi‑OS Runners

### ✔ Proot‑based OS environments  
- Ubuntu  
- Debian  
- Alpine  
- Arch  
- Fedora

### ✔ Docker ARM64 runners  
- Containerized builds  
- CI/CD pipelines  
- Service builds  
- Test pipelines

### ✔ Runner orchestration  
- Task scheduling  
- Health tracking  
- Concurrency management  
- Artifact collection  
- Log collection

---

# 🔒 6. Safezone Sandbox

### ✔ Purpose  
Protect the Pi from tools, agents, bots, runners, and workflows.

### ✔ Features  
- Filesystem sandbox  
- Network sandbox  
- Resource controller  
- Permission engine  
- Execution sandbox  
- Audit/logging layer  
- Output collector

---

# 📦 7. Tarball System (Full Version)

### ✔ Tarball Types  
- Service tarballs  
- Model tarballs  
- Upgrade tarballs

### ✔ Tarball Workflow  
```
Download → Checksum → Smart Installer → Extract → Deploy → Store → Upgrade
```

### ✔ Tarball Builder  
- Built by Wizard Stack  
- Metadata generation  
- Manifest creation  
- Checksum generation  
- Publishing via bots

---

# 🌐 8. DNS Chain (Full Sovereign Mode)

```
Client → AdGuard → Unbound → Root Servers
Client → AdGuard → NSD → Local Zone → Reverse Proxy → Services
```

---

# 🔁 9. Reverse Proxy Routing (Full Map)

```
ui.domain        → Open WebUI
git.domain       → Gitea
s3.domain        → MinIO
vector.domain    → Qdrant
db.domain        → Postgres
code.domain      → VS Code Server
wizard.domain    → Wizard Stack UI
bots.domain      → Automation Bots
```

---

# 🧩 10. Repo Structure (Current + Future)

### ✔ Current  
```
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
assets/css/
docs/
```

### ✔ New Documentation Files  
```
ROADMAP_V2.2.html
ROADMAP_DIAGRAMS.html
ROADMAP_ARCHITECTURE_MASTER.html
ROADMAP_PORTMAP_MASTER.html
ROADMAP_DNS_MASTER.html
ROADMAP_REVERSE_PROXY_MASTER.html
ROADMAP_SERVICE_DEPENDENCY_MASTER.html
ROADMAP_WIZARDSTACK_MASTER.html
ROADMAP_SAFEZONE_MASTER.html
ROADMAP_RUNNER_MASTER.html
ROADMAP_TARBALL_MASTER.html
ROADMAP_ENTERPRISE_MASTER.html
CONTEXT-ANCHOR.html (this file)
```

---

# 🧭 11. Long‑Term Vision

The Pi Edition becomes:

- A sovereign dev environment  
- A local cloud  
- A full AI workstation  
- A Git hosting platform  
- A CI/CD automation system  
- A DNS server  
- A reverse proxy  
- A model server  
- A workflow engine  
- A tarball‑based deployment platform  
- A multi‑OS build farm  
- A VS Code Server IDE  
- A fully offline AI ecosystem  

All running on a Raspberry Pi.  
All controlled by you.  
All documented.  
All reproducible.

---

{% include footer.html %}
