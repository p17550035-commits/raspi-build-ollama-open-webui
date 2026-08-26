---
layout: default
title: Roadmap V2.1 — Sovereign Dev Stack + NSD Edition
---

# Roadmap V2.1 — Sovereign Dev Stack + NSD Edition  
This roadmap defines the long‑term vision for the Pi Edition as part of a fully sovereign development stack.  
It includes infrastructure, DNS, routing, automation, tarball systems, bots, wizard stack, and the authoritative NSD server.  
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

This phase establishes the core services that make the Pi Edition a **self‑contained development platform**.

## ✔ DNS + Network Sovereignty

### NSD — Authoritative DNS Server
NSD provides authoritative DNS for your sovereign domain:

- Hosts your domain zone  
- Serves A/AAAA/CNAME/TXT/SRV records  
- Powers internal + external routing  
- Enables public‑facing services  
- Integrates with Caddy/Nginx  
- Forms the backbone of your sovereign cloud  

**Ports:**
```
53/tcp
53/udp
```

### AdGuard Home — LAN DNS Filtering
- Local DNS filtering  
- Blocks ads, trackers, malware  
- Routes upstream queries to Unbound  

**Port:**
```
53
```

### Unbound — Recursive DNS Resolver
- Full recursive DNS  
- DNSSEC validation  
- Zero external dependency  
- Feeds filtered results back to AdGuard  

**Ports:**
```
5335/tcp
5335/udp
```

### DNS Chain Overview
```
Client → AdGuard → Unbound → Root Servers
Client → AdGuard → NSD (authoritative zone)
```

This creates a **sovereign DNS chain** with no external reliance.

---

# 🌐 Phase 3 — Reverse Proxy + Domain Routing

### Caddy or Nginx
Handles:

- HTTPS  
- Reverse proxy routing  
- Public‑facing pages  
- Internal service routing  
- Domain → service mapping  

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
- db.yourdomain → Postgres (optional)  
- wizard.yourdomain → Wizard Stack UI  
- bots.yourdomain → Automation dashboards  

This transforms your Pi into a **local cloud with public‑facing capability**.

---

# 🏢 Phase 4 — Enterprise Service Tarball System

Tarballs for every major service:

### ✔ Enterprise Tarball Suite
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
- Prebuilt folder structure  
- Checksum validation  
- External‑drive‑safe extraction  
- Smart Installer integration  

This enables **full offline deployment** of the entire enterprise stack.

---

# 🤖 Phase 5 — Wizard Stack + Automation Bots

### Wizard Stack
A guided, interactive system that:

- Installs services  
- Configures ports  
- Maps domain routes  
- Sets up DNS  
- Generates NSD zone files  
- Creates tarballs  
- Generates systemd services  
- Builds Docker Compose files  
- Validates health  
- Repairs broken services  

Essentially:  
**A sovereign version of a cloud control panel.**

### Automation Bots
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

# 🧩 Phase 6 — Safezone Sandbox

A secure environment for tools, agents, and bots:

### Safezone Features
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

# 🧠 Phase 7 — Model Tarball Suite

### Model Tarballs
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

# 🔄 Phase 8 — Upgrade Tarball System

### Upgrade Tarballs
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

# 🌐 Phase 9 — Full Sovereign Dev Stack Integration

Everything comes together:

### Gitea Integration
- Local Git hosting  
- CI/CD pipelines  
- Bot‑driven builds  
- Tarball publishing  
- Automated releases  
- Workflow automation  

### Public‑Facing Pages
Served via Caddy/Nginx:

- Documentation  
- Project pages  
- Dashboards  
- Status pages  
- Wizard UI  
- Bot UI  

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

This ensures **zero conflicts** and **maximum stability**.

---

# 🏁 Phase 10 — Final Form: Offline AI Cloud

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
