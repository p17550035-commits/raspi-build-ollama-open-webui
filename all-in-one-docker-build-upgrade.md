# FULL CORPORATE-GRADE PI AI CLOUD BLUEPRINT
# (All-in-One: Install Plan, Docker Compose, Architecture Diagram, Checklist, Backup Automation)

This file contains EVERYTHING needed to build a one-man enterprise AI cloud on a Raspberry Pi:
- Hard drive setup
- Docker + Docker Compose install
- PostgreSQL
- Redis
- Qdrant
- MinIO
- Gitea
- Open WebUI
- Ollama
- Full docker-compose.yml
- Architecture diagram (text-based)
- First-things-to-test checklist
- Backup automation script
- Final directory layout

All free. All offline. All self-hosted.

============================================================
# 0. HARD DRIVE SETUP
============================================================

1. Identify your drive:
   lsblk

2. Format (example /dev/sdX):
   sudo mkfs.ext4 /dev/sdX

3. Create mount point:
   sudo mkdir -p /mnt/pidrive

4. Add to fstab:
   echo "/dev/sdX /mnt/pidrive ext4 defaults 0 0" | sudo tee -a /etc/fstab

5. Mount:
   sudo mount -a

Your entire enterprise stack will live under:
/mnt/pidrive/stack/

============================================================
# 1. INSTALL DOCKER + DOCKER COMPOSE
============================================================

sudo apt update
sudo apt install docker.io docker-compose -y
sudo systemctl enable docker
sudo systemctl start docker

mkdir -p /mnt/pidrive/stack
cd /mnt/pidrive/stack

============================================================
# 2. DOCKER COMPOSE FILE (ALL SERVICES)
============================================================

Create:
nano /mnt/pidrive/stack/docker-compose.yml

Paste:

version: "3.8"

services:
  postgres:
    image: postgres:16
    container_name: postgres
    restart: unless-stopped
    environment:
      POSTGRES_PASSWORD: supersecure
    volumes:
      - ./postgres:/var/lib/postgresql/data
    ports:
      - "5432:5432"

  redis:
    image: redis:7
    container_name: redis
    restart: unless-stopped
    volumes:
      - ./redis:/data
    ports:
      - "6379:6379"

  qdrant:
    image: qdrant/qdrant
    container_name: qdrant
    restart: unless-stopped
    volumes:
      - ./qdrant:/qdrant/storage
    ports:
      - "6333:6333"

  minio:
    image: minio/minio
    container_name: minio
    restart: unless-stopped
    command: server /data --console-address ":9001"
    environment:
      MINIO_ROOT_USER: admin
      MINIO_ROOT_PASSWORD: supersecure
    volumes:
      - ./minio:/data
    ports:
      - "9000:9000"
      - "9001:9001"

  gitea:
    image: gitea/gitea:latest
    container_name: gitea
    restart: unless-stopped
    volumes:
      - ./gitea:/data
    ports:
      - "3000:3000"
      - "222:22"

  openwebui:
    image: ghcr.io/open-webui/open-webui:latest
    container_name: openwebui
    restart: unless-stopped
    environment:
      OLLAMA_BASE_URL: http://host.docker.internal:11434
      DATABASE_URL: postgresql://postgres:supersecure@postgres:5432/postgres
      REDIS_URL: redis://redis:6379
      QDRANT_URL: http://qdrant:6333
      MINIO_URL: http://minio:9000
      MINIO_ACCESS_KEY: admin
      MINIO_SECRET_KEY: supersecure
    volumes:
      - ./openwebui:/app/backend/data
    ports:
      - "8080:8080"
    depends_on:
      - postgres
      - redis
      - qdrant
      - minio

============================================================
# 3. START THE STACK
============================================================

cd /mnt/pidrive/stack
docker-compose up -d
docker ps

============================================================
# 4. INSTALL OLLAMA (HOST, NOT DOCKER)
============================================================

curl -fsSL https://ollama.com/install.sh | sh

Pull models:
ollama pull qwen2.5-coder:7b
ollama pull llama3.1:8b
ollama pull mistral:7b

============================================================
# 5. ACCESS POINTS
============================================================

Open WebUI: http://<pi-ip>:8080  
Gitea: http://<pi-ip>:3000  
MinIO console: http://<pi-ip>:9001  
Qdrant API: http://<pi-ip>:6333  
Redis: localhost:6379  
Postgres: localhost:5432  

============================================================
# 6. FINAL DIRECTORY STRUCTURE
============================================================

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

============================================================
# 7. ARCHITECTURE DIAGRAM (TEXT-BASED)
============================================================

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


============================================================
# 8. FIRST-THINGS-TO-TEST CHECKLIST
============================================================

1. Open WebUI loads at :8080
2. Gitea loads at :3000
3. MinIO console loads at :9001
4. Qdrant API responds at :6333
5. Redis responds: redis-cli ping → PONG
6. Postgres responds: psql -h localhost -U postgres
7. Open WebUI detects:
   - PostgreSQL
   - Redis
   - Qdrant
   - MinIO
   - Ollama
8. Upload a file → confirm MinIO stores it
9. Create an agent → confirm Redis queues tasks
10. Run a workflow → confirm Postgres logs it
11. Add a document → confirm Qdrant stores embeddings
12. Push a repo to Gitea → confirm SSH works

============================================================
# 9. BACKUP AUTOMATION SCRIPT
============================================================

Create:
nano /mnt/pidrive/stack/backup.sh

Paste:

#!/bin/bash
DATE=$(date +"%Y-%m-%d_%H-%M")

mkdir -p /mnt/pidrive/stack/backups/$DATE

# PostgreSQL
docker exec postgres pg_dumpall -U postgres > /mnt/pidrive/stack/backups/$DATE/postgres.sql

# Redis
docker exec redis redis-cli SAVE
cp /mnt/pidrive/stack/redis/dump.rdb /mnt/pidrive/stack/backups/$DATE/redis.rdb

# Qdrant
cp -r /mnt/pidrive/stack/qdrant /mnt/pidrive/stack/backups/$DATE/qdrant

# MinIO
cp -r /mnt/pidrive/stack/minio /mnt/pidrive/stack/backups/$DATE/minio

# Gitea
cp -r /mnt/pidrive/stack/gitea /mnt/pidrive/stack/backups/$DATE/gitea

# Open WebUI
cp -r /mnt/pidrive/stack/openwebui /mnt/pidrive/stack/backups/$DATE/openwebui

echo "Backup completed: $DATE"

Make executable:
chmod +x /mnt/pidrive/stack/backup.sh

Run:
./backup.sh

============================================================
# 10. FINAL RESULT
============================================================

You now have a full enterprise-grade AI cloud on a Raspberry Pi:
- Local GitHub (Gitea)
- Local S3 storage (MinIO)
- SQL database (Postgres)
- Vector memory (Qdrant)
- Cache/queue system (Redis)
- AI platform (Open WebUI)
- Model backend (Ollama)

All offline. All free. All yours.
