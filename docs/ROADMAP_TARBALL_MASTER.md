---
layout: default
title: Master Tarball System Diagram (ASCII)
---

# Master Tarball System Diagram — Sovereign Dev Stack (ASCII)

This page contains the complete tarball system diagram for the Sovereign Dev Stack.  
It shows how service tarballs, model tarballs, upgrade tarballs, the Smart Installer, checksum validation, and the external‑drive architecture all connect.

All ASCII.  
GitHub‑safe.  
No rendering issues.

---

# 📦 Sovereign Tarball System — Master Diagram

```
                          +---------------------------+
                          |     Tarball Download      |
                          |  - Service tarballs       |
                          |  - Model tarballs         |
                          |  - Upgrade tarballs       |
                          +-------------+-------------+
                                        |
                                        v
                          +---------------------------+
                          |   SHA256 Verification     |
                          |  - Integrity check        |
                          |  - Corruption detection   |
                          +-------------+-------------+
                                        |
                                        v
                          +---------------------------+
                          |     Smart Installer       |
                          |  - Safe extraction        |
                          |  - Repair mode            |
                          |  - Health checks          |
                          |  - External-drive aware   |
                          +-------------+-------------+
                                        |
                                        v
        -------------------------------------------------------------------------
        |                                                                       |
        v                                                                       v

+---------------------------+                                   +---------------------------+
|   Service Tarball Stack   |                                   |   Model Tarball Stack     |
|  - postgres.tar.gz        |                                   |  - llama.tar.gz           |
|  - redis.tar.gz           |                                   |  - qwen.tar.gz            |
|  - qdrant.tar.gz          |                                   |  - phi.tar.gz             |
|  - minio.tar.gz           |                                   |  - mistral.tar.gz         |
|  - gitea.tar.gz           |                                   |  - embeddings.tar.gz      |
+-------------+-------------+                                   +-------------+-------------+
              |                                                               |
              v                                                               v

+---------------------------+                                   +---------------------------+
|   Upgrade Tarball Stack   |                                   |   Tarball Metadata        |
|  - openwebui-upgrade      |                                   |  - version.json           |
|  - enterprise-upgrade     |                                   |  - manifest.json          |
|  - models-upgrade         |                                   |  - checksums.txt          |
+-------------+-------------+                                   +-------------+-------------+
              |                                                               |
              v                                                               v

+---------------------------+                                   +---------------------------+
|   External Drive Layout   |                                   |   Wizard Stack Builder    |
|  /mnt/pidrive/stack/      |                                   |  - Tarball creation       |
|  - services/              |                                   |  - Tarball testing        |
|  - models/                |                                   |  - Tarball publishing     |
|  - upgrades/              |                                   |  - Metadata generation    |
+---------------------------+                                   +---------------------------+
```

---

# 🔁 Tarball System Summary

```
Download → Checksum → Smart Installer → Extract → Deploy → Store → Upgrade
```

### ✔ Service Tarballs  
Postgres, Redis, Qdrant, MinIO, Gitea, etc.

### ✔ Model Tarballs  
LLaMA, Qwen, Phi, Mistral, embeddings, etc.

### ✔ Upgrade Tarballs  
OpenWebUI, enterprise stack, models, system.

### ✔ Smart Installer  
Handles extraction, validation, repair, and external‑drive safety.

### ✔ Wizard Stack  
Builds, tests, and publishes tarballs.

---

{% include footer.html %}
