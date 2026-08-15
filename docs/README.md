# raspi-build-ollama-open-webui
How to install clean raspi image with ollama+qwen coder and add open web ui 

# Open WebUI — Raspberry Pi Edition
A fully working, prebuilt, Pi‑optimized distribution of Open WebUI + Ollama + Qwen Coder.
No Node builds. No frontend compilation. No GPU dependencies. No cloud.
Just a clean, reproducible AI stack running entirely on a Raspberry Pi.

---

## 🚀 What This Is
This repository contains a complete, portable build of Open WebUI designed specifically for Raspberry Pi 4/5.

Included:
- Prebuilt production frontend (extracted from Docker)
- Python backend + virtual environment
- ARM‑compatible dependencies
- Ollama integration
- Qwen Coder model support
- Zero‑build setup — extract and run

This edition is meant for:
- Offline AI setups
- Local‑only privacy‑focused deployments
- Lightweight Pi‑based AI servers
- Anyone who wants Open WebUI without fighting npm, Node, or RAM limits

---

## 📦 Contents
Inside the tarball `openwebui-pi-edition.tar.gz`:

open-webui/
  backend/        (Python backend + venv)
  build/          (Prebuilt production frontend)
  patched deps    (ARM-safe environment)

---

## 🧰 Requirements
- Raspberry Pi 4 or 5
- Raspberry Pi OS (64-bit recommended)
- Docker installed
- Ollama installed
- At least 16GB storage

---

## 🔧 Installation
Follow the full setup guide in PI_SETUP.md.

Quick start:

tar -xzvf openwebui-pi-edition.tar.gz -C ~/
cd ~/open-webui/backend
source .venv/bin/activate
bash start.sh

Then open:

http://<your-pi-ip>:8080

---

## 🧠 Model Integration (Ollama)
Install Ollama:

curl -fsSL https://ollama.com/install.sh | sh

Pull a model:

ollama pull qwen2.5-coder:7b

Add endpoint inside Open WebUI:

http://localhost:11434

---

## 🔌 Optional Autostart
See PI_SETUP.md for systemd instructions.

---

## 🛠 Troubleshooting
- PyTorch not found → normal on Pi
- CORS warnings → safe for local use
- Frontend missing → ensure ~/open-webui/build exists
- Ollama not detected → confirm service is running

---

## 🎉 Credits
Open WebUI: https://github.com/open-webui/open-webui
Ollama: https://ollama.com

This Pi Edition was built to make running local AI simple, fast, and frustration-free.
