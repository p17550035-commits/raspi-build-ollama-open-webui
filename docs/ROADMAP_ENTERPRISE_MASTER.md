---
layout: default
title: Master Enterprise Stack Diagram (ASCII)
---

# Master Enterprise Stack Diagram — Sovereign Dev Stack (ASCII)

This page contains the complete enterprise stack diagram for the Sovereign Dev Stack.  
It shows how all core backend services (Postgres, Redis, Qdrant, MinIO, Gitea, Ollama, VS Code Server, Open WebUI) interconnect to form the offline AI cloud.

All ASCII.  
GitHub‑safe.  
No rendering issues.

---

# 🏢 Sovereign Enterprise Stack — Master Diagram

```
                                      +---------------------------+
                                      |       Reverse Proxy       |
                                      |       Caddy / Nginx       |
                                      |        (80 / 443)         |
                                      +-------------+-------------+
                                                    |
                                                    v
                                      +---------------------------+
                                      |        Open WebUI         |
                                      |   (Venv / Docker Edition) |
                                      |     Ports: 8080 / 8000    |
                                      +------+------+-------------+
                                             |      |
                                             |      |
                                             v      v

        +---------------------------+                     +---------------------------+
        |         Ollama            |                     |       Gitea               |
        |   LLM Runtime (11434)     |                     |   Git Hosting (3000/222)  |
        +-------------+-------------+                     +-------------+-------------+
                      |                                                     |
                      v                                                     v

        +---------------------------+                     +---------------------------+
        |       Qdrant Vector DB    |                     |       VS Code Server      |
        |        Port: 6333         |                     |     code.domain           |
        +-------------+-------------+                     +-------------+-------------+
                      |                                                     |
                      v                                                     v

        +---------------------------+                     +---------------------------+
        |         Redis Cache       |                     |         MinIO             |
        |         Port: 6379        |                     |   S3 Storage (9000/9001) |
        +-------------+-------------+                     +-------------+-------------+
                      |                                                     |
                      v                                                     v

        +---------------------------+                     +---------------------------+
        |        PostgreSQL         |                     |   Enterprise File Store   |
        |        Port: 5432         |                     |   /mnt/pidrive/stack/     |
        +-------------+-------------+                     +-------------+-------------+
                      |                                                     |
                      v                                                     v

        +---------------------------+                     +---------------------------+
        |       Wizard Stack        |                     |     Automation Bots       |
        |  - Installers             |                     |  - CI/CD Pipelines        |
        |  - Tarball Builder        |                     |  - Tarball Publisher      |
        |  - DNS Generator          |                     |  - Workflow Engine        |
        |  - Runner Manager         |                     |  - Health Checks          |
        +-------------+-------------+                     +-------------+-------------+
                      |                                                     |
                      v                                                     v

        +---------------------------+                     +---------------------------+
        |     Multi‑OS Runners      |                     |        Safezone           |
        |  - Proot Ubuntu           |                     |  - Isolated Execution     |
        |  - Docker ARM64           |                     |  - Tool Permissions       |
        |  - Build/Test Pipelines   |                     |  - Resource Limits        |
        +-------------+-------------+                     +-------------+-------------+
                      |                                                     |
                      v                                                     v

        +---------------------------+                     +---------------------------+
        |       Tarball System      |                     |     Storage Architecture  |
        |  - Service Tarballs       |                     |  /mnt/pidrive/stack/      |
        |  - Model Tarballs         |                     |  - services/              |
        |  - Upgrade Tarballs       |                     |  - models/                |
        |  - Checksum Validation    |                     |  - upgrades/              |
        +---------------------------+                     +---------------------------+
```

---

# 🔁 Enterprise Stack Summary

```
Reverse Proxy → Open WebUI → Ollama → Qdrant → Redis → Postgres
Reverse Proxy → Gitea → MinIO → VS Code Server
Wizard Stack → Runners → Tarball System → Storage
Bots → Tarball System → Services → Reverse Proxy
Safezone → Tools / Agents → Wizard Stack → Services
```

This is the **canonical enterprise stack diagram** for your Sovereign Dev Stack.

---

{% include footer.html %}
