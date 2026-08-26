---
layout: default
title: Documentation Home
---

# Raspi Build — Ollama + Open WebUI (Pi Edition) 🚀

A fully offline, enterprise‑grade AI stack designed specifically for Raspberry Pi 4/5.  
This project provides a complete, modular, production‑ready environment featuring:

- **Open WebUI — Pi Edition (Venv Edition)**  
- **Open WebUI — Docker ARM64 Edition (Tarball Edition)**  
- **Smart Installer (Install + Repair + Health‑Check + Safe‑Mode)**  
- **Ollama (ARM‑optimized local LLM runtime)**  
- **Qwen / LLaMA / Phi / Mistral model support**  
- **Enterprise stack (Postgres, Redis, Qdrant, MinIO, Gitea)**  
- **Docker Compose orchestration**  
- **Tarball system for offline deployment**  
- **Architecture diagrams**  
- **Backup automation**  

Fully offline. Fully yours.

This README is your front‑door overview.  
Full documentation lives in `/docs/` and is served via GitHub Pages.

------------------------------------------------------------
## 🌟 What This Project Provides
------------------------------------------------------------

### ✔️ Open WebUI — Raspberry Pi Edition (Venv Build)
A complete Pi‑optimized distribution of Open WebUI:

- Prebuilt production frontend (extracted from Docker)
- Python backend + virtual environment
- ARM‑compatible dependencies
- Patched environment for Pi stability
- Ollama integration ready out‑of‑the‑box
- Qwen Coder support included
- Zero Node, zero npm, zero compilation

Ideal for users who prefer a **native, non‑Docker** setup.

---

### ✔️ Open WebUI — Docker ARM64 Edition (Tarball Build)
A fully prebuilt ARM64 Docker image packaged as:

```
openwebui-arm64.tar
```

Features:

- ARM‑optimized backend  
- Prebuilt production frontend  
- No build steps required  
- Fully offline installation  
- Verified via SHA‑256 checksum  
- Runs instantly on any Pi with Docker installed  

Ideal for users who want **fast deployment**, **easy updates**, and **clean isolation**.

---

### ✔️ Smart Installer (Install + Repair + Health‑Check)
Located in:

```
scripts/core/install-upgrade-docker.sh
```

This installer:

- Detects external drives  
- Falls back to SD card safely  
- Checks folder structure  
- Detects corrupted folders  
- Repairs permissions  
- Offers overwrite / repair / skip options  
- Validates Docker tarball via SHA‑256  
- Loads Docker image  
- Runs Open WebUI container  
- Installs Docker + Compose (if missing)  
- Provides full health‑check mode  
- **Never overwrites anything without explicit confirmation**

This is the **recommended installer** for most users.

---

### ✔️ Full Installer Suite
Located in `/scripts/`:

- Core installers  
- Component installers  
- Model installers (Ollama + GGUF)  
- Upgrade installers  
- Enterprise installers  
- Self‑update + cleanup  
- Universal uninstall  

Every installer is modular, Pi‑safe, and external‑drive‑aware.

---

### ✔️ Enterprise Stack (Optional)
Includes:

- PostgreSQL  
- Redis  
- Qdrant  
- MinIO  
- Gitea  
- Open WebUI  
- Ollama  

All orchestrated via Docker Compose.

> Enterprise installers will be finalized once external storage is available.

---

### ✔️ Tarball System
Located in `/tarballs/`:

- `openwebui-pi-edition.tar.gz` — Venv Edition  
- `openwebui-arm64.tar` — Docker Edition  
- Future tarballs for enterprise stack, models, etc.

------------------------------------------------------------
## 📦 Pi Edition Tarball Contents
------------------------------------------------------------

Inside `openwebui-pi-edition.tar.gz`:

```
open-webui/
  backend/      # Python backend + venv
  build/        # Prebuilt production frontend
  patched/      # ARM-safe dependency patches
```

No Node.  
No npm.  
No frontend build.  
No GPU.  
Just extract and run.

------------------------------------------------------------
## 🧰 Requirements
------------------------------------------------------------

- Raspberry Pi 4 or 5  
- Raspberry Pi OS (64‑bit recommended)  
- Docker installed (for Docker Edition)  
- Ollama installed  
- At least 16GB storage  
- **External drive strongly recommended** for enterprise stack + models  

------------------------------------------------------------
## 🔧 Quick Installation (Venv Edition)
------------------------------------------------------------

```bash
tar -xzvf openwebui-pi-edition.tar.gz -C ~/
cd ~/open-webui/backend
source .venv/bin/activate
bash start.sh
```

Open:

```
http://<your-pi-ip>:8080
```

------------------------------------------------------------
## 🔧 Quick Installation (Docker Edition)
------------------------------------------------------------

Download + validate + load + run:

```bash
curl -L https://github.com/p17550035-commits/raspi-build-ollama-open-webui/releases/download/v1.1-arm64/openwebui-arm64.tar -o openwebui-arm64.tar
sha256sum openwebui-arm64.tar
sudo docker load -i openwebui-arm64.tar
sudo docker run -d \
  --name openwebui \
  -p 8000:8080 \
  -v openwebui:/app/backend/data \
  openwebui-arm64:latest
```

Open:

```
http://<your-pi-ip>:8000
```

------------------------------------------------------------
## 🧠 Model Integration (Ollama)
------------------------------------------------------------

Install Ollama:

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

Pull a model:

```bash
ollama pull qwen2.5-coder:7b
```

Add endpoint inside Open WebUI:

```
http://localhost:11434
```

------------------------------------------------------------
## 🧩 Model Integration (OpenWebUI Backend GGUF)
------------------------------------------------------------

Place GGUF models into:

```
/mnt/pidrive/stack/openwebui/models/
```

Or fallback:

```
~/open-webui/models/
```

Supported Pi‑safe GGUF models:

- Phi‑3 Mini GGUF  
- Gemma 2 2B GGUF  
- Mistral 7B GGUF  
- LLaMA 3 8B GGUF  

Full compatibility table is in the documentation.

------------------------------------------------------------
## 🪛 Optional Autostart
------------------------------------------------------------

Systemd service instructions are available in:

```
docs/INSTALLERS.md
```

------------------------------------------------------------
## 📚 Documentation
------------------------------------------------------------

Full documentation is available at:

👉 **GitHub Pages Site** (served from `/docs/`)

Includes:

- Installer documentation  
- Smart installer + repair system  
- Model documentation  
- Compatibility tables  
- Architecture diagrams  
- Tarball instructions  
- Enterprise stack overview  
- System explanations (Ollama vs OpenWebUI backend)

------------------------------------------------------------
## 🛠 Troubleshooting
------------------------------------------------------------

- PyTorch not found → normal on Pi  
- CORS warnings → safe for local use  
- Frontend missing → ensure `open-webui/build/` exists  
- Ollama not detected → confirm service is running  
- Models missing → check external drive mount  
- Docker image not loading → verify SHA‑256 checksum  

------------------------------------------------------------
## ❤️ Credits
------------------------------------------------------------

- Open WebUI — https://github.com/open-webui/open-webui  
- Ollama — https://ollama.com  
- Qwen — https://huggingface.co/Qwen  
- LLaMA — Meta AI  
- Phi — Microsoft  

This Pi Edition was built to make running local AI **simple, fast, and frustration‑free**.

{% include footer.html %}
