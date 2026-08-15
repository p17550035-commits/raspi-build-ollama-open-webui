# FULL CORPORATE-GRADE UPGRADE PLAN
# For Raspberry Pi + Open WebUI + Ollama + Gitea + Enterprise Databases

This guide upgrades your Pi into a full enterprise AI server with:
- PostgreSQL (main database)
- Redis (cache + queues)
- Qdrant (vector memory)
- MinIO (file storage)
- Gitea (local GitHub cloud)
- Docker Compose (orchestration)
- Open WebUI (AI platform)
- Ollama (model backend)

Everything is free, offline, and self-hosted.

============================================================
# 0. HARD DRIVE SETUP
============================================================

1. Plug in your external SSD/HDD.
2. Format it as ext4:
   sudo mkfs.ext4 /dev/sdX
3. Create mount point:
   sudo mkdir /mnt/pidrive
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

Create your stack folder:
mkdir -p /mnt/pidrive/stack

============================================================
# 2. POSTGRESQL (MAIN DATABASE)
============================================================

mkdir -p /mnt/pidrive/stack/postgres

docker run -d \
  --name postgres \
  -e POSTGRES_PASSWORD=supersecure \
  -v /mnt/pidrive/stack/postgres:/var/lib/postgresql/data \
  -p 5432:5432 \
  postgres:16

This becomes your main DB for:
- chat history
- agent logs
- workflow logs
- settings
- metadata
- persistent memory

============================================================
# 3. REDIS (CACHE + QUEUES)
============================================================

docker run -d \
  --name redis \
  -v /mnt/pidrive/stack/redis:/data \
  -p 6379:6379 \
  redis:7

Redis handles:
- agent state
- workflow state
- tool queues
- fast memory
- session caching

============================================================
# 4. QDRANT (VECTOR MEMORY)
============================================================

mkdir -p /mnt/pidrive/stack/qdrant

docker run -d \
  --name qdrant \
  -v /mnt/pidrive/stack/qdrant:/qdrant/storage \
  -p 6333:6333 \
  qdrant/qdrant

Qdrant stores:
- embeddings
- semantic memory
- document vectors
- knowledge bases

This is your AI brain.

============================================================
# 5. MINIO (FILE STORAGE)
============================================================

mkdir -p /mnt/pidrive/stack/minio

docker run -d \
  --name minio \
  -p 9000:9000 \
  -p 9001:9001 \
  -v /mnt/pidrive/stack/minio:/data \
  -e MINIO_ROOT_USER=admin \
  -e MINIO_ROOT_PASSWORD=supersecure \
  minio/minio server /data --console-address ":9001"

MinIO stores:
- documents
- datasets
- workflow outputs
- agent artifacts
- backups
- logs

This is your S3-compatible file server.

============================================================
# 6. GITEA (LOCAL GITHUB CLOUD)
============================================================

mkdir -p /mnt/pidrive/stack/gitea

docker run -d \
  --name gitea \
  -p 3000:3000 \
  -p 222:22 \
  -v /mnt/pidrive/stack/gitea:/data \
  gitea/gitea:latest

Gitea gives you:
- private repos
- version control
- tool/agent/workflow storage
- offline GitHub replacement

============================================================
# 7. OPEN WEBUI (AI PLATFORM)
============================================================

mkdir -p /mnt/pidrive/stack/openwebui

docker run -d \
  --name openwebui \
  -p 8080:8080 \
  -v /mnt/pidrive/stack/openwebui:/app/backend/data \
  -e OLLAMA_BASE_URL=http://localhost:11434 \
  -e DATABASE_URL=postgresql://postgres:supersecure@localhost:5432/postgres \
  -e REDIS_URL=redis://localhost:6379 \
  -e QDRANT_URL=http://localhost:6333 \
  -e MINIO_URL=http://localhost:9000 \
  -e MINIO_ACCESS_KEY=admin \
  -e MINIO_SECRET_KEY=supersecure \
  ghcr.io/open-webui/open-webui:latest

This connects Open WebUI to:
- PostgreSQL
- Redis
- Qdrant
- MinIO
- Ollama

============================================================
# 8. OLLAMA (MODEL BACKEND)
============================================================

curl -fsSL https://ollama.com/install.sh | sh

Pull your models:
ollama pull qwen2.5-coder:7b
ollama pull llama3.1:8b
ollama pull mistral:7b

============================================================
# 9. DIRECTORY STRUCTURE (FINAL)
============================================================

/mnt/pidrive/stack/
  postgres/
  redis/
  qdrant/
  minio/
  gitea/
  openwebui/
  logs/
  backups/

============================================================
# 10. BACKUP PLAN
============================================================

PostgreSQL:
  pg_dumpall > /mnt/pidrive/stack/backups/postgres.sql

Redis:
  redis-cli SAVE

Qdrant:
  copy /mnt/pidrive/stack/qdrant

MinIO:
  mc cp -r minio/data /mnt/pidrive/stack/backups/minio

Gitea:
  copy /mnt/pidrive/stack/gitea

============================================================
# 11. OPTIONAL: NGINX REVERSE PROXY
============================================================

Install:
sudo apt install nginx -y

Use it if you want:
- HTTPS
- domain names
- multi-service routing

============================================================
# 12. OPTIONAL: DOCKER COMPOSE VERSION
============================================================

Create:
nano /mnt/pidrive/stack/docker-compose.yml

Add all services in one file (Postgres, Redis, Qdrant, MinIO, Gitea, Open WebUI).

Start everything:
docker-compose up -d

============================================================
# 13. FINAL RESULT
============================================================

You now have:
- your own GitHub (Gitea)
- your own S3 cloud (MinIO)
- your own SQL database (Postgres)
- your own vector memory (Qdrant)
- your own cache/queue system (Redis)
- your own AI platform (Open WebUI)
- your own model backend (Ollama)

A full corporate-grade AI cloud.
Offline.
Free.
Self-hosted.
Just for you.
