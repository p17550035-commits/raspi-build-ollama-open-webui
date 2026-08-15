---
layout: default
title: Documentation Home
---


# Raspi Build — Ollama + Open WebUI (Pi Edition) 🚀

A fully offline, enterprise‑grade AI stack designed specifically for Raspberry Pi 4/5. This project gives you a complete, modular, production‑ready environment featuring:

- **Open WebUI — Pi Edition** (prebuilt frontend + Python backend)
- **Ollama** (ARM‑optimized local LLM runtime)
- **Qwen / LLaMA / Phi / Mistral model support**
- **Full installer suite** (core, components, models, upgrades)
- **Enterprise stack** (Postgres, Redis, Qdrant, MinIO, Gitea)
- **Docker Compose orchestration**
- **Tarball system**
- **Architecture diagrams**
- **Backup automation**
- Fully offline, fully yours.

This README is your front‑door overview. Full documentation lives in `/docs/` and is served via GitHub Pages.

---

## 🌟 What This Project Provides

### ✔️ Prebuilt Open WebUI — Raspberry Pi Edition
A complete Pi‑optimized distribution of Open WebUI:

- Prebuilt production frontend (extracted from Docker)
- Python backend + virtual environment
- ARM‑compatible dependencies
- Patched environment for Pi stability
- Ollama integration ready out‑of‑the‑box
- Qwen Coder support included
- Zero Node, zero npm, zero compilation

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

### ✔️ Tarball System
Located in `/tarballs/`:

- `openwebui-pi-edition.tar.gz`  
- Future tarballs for enterprise stack, models, etc.

---

## 📦 Pi Edition Tarball Contents

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

---

## 🧰 Requirements

- Raspberry Pi 4 or 5  
- Raspberry Pi OS (64‑bit recommended)  
- Docker installed  
- Ollama installed  
- At least 16GB storage  
- External drive recommended for models

---

## 🔧 Quick Installation

Extract the Pi Edition tarball:

```bash
tar -xzvf openwebui-pi-edition.tar.gz -C ~/
cd ~/open-webui/backend
source .venv/bin/activate
bash start.sh
```

Then open:

```
http://<your-pi-ip>:8080
```

---

## 🧠 Model Integration (Ollama)

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

---

## 🧩 Model Integration (OpenWebUI Backend GGUF)

Place GGUF models into:

```
/mnt/pidrive/stack/openwebui/models/
```

Or:

```
~/open-webui/models/
```

Supported Pi‑safe GGUF models:

- Phi‑3 Mini GGUF  
- Gemma 2 2B GGUF  
- Mistral 7B GGUF  
- LLaMA 3 8B GGUF  

Full compatibility table is in the documentation.

---

## 🪛 Optional Autostart

Systemd service instructions are available in:

```
docs/INSTALLERS.md
```

---

## 📚 Documentation

Full documentation is available at:

👉 **GitHub Pages Site** (served from `/docs/`)

Includes:

- Installer documentation  
- Model documentation  
- Compatibility tables  
- Architecture diagrams  
- Tarball instructions  
- System explanations (Ollama vs OpenWebUI backend)

---

## 🛠 Troubleshooting

- **PyTorch not found** → normal on Pi  
- **CORS warnings** → safe for local use  
- **Frontend missing** → ensure `open-webui/build/` exists  
- **Ollama not detected** → confirm service is running  
- **Models missing** → check external drive mount  

---

## ❤️ Credits

- Open WebUI — https://github.com/open-webui/open-webui  
- Ollama — https://ollama.com  
- Qwen — https://huggingface.co/Qwen  
- LLaMA — Meta AI  
- Phi — Microsoft  

This Pi Edition was built to make running local AI **simple, fast, and frustration‑free**.

{% include footer.html %}
