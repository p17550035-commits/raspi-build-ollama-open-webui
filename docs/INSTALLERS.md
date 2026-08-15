---
layout: default
title: Installers
---

# Installer Suite 📦  
A complete, enterprise‑grade installation guide for the entire Raspberry Pi AI stack.  
This page merges everything from PI_SETUP.md + the Docker upgrade plan + the enterprise blueprint into one unified installer reference.

---

# 🧰 1. Raspberry Pi Setup

Update your Pi:

```bash
sudo apt update && sudo apt upgrade -y
```

Recommended:

- Raspberry Pi 4 or 5  
- Raspberry Pi OS 64‑bit  
- External SSD/HDD for models + enterprise stack  

---

# 🐳 2. Install Docker + Docker Compose

Install:

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
sudo reboot
```

After reboot:

```bash
docker --version
```

Create stack folder:

```bash
mkdir -p /mnt/pidrive/stack
```

---

# 🐮 3. Install Ollama (ARM Build)

```bash
curl -fsSL https://ollama.com/install.sh | sh
ollama --version
```

Pull Pi‑safe models:

```bash
ollama pull qwen2.5-coder:7b
ollama pull llama3.1:8b
ollama pull phi3:mini
ollama pull mistral:7b
```

---

# 📦 4. Extract Open WebUI Pi Edition

Place your tarball in your home directory:

```bash
tar -xzvf openwebui-pi-edition.tar.gz -C ~/
```

Creates:

```
~/open-webui/
  backend/      # Python backend + venv
  build/        # Prebuilt production frontend
  patched/      # ARM-safe dependency patches
```

Zero Node. Zero npm. Zero compilation.

---

# 🚀 5. Start Open WebUI Backend

```bash
cd ~/open-webui/backend
source .venv/bin/activate
bash start.sh
```

Expected logs:

- Started server process  
- Scheduler worker started  
- v0.11.x banner  

---

# 🌐 6. Access Open WebUI

Open in browser:

```
http://<pi-ip>:8080
```

---

# 🔌 7. Connect Ollama to Open WebUI

Inside Open WebUI:

1. Settings → Models  
2. Add endpoint:  
   `http://localhost:11434`  
3. Qwen / LLaMA / Phi models appear automatically.

---

# 🛠️ 8. Systemd Autostart (Optional)

Create:

```bash
sudo nano /etc/systemd/system/openwebui.service
```

Paste:

```ini
[Unit]
Description=Open WebUI Pi Edition
After=network.target

[Service]
Type=simple
User=pi
WorkingDirectory=/home/pi/open-webui/backend
ExecStart=/home/pi/open-webui/backend/.venv/bin/python -m open_webui
Restart=always

[Install]
WantedBy=multi-user.target
```

Enable:

```bash
sudo systemctl enable openwebui
sudo systemctl start openwebui
```

---

# 🏢 9. Enterprise Stack Installers (Docker Services)

These installers live in `/scripts/components/`:

- install-postgres.sh  
- install-redis.sh  
- install-qdrant.sh  
- install-minio.sh  
- install-gitea.sh  
- install-openwebui-only.sh  
- install-ollama-only.sh  
- install-docker-only.sh  
- install-drive-check.sh  

Each installer:

- Creates persistent directories under `/mnt/pidrive/stack/`  
- Launches the service via Docker  
- Ensures Pi‑safe configuration  
- Logs output  
- Auto‑restarts containers  

---

# 🧱 10. Docker Compose (Full Enterprise Stack)

Create:

```bash
nano /mnt/pidrive/stack/docker-compose.yml
```

Paste:

```yaml
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
```

Start everything:

```bash
cd /mnt/pidrive/stack
docker-compose up -d
docker ps
```

---

# 🔍 11. Access Points

- Open WebUI → `http://<pi-ip>:8080`  
- Gitea → `http://<pi-ip>:3000`  
- MinIO → `http://<pi-ip>:9001`  
- Qdrant → `http://<pi-ip>:6333`  
- Redis → `localhost:6379`  
- Postgres → `localhost:5432`  

---

# ✔️ 12. First‑Things‑To‑Test Checklist

1. Open WebUI loads  
2. Gitea loads  
3. MinIO console loads  
4. Qdrant API responds  
5. Redis responds (`redis-cli ping → PONG`)  
6. Postgres responds (`psql -h localhost -U postgres`)  
7. Open WebUI detects all services  
8. Upload file → MinIO stores it  
9. Create agent → Redis queues tasks  
10. Run workflow → Postgres logs it  
11. Add document → Qdrant stores embeddings  
12. Push repo → Gitea SSH works  

---

# 🔄 13. Upgrade Paths

Docker Compose upgrade:

```bash
cd /mnt/pidrive/stack
docker-compose pull
docker-compose up -d
```

Manual upgrade installers live in:

```
scripts/core/
scripts/components/
scripts/models/
```

---

# 🧩 14. Troubleshooting

- PyTorch not found → normal on Pi  
- CORS warnings → safe  
- USER_AGENT warnings → harmless  
- Missing frontend → ensure `~/open-webui/build` exists  
- Ollama not detected → check service  
- Models missing → check external drive mount  

---

# 🎉 15. Final Result

You now have:

- Open WebUI  
- Ollama  
- Qwen / LLaMA / Phi / Mistral  
- PostgreSQL  
- Redis  
- Qdrant  
- MinIO  
- Gitea  
- Docker Compose  
- Full enterprise AI cloud  

All offline. All free. All yours.  
Running on a Raspberry Pi.

Peter… bro…  
this installer page is **one solid block**, enterprise‑grade, and ready to paste directly into `/docs/INSTALLERS.md`.
