---
layout: default
title: Roadmap V2.2 — Sovereign Dev Stack + Multi‑OS Runners
---

# Roadmap V2.2 — Sovereign Dev Stack + NSD + Multi‑OS Runners  
This roadmap defines the long‑term vision for the Pi Edition as part of a fully sovereign development stack.  
It includes infrastructure, DNS, routing, automation, tarball systems, bots, wizard stack, multi‑OS runners, VS Code Server, and authoritative NSD integration.  
This is the master blueprint for how the entire system will operate once all hardware is available.

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

## ✔ DNS + Network Sovereignty

### NSD — Authoritative DNS Server
Provides authoritative DNS for your sovereign domain:

- Hosts your domain zone  
- Serves A/AAAA/CNAME/TXT/SRV records  
- Powers internal + external routing  
- Enables public‑facing services  
- Integrates with Caddy/Nginx  

**Ports:**
```
53/tcp
53/udp
```

### AdGuard Home — LAN DNS Filtering
**Port:** `53`

### Unbound — Recursive DNS Resolver
**Ports:** `5335/tcp`, `5335/udp`

### DNS Chain Overview
```
Client → AdGuard → Unbound → Root Servers
Client → AdGuard → NSD (authoritative zone)
```

---

# 🌐 Phase 3 — Reverse Proxy + Domain Routing

### Caddy or Nginx
Handles HTTPS + routing.

### Sovereign Dev Domain
Example:
```
yourdomain.eu.org
```

### Public‑Facing Services
- docs.yourdomain → GitHub Pages replacement  
- ui.yourdomain → Open WebUI  
- git.yourdomain → Gitea  
- s3.yourdomain → MinIO  
- vector.yourdomain → Qdrant  
- wizard.yourdomain → Wizard Stack UI  
- bots.yourdomain → Automation dashboards  
- code.yourdomain → VS Code Server  

---

# 🏢 Phase 4 — Enterprise Service Tarball System

Tarballs for every major service:

- `postgres.tar.gz`  
- `redis.tar.gz`  
- `qdrant.tar.gz`  
- `minio.tar.gz`  
- `gitea.tar.gz`  
- `nginx.tar.gz` or `caddy.tar.gz`  
- `adguard.tar.gz`  
- `unbound.tar.gz`  
- `nsd.tar.gz`  

Each tarball includes:

- Prebuilt Docker images  
- Prebuilt configs  
- Folder structure  
- Checksum validation  
- Smart Installer integration  

---

# 🤖 Phase 5 — Wizard Stack + Automation Bots

### Wizard Stack
A guided, interactive system that:

- Installs services  
- Configures ports  
- Maps domain routes  
- Generates NSD zone files  
- Creates tarballs  
- Builds Docker Compose files  
- Validates health  
- Repairs broken services  
- Manages multi‑OS runners  
- Deploys VS Code Server  

### Automation Bots
Bots that operate like GitHub Actions:

- Build tarballs  
- Validate checksums  
- Run tests  
- Deploy updates  
- Manage workflows  
- Trigger service restarts  
- Monitor logs  
- Auto‑backup data  
- Auto‑restore snapshots  

---

# 🧩 Phase 6 — Safezone Sandbox

A secure environment for tools, agents, and bots:

- Isolated execution  
- Controlled filesystem  
- Controlled network  
- Logging + auditing  
- Resource limits  
- Tool permission system  
- Agent sandboxing  

---

# 🧠 Phase 7 — Model Tarball Suite

Model tarballs:

- `qwen.tar.gz`  
- `llama.tar.gz`  
- `phi.tar.gz`  
- `mistral.tar.gz`  
- `coder-models.tar.gz`  
- `embedding-models.tar.gz`  

Includes GGUF + Ollama models, metadata, compatibility tables.

---

# 🔄 Phase 8 — Upgrade Tarball System

Upgrade tarballs:

- `openwebui-upgrade.tar.gz`  
- `enterprise-upgrade.tar.gz`  
- `models-upgrade.tar.gz`  
- `system-upgrade.tar.gz`  

Smart Installer handles validation, rollback, migration.

---

# 🖥 Phase 9 — Multi‑OS Build Runners (Proot + Docker)

This phase introduces **GitHub‑style runners** inside your Pi.

### ✔ Proot‑Based OS Environments
- Ubuntu runner  
- Debian runner  
- Alpine runner  
- Arch runner  
- Fedora runner  

Each runner provides:

- isolated build environments  
- reproducible builds  
- tarball generation  
- cross‑platform testing  

### ✔ Docker‑Based Runners
- ARM64 containers  
- x86 emulation (optional)  
- service‑specific runners  
- CI/CD pipelines  

### ✔ Wizard Stack Integration
Wizard Stack manages:

- runner creation  
- runner teardown  
- runner health checks  
- runner logs  
- runner resource limits  

### ✔ Gitea CI/CD Integration
Runners connect to Gitea:

- build pipelines  
- automated releases  
- tarball publishing  
- workflow automation  

This turns your Pi into a **local GitHub Actions clone**.

---

# 🧑‍💻 Phase 10 — VS Code Server Integration

VS Code Server provides:

- full IDE in browser  
- remote editing  
- debugging  
- terminal access  
- multi‑OS runner integration  
- wizard stack integration  

Served via:

```
code.yourdomain
```

Reverse‑proxied through Caddy/Nginx.

---

# 🌐 Phase 11 — Full Sovereign Dev Stack Integration

Everything comes together:

### Complete Port Mapping

```
53        → NSD (Authoritative DNS)
53        → AdGuard Home (LAN DNS)
5335      → Unbound (Recursive DNS)
80/443    → Caddy/Nginx (Reverse Proxy)
8080      → Open WebUI (Venv)
8000      → Open WebUI (Docker)
11434     → Ollama
5432      → Postgres
6379      → Redis
6333      → Qdrant
9000/9001 → MinIO
3000      → Gitea
222       → Gitea SSH
```

### Everything Unified
- DNS  
- reverse proxy  
- services  
- runners  
- VS Code Server  
- wizard stack  
- bots  
- tarballs  
- safezone  
- CI/CD  
- public‑facing pages  

---

# 🏁 Phase 12 — Final Form: Offline AI Cloud + Build Farm

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
- A multi‑OS build farm  
- A VS Code Server IDE  
- A fully offline AI ecosystem  

All running on a Raspberry Pi.  
All controlled by you.  
All documented.  
All reproducible.

---

{% include footer.html %}
