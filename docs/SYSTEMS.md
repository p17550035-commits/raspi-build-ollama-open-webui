---
layout: default
title: Systems
---


# System Architecture 🏗️  
This page explains how every part of your Raspberry Pi AI stack works together — Ollama, Open WebUI, Docker services, databases, storage, and the full enterprise layout.

---

## 🧠 1. Ollama vs Open WebUI Backend

Ollama runs on the **host**, while Open WebUI’s GGUF backend runs **inside Python**.  
Both support GGUF models, but they behave differently.

### Runtime Comparison

| Feature | Ollama (Host) | Open WebUI Backend (GGUF) |
|--------|----------------|----------------------------|
| Speed | Faster | Slower |
| Memory | Lower | Higher |
| Format | GGUF | GGUF |
| Best For | Chat, coding, tools | Multi‑model UI |
| Runs As | System service | Python backend |
| Stability | Very high | Moderate |

**Summary:**

- Use **Ollama** for most LLM tasks.  
- Use **Open WebUI GGUF backend** only when you need multiple GGUF models inside the UI.

---

## 🐳 2. Host vs Docker Responsibilities

Your Pi uses a hybrid architecture:

### Host (Bare Metal)

- Ollama  
- External drive mount  
- Systemd services  
- Backup scripts  

### Docker (Containers)

- PostgreSQL  
- Redis  
- Qdrant  
- MinIO  
- Gitea  
- Open WebUI  
- Enterprise stack orchestration  

This separation keeps Ollama fast while isolating everything else for stability.

---

## 🧱 3. Service Roles (Enterprise Stack)

Each service has a specific job:

### PostgreSQL — Main Database

Stores:

- Chat history  
- Agent logs  
- Workflow logs  
- Settings  
- Metadata  
- Persistent memory  

### Redis — Cache + Queues

Handles:

- Agent state  
- Workflow state  
- Tool queues  
- Fast memory  
- Session caching  

### Qdrant — Vector Memory

Stores:

- Embeddings  
- Semantic memory  
- Document vectors  
- Knowledge bases  

This is your AI brain.

### MinIO — S3 File Storage

Stores:

- Documents  
- Datasets  
- Workflow outputs  
- Agent artifacts  
- Backups  
- Logs  

### Gitea — Local GitHub

Provides:

- Private repos  
- Version control  
- Tool/agent/workflow storage  
- Offline GitHub replacement  

### Open WebUI — AI Platform

Provides:

- UI  
- Agents  
- Tools  
- Workflows  
- Memory  
- API  
- Auth  

### Ollama — Model Backend

Provides:

- LLM inference  
- GGUF model runtime  
- Fast CPU‑optimized execution  

---

## 🔌 4. How Everything Connects

Open WebUI connects to:

- PostgreSQL → main DB  
- Redis → queues + cache  
- Qdrant → embeddings  
- MinIO → file storage  
- Ollama → model inference  

Ollama connects directly to Open WebUI via:

```bash
http://localhost:11434
```

---

## 🛰️ 5. Data Flow Diagram (Enterprise)

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

## 📁 7. Directory Layout (Enterprise)

```text
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

---

## 🔄 8. Docker Compose Lifecycle

Start:

```bash
docker-compose up -d
```

Stop:

```bash
docker-compose down
```

Update:

```bash
docker-compose pull
docker-compose up -d
```

---

## 🎉 Final Notes

Your Raspberry Pi is now a **full enterprise AI cloud**, running:

- Databases  
- Vector memory  
- File storage  
- Git hosting  
- AI platform  
- Model backend  

All offline. All free. All yours.

{% include footer.html %}
