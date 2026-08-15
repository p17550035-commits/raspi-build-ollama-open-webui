---
layout: default
title: Architecture
---

# Enterprise Architecture 🏢  
This page explains the full Raspberry Pi AI cloud architecture, including drive layout, service structure, data flow, backup strategy, and the final enterprise result.

---

## 🧱 1. Hard Drive Setup

Format your external SSD/HDD:

```bash
sudo mkfs.ext4 /dev/sdX
```

Create mount point:

```bash
sudo mkdir -p /mnt/pidrive
```

Add to fstab:

```bash
echo "/dev/sdX /mnt/pidrive ext4 defaults 0 0" | sudo tee -a /etc/fstab
```

Mount:

```bash
sudo mount -a
```

Your entire enterprise stack lives under:

```
/mnt/pidrive/stack/
```

---

## 📁 2. Directory Layout (Enterprise)

```
/mnt/pidrive/stack/
  postgres/
  redis/
  qdrant/
  minio/
  gitea/
  openwebui/
  backups/
  logs/
  docker-compose.yml
```

Each folder is persistent storage for its respective service.

---

## 🧠 3. Service Overview

### PostgreSQL — Main Database  
Stores chat history, workflow logs, agent logs, settings, metadata.

### Redis — Cache + Queues  
Handles agent state, workflow state, tool queues, fast memory.

### Qdrant — Vector Memory  
Stores embeddings, semantic memory, document vectors, knowledge bases.

### MinIO — S3 Storage  
Stores documents, datasets, workflow outputs, agent artifacts, backups, logs.

### Gitea — Local GitHub  
Stores repos, tools, workflows, agents, and provides offline Git hosting.

### Open WebUI — AI Platform  
Provides UI, agents, tools, workflows, memory, API, authentication.

### Ollama — Model Backend  
Runs GGUF models directly on the Pi host for fast inference.

---

## 🛰️ 4. Architecture Diagram (Text‑Based)

```text
                         ┌───────────────────────────────┐
                         │         Raspberry Pi           │
                         │     (Enterprise AI Cloud)      │
                         └───────────────┬───────────────┘
                                         │
                                         │
             ┌───────────────────────────┴───────────────────────────┐
             │                                                       │
      ┌──────▼──────┐                                        ┌──────▼──────┐
      │  Postgres    │  ← Main DB (history, logs, metadata)   │    Redis     │  ← Cache, queues
      └──────▲──────┘                                        └──────▲──────┘
             │                                                       │
             │                                                       │
             └───────────────────────┬───────────────────────────────┘
                                     │
                          ┌──────────▼──────────┐
                          │     Open WebUI       │
                          │ Agents • Tools •     │
                          │ Workflows • Memory   │
                          │ UI • API • Auth      │
                          └──────────▲──────────┘
                                     │
                                     │
             ┌───────────────────────┴───────────────────────────────┐
             │                                                       │
      ┌──────▼──────┐                                        ┌──────▼──────┐
      │   Qdrant     │  ← Vector DB (embeddings, semantic     │    MinIO     │  ← File storage (S3)
      │              │     memory, document search)           │              │
      └──────▲──────┘                                        └──────▲──────┘
             │                                                       │
             └───────────────────────┬───────────────────────────────┘
                                     │
                          ┌──────────▼──────────┐
                          │        Gitea         │  ← Local GitHub (repos, tools, agents)
                          └──────────▲──────────┘
                                     │
                                     │
                          ┌──────────▼──────────┐
                          │       GitHub         │  ← Remote repo (optional)
                          └──────────────────────┘

Ollama runs on the host and connects directly to Open WebUI.
```

---

## 🔄 5. Backup Strategy

Create backup script:

```bash
nano /mnt/pidrive/stack/backup.sh
```

Paste:

```bash
#!/bin/bash
DATE=$(date +"%Y-%m-%d_%H-%M")

mkdir -p /mnt/pidrive/stack/backups/$DATE

docker exec postgres pg_dumpall -U postgres > /mnt/pidrive/stack/backups/$DATE/postgres.sql
docker exec redis redis-cli SAVE
cp /mnt/pidrive/stack/redis/dump.rdb /mnt/pidrive/stack/backups/$DATE/redis.rdb
cp -r /mnt/pidrive/stack/qdrant /mnt/pidrive/stack/backups/$DATE/qdrant
cp -r /mnt/pidrive/stack/minio /mnt/pidrive/stack/backups/$DATE/minio
cp -r /mnt/pidrive/stack/gitea /mnt/pidrive/stack/backups/$DATE/gitea
cp -r /mnt/pidrive/stack/openwebui /mnt/pidrive/stack/backups/$DATE/openwebui

echo "Backup completed: $DATE"
```

Make executable:

```bash
chmod +x /mnt/pidrive/stack/backup.sh
```

Run:

```bash
./backup.sh
```

---

## 🌐 6. Reverse Proxy (Optional)

Install NGINX:

```bash
sudo apt install nginx -y
```

Use it for:

- HTTPS  
- Domain names  
- Multi‑service routing  
- Public‑facing deployments  

---

## 🎉 Final Result

You now have a full enterprise‑grade AI cloud on a Raspberry Pi:

- Local GitHub (Gitea)  
- Local S3 storage (MinIO)  
- SQL database (Postgres)  
- Vector memory (Qdrant)  
- Cache/queue system (Redis)  
- AI platform (Open WebUI)  
- Model backend (Ollama)  

All offline. All free. All yours.
