---
layout: default
title: Roadmap V2 — Sovereign Dev Stack
---

# Roadmap V2 — Sovereign Dev Stack Edition  
This roadmap defines the long‑term vision for the Pi Edition as part of a fully sovereign development stack.  
It includes infrastructure, automation, DNS, routing, service orchestration, tarball systems, bots, and the wizard stack.  
This is the master blueprint for how the entire system will eventually operate once all hardware is available.

---

# 🚀 Phase 1 — Core Foundation (Completed)

The following components are already finished:

- Open WebUI Pi Edition tarball  
- Open WebUI Docker ARM64 tarball  
- Smart Installer (install + repair + health‑check)  
- External‑drive detection + SD fallback  
- Folder structure + storage architecture  
- Documentation suite  
- Architecture diagrams  
- Systems diagrams  
- Model compatibility framework  
- Tarball workflow  
- Manual update system  
- Installer Specification  
- Updated README, Installers, Homepage  

The foundation is complete.  
The sovereign stack will be built on top of this.

---

# 🧱 Phase 2 — Sovereign Infrastructure Layer

This phase establishes the core services that make the Pi Edition a **self‑contained development platform**.

### ✔️ DNS + Network Sovereignty
- AdGuard Home (LAN DNS filtering)  
- Unbound (recursive DNS resolver)  
- DNSSEC validation  
- Local root‑server resolution  
- Zero external DNS dependency  

### ✔️ Reverse Proxy + Domain Routing
- Caddy or Nginx  
- Automatic HTTPS (via domain provider)  
- Public‑facing pages served from Pi  
- GitHub Pages‑style static hosting  
- Reverse proxy routing for all services  
- Domain → service mapping  

### ✔️ Sovereign Dev Domain
- `<yourdomain>.eu.org`  
- Caddy/Nginx serving:  
  - Open WebUI  
  - Gitea  
  - MinIO  
  - Qdrant  
  - Custom pages  
  - Wizard stack UI  
  - Bot dashboards  

This creates a **local cloud** with public‑facing capability.

---

# 🏢 Phase 3 — Enterprise Service Tarball System

This phase introduces tarballs for every major service:

### ✔️ Enterprise Tarball Suite
- `postgres.tar.gz`  
- `redis.tar.gz`  
- `qdrant.tar.gz`  
- `minio.tar.gz`  
- `gitea.tar.gz`  
- `nginx.tar.gz` or `caddy.tar.gz`  
- `adguard.tar.gz`  
- `unbound.tar.gz`  

Each tarball includes:

- Prebuilt Docker images  
- Prebuilt configs  
- Prebuilt folder structure  
- Checksum validation  
- External‑drive‑safe extraction  
- Smart Installer integration  

This allows **full offline deployment** of the entire enterprise stack.

---

# 🤖 Phase 4 — Wizard Stack + Automation Bots

This phase transforms the Pi Edition into a **self‑automating development environment**.

### ✔️ Wizard Stack
A guided, interactive system that:

- Installs services  
- Configures ports  
- Maps domain routes  
- Sets up DNS  
- Creates tarballs  
- Generates systemd services  
- Builds Docker Compose files  
- Validates health  
- Repairs broken services  

Essentially:  
**A sovereign version of a cloud control panel.**

### ✔️ Automation Bots
Bots that operate like GitHub Actions + BuildBots:

- Build tarballs  
- Validate checksums  
- Run tests  
- Deploy updates  
- Manage workflows  
- Trigger service restarts  
- Monitor logs  
- Auto‑backup data  
- Auto‑restore snapshots  

All running locally, offline, inside your Pi.

---

# 🧩 Phase 5 — Safezone Sandbox

A secure environment for tools, agents, and bots:

### ✔️ Safezone Features
- Isolated execution  
- No access to host system  
- Controlled filesystem  
- Controlled network  
- Logging + auditing  
- Resource limits  
- Tool permission system  
- Agent sandboxing  

This allows:

- LLM agents  
- automation bots  
- workflows  
- scripts  

to run safely without risking the Pi’s core system.

---

# 🧠 Phase 6 — Model Tarball Suite

A complete offline model distribution system:

### ✔️ Model Tarballs
- `qwen.tar.gz`  
- `llama.tar.gz`  
- `phi.tar.gz`  
- `mistral.tar.gz`  
- `coder-models.tar.gz`  
- `embedding-models.tar.gz`  

Each tarball includes:

- GGUF models  
- Ollama models  
- Metadata  
- Compatibility tables  
- Smart Installer integration  

This makes model installation **offline, predictable, and reproducible**.

---

# 🔄 Phase 7 — Upgrade Tarball System

A unified upgrade mechanism:

### ✔️ Upgrade Tarballs
- `openwebui-upgrade.tar.gz`  
- `enterprise-upgrade.tar.gz`  
- `models-upgrade.tar.gz`  
- `system-upgrade.tar.gz`  

Smart Installer handles:

- checksum validation  
- safe extraction  
- versioning  
- rollback  
- migration  

This gives you **offline version control** for your entire stack.

---

# 🌐 Phase 8 — Full Sovereign Dev Stack Integration

Everything comes together:

### ✔️ Gitea Integration
- Local Git hosting  
- CI/CD pipelines  
- Bot‑driven builds  
- Tarball publishing  
- Automated releases  
- Workflow automation  

### ✔️ Public‑Facing Pages
Served via Caddy/Nginx:

- Documentation  
- Project pages  
- Dashboards  
- Status pages  
- Wizard UI  
- Bot UI  

### ✔️ Complete Port Mapping
Every service mapped cleanly:

- 80/443 → Caddy/Nginx  
- 3000 → Gitea  
- 9000/9001 → MinIO  
- 6333 → Qdrant  
- 5432 → Postgres  
- 6379 → Redis  
- 8080 → Open WebUI  
- 11434 → Ollama  
- 53 → AdGuard Home  
- 5335 → Unbound  

This ensures **zero conflicts** and **maximum stability**.

---

# 🏁 Phase 9 — Final Form: Offline AI Cloud

Once all phases are complete, your Pi becomes:

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
- A fully offline AI ecosystem  

All running on a Raspberry Pi.  
All controlled by you.  
All documented.  
All reproducible.

---

{% include footer.html %}
