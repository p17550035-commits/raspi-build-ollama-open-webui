---
layout: default
title: Master Service Dependency Graph (ASCII)
---

# Master Service Dependency Graph — Sovereign Dev Stack (ASCII)

This page contains the complete service dependency graph for the Sovereign Dev Stack.  
It shows how every major service depends on others, forming the backbone of your offline AI cloud.

All ASCII.  
GitHub‑safe.  
No rendering issues.

---

# 🏢 Sovereign Dev Stack — Service Dependency Graph

```
                           +---------------------------+
                           |       Reverse Proxy       |
                           |       Caddy / Nginx       |
                           +-------------+-------------+
                                         |
                                         v
                           +---------------------------+
                           |       Open WebUI          |
                           |   (Venv / Docker)         |
                           +------+------+-------------+
                                  |      |
                                  |      |
                                  v      v

        +---------------------------+     +---------------------------+
        |         Ollama            |     |       Enterprise Stack     |
        |   (LLM Runtime / 11434)   |     |  Postgres / Redis / MinIO |
        +-------------+-------------+     |  Qdrant / Gitea / VSCode  |
                      |                   +-------------+-------------+
                      |                                 |
                      v                                 v

        +---------------------------+     +---------------------------+
        |       Vector Memory       |     |       Git Hosting         |
        |         Qdrant            |     |          Gitea            |
        |         6333              |     |      3000 / 222           |
        +-------------+-------------+     +-------------+-------------+
                      |                                 |
                      |                                 |
                      v                                 v

        +---------------------------+     +---------------------------+
        |       Redis Cache         |     |       MinIO Storage       |
        |          6379             |     |       9000 / 9001         |
        +-------------+-------------+     +-------------+-------------+
                      |                                 |
                      |                                 |
                      v                                 v

        +---------------------------+     +---------------------------+
        |       PostgreSQL          |     |       File Storage        |
        |          5432             |     |   /mnt/pidrive/stack/     |
        +-------------+-------------+     +-------------+-------------+
                      |                                 |
                      |                                 |
                      v                                 v

        +---------------------------+     +---------------------------+
        |       Wizard Stack        |     |       Automation Bots     |
        |  - Installers             |     |  - CI/CD Pipelines        |
        |  - Tarball Builder        |     |  - Tarball Publisher      |
        |  - DNS Generator          |     |  - Workflow Engine        |
        |  - Runner Manager         |     |  - Health Checks          |
        +-------------+-------------+     +-------------+-------------+
                      |                                 |
                      |                                 |
                      v                                 v

        +---------------------------+     +---------------------------+
        |     Multi‑OS Runners      |     |        Safezone           |
        |  - Proot Ubuntu           |     |  - Isolated Execution     |
        |  - Docker ARM64           |     |  - Tool Permissions       |
        |  - Build/Test Pipelines   |     |  - Resource Limits        |
        +-------------+-------------+     +-------------+-------------+
                      |                                 |
                      |                                 |
                      v                                 v

        +---------------------------+     +---------------------------+
        |       Tarball System      |     |     Storage Architecture  |
        |  - Service Tarballs       |     |  /mnt/pidrive/stack/      |
        |  - Model Tarballs         |     |  - openwebui/             |
        |  - Upgrade Tarballs       |     |  - models/                |
        |  - Checksum Validation    |     |  - postgres/              |
        +---------------------------+     |  - redis/                 |
                                          |  - qdrant/                |
                                          |  - minio/                 |
                                          |  - gitea/                 |
                                          +---------------------------+
```

---

# 🔁 Dependency Summary

```
Reverse Proxy → Open WebUI → Ollama → Qdrant → Redis → Postgres
Reverse Proxy → Enterprise Stack → MinIO → Gitea → VS Code Server
Wizard Stack → Runners → Tarball System → Storage
Bots → Tarball System → Services → Reverse Proxy
Safezone → Tools / Agents → Wizard Stack → Services
```

Everything ties together cleanly, forming a **self‑contained offline AI cloud**.

---

# 🧭 Notes

- This is the **canonical service dependency graph** for the Sovereign Dev Stack.  
- ASCII format ensures GitHub Pages cannot distort or break it.  
- Store as:  
  ```
  docs/ROADMAP_SERVICE_DEPENDENCY_MASTER.md
  ```

---

{% include footer.html %}
