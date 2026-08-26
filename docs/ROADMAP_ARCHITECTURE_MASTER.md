---
layout: default
title: Master Architecture Diagram
---

# Master Architecture Diagram — Sovereign Dev Stack (ASCII)

This is the unified, top‑level architecture diagram for the entire Sovereign Dev Stack.  
It shows how every subsystem connects: DNS → Reverse Proxy → Services → Runners → Wizard Stack → Bots → Tarballs → Safezone → Storage.

All ASCII.  
GitHub‑safe.  
No rendering issues.

---

# 🌐 Sovereign Dev Stack — Master Architecture Diagram

```
                                      +---------------------------+
                                      |        Internet           |
                                      +-------------+-------------+
                                                    |
                                                    v
                                      +---------------------------+
                                      |     Caddy / Nginx         |
                                      |     (Reverse Proxy)       |
                                      |     Ports: 80 / 443       |
                                      +------+------+-------------+
                                             |      |
                      ------------------------      -------------------------
                      |                                                     |
                      v                                                     v

        +---------------------------+                     +---------------------------+
        |        Public UI          |                     |      Public Services      |
        |  ui.domain → OpenWebUI    |                     |  git.domain → Gitea       |
        |  docs.domain → Docs       |                     |  s3.domain → MinIO        |
        |  wizard.domain → Wizard   |                     |  vector.domain → Qdrant   |
        |  code.domain → VS Code    |                     |  db.domain → Postgres     |
        +-------------+-------------+                     +-------------+-------------+
                      |                                                     |
                      |                                                     |
                      v                                                     v

        +---------------------------+                     +---------------------------+
        |       Open WebUI          |                     |       Enterprise Stack     |
        |  (Venv or Docker Edition) |                     |  Postgres / Redis / MinIO |
        |  Ports: 8080 / 8000       |                     |  Qdrant / Gitea / Ollama  |
        +-------------+-------------+                     +-------------+-------------+
                      |                                                     |
                      |                                                     |
                      v                                                     v

        +---------------------------+                     +---------------------------+
        |       Wizard Stack        |                     |     Automation Bots       |
        |  - Installers             |                     |  - CI/CD Pipelines        |
        |  - Tarball Builder        |                     |  - Tarball Publisher      |
        |  - DNS Config Generator   |                     |  - Workflow Engine        |
        |  - Runner Manager         |                     |  - Health Checks          |
        +-------------+-------------+                     +-------------+-------------+
                      |                                                     |
                      |                                                     |
                      v                                                     v

        +---------------------------+                     +---------------------------+
        |     Multi-OS Runners      |                     |        Safezone           |
        |  - Proot Ubuntu           |                     |  - Isolated Execution     |
        |  - Debian / Alpine        |                     |  - Tool Permissions       |
        |  - Docker ARM64           |                     |  - Resource Limits        |
        |  - Build/Test Pipelines   |                     |  - Agent Sandbox          |
        +-------------+-------------+                     +-------------+-------------+
                      |                                                     |
                      |                                                     |
                      v                                                     v

        +---------------------------+                     +---------------------------+
        |       Tarball System      |                     |     Storage Architecture  |
        |  - Service Tarballs       |                     |  /mnt/pidrive/stack/      |
        |  - Model Tarballs         |                     |  - openwebui/             |
        |  - Upgrade Tarballs       |                     |  - models/                |
        |  - Checksum Validation    |                     |  - postgres/              |
        +-------------+-------------+                     |  - redis/                 |
                      |                                   |  - qdrant/                |
                      |                                   |  - minio/                 |
                      v                                   |  - gitea/                 |
                                                          +---------------------------+

```

---

# 🧭 Notes

- This diagram is the **top‑level architecture** for the entire Sovereign Dev Stack.  
- Every subsystem is represented: DNS → Proxy → Services → Wizard → Bots → Runners → Tarballs → Safezone → Storage.  
- ASCII format ensures **GitHub Pages cannot break it**.  
- This page is meant to be stored as:  
  ```
  docs/ROADMAP_ARCHITECTURE_MASTER.md
  ```

---

{% include footer.html %}
