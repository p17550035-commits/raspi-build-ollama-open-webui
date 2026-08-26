---
layout: default
title: Context Anchor V2 — Full System Snapshot
---

# Context Anchor V2 — Full System Snapshot  
**This page restores 100% of the Raspberry Pi AI Stack (Pi Edition) context.**  
It contains EVERYTHING required to reconstruct your entire system, repo, architecture, installers, tarball workflow, enterprise stack, wizard stack, runners, safezone, DNS chain, reverse proxy, roadmap, and future plans.

If all other context is lost, this page brings the system back into perfect alignment.

---

# 📁 1. GitHub‑Style File Tree (Reconstructed from Screenshots)

*(This intentionally mirrors GitHub’s sidebar — not a normalized filesystem tree.)*

```
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

index.html (root)
INSTALLERS.html
INSTALLER-SPEC.html
ARCHITECTURE.html
TARBALLS.html
MODELS.html
MODEL-COMPATIBILITY.html
SYSTEMS.html
ROADMAP.html
README.html
```

---

# 🧩 2. Core Identity of the Project

**Project Name:** Raspberry Pi AI Stack — Pi Edition  
**Goal:** A sovereign, offline, modular AI environment for Raspberry Pi  
**Philosophy:**  
- Offline‑first  
- Tarball‑driven  
- Deterministic installs  
- External‑drive‑safe  
- Repairable  
- Transparent  
- No hidden automation  
- User‑controlled updates  
- Enterprise‑grade architecture  
- Expandable into a full local cloud

---

# 🧱 3. Current System Components

### ✔ Open WebUI — Pi Edition  
- Prebuilt venv  
- Prebuilt frontend  
- Port **8080**

### ✔ Open WebUI — Docker ARM64 Edition  
- Prebuilt image  
- Port **8000**

### ✔ Ollama  
- GGUF model runtime  
- Port **11434**

### ✔ Smart Installer  
- Drive detection  
- Safe‑mode overwrite protection  
- Tarball validation  
- Docker loader  
- Repair logic  
- Health checks

### ✔ Tarball System  
- openwebui‑pi‑edition.tar.gz  
- openwebui‑arm64.tar  
- SHA256 validation  
- Predictable extraction

### ✔ Folder Structure  
```
/mnt/pidrive/stack/
~/pistack/stack/ (fallback)
```

---

# 🏢 4. Enterprise Architecture (Future Mode)

### ✔ Core Services  
- Postgres (5432)  
- Redis (6379)  
- Qdrant (6333)  
- MinIO (9000/9001)  
- Gitea (3000 / 222)  
- VS Code Server  
- Open WebUI  
- Ollama

### ✔ Reverse Proxy  
- Caddy/Nginx  
- Ports 80/443

### ✔ DNS Sovereignty  
- NSD (53)  
- AdGuard Home (53)  
- Unbound (5335)

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

# 🧙 5. Wizard Stack (Full Version)

### ✔ Components  
- wizardctl CLI  
- CUE schema engine  
- Module registry  
- Tool registry  
- Build orchestrator  
- Runner manager  
- Tarball builder  
- DNS generator  
- Installer engine  
- Wizard Stack UI  
- Automation bots  
- Safezone integration

### ✔ Capabilities  
- Build pipelines  
- Test pipelines  
- Tarball creation  
- Tarball publishing  
- DNS zone generation  
- Reverse proxy route generation  
- Workflow automation  
- Health checks  
- Repair logic

---

# 🏃 6. Multi‑OS Runners

### ✔ Proot Runners  
- Ubuntu  
- Debian  
- Alpine  
- Arch  
- Fedora

### ✔ Docker ARM64 Runners  
- Containerized builds  
- CI/CD pipelines  
- Service builds  
- Test pipelines

### ✔ Runner Orchestration  
- Task scheduling  
- Health tracking  
- Concurrency management  
- Artifact collection  
- Log collection

---

# 🔒 7. Safezone Sandbox

### ✔ Features  
- Filesystem sandbox  
- Network sandbox  
- Resource controller  
- Permission engine  
- Execution sandbox  
- Audit/logging layer  
- Output collector

---

# 📦 8. Tarball System (Full Version)

### ✔ Tarball Types  
- Service tarballs  
- Model tarballs  
- Upgrade tarballs

### ✔ Workflow  
```
Download → Checksum → Smart Installer → Extract → Deploy → Store → Upgrade
```

### ✔ Tarball Builder  
- Metadata generation  
- Manifest creation  
- Checksum generation  
- Publishing via bots

---

# 🌐 9. DNS Chain

```
Client → AdGuard → Unbound → Root Servers
Client → AdGuard → NSD → Local Zone → Reverse Proxy → Services
```

---

# 🔁 10. Reverse Proxy Routing

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

# 📚 11. Documentation Structure

All `.md` files auto‑convert to `.html` via Jekyll.

Master pages include:

- Architecture  
- Port Map  
- DNS Routing  
- Reverse Proxy  
- Service Dependency  
- Wizard Stack  
- Safezone  
- Runner Orchestration  
- Tarball System  
- Enterprise Stack  
- Roadmap V2.2  
- Master Diagrams  

---

# 🚀 12. Long‑Term Vision

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

# 📝 Memo

> **This file tree is a best‑effort reconstruction from multiple GitHub sidebar screenshots.  
> After a context reload, you can provide updated screenshots and I will rebuild the tree with perfect accuracy.**

---

{% include footer.html %}
