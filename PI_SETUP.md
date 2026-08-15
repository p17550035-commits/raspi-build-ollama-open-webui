# PI_SETUP.md — Open WebUI Pi Edition
A complete, reproducible setup for running Open WebUI + Ollama + Qwen Coder locally on a Raspberry Pi.

## 📌 Overview
This guide installs:
- Open WebUI (Pi Edition)
- Prebuilt production frontend (extracted from Docker)
- Python backend + venv
- Ollama (ARM build)
- Qwen Coder model
- System dependencies
- Your Pi Edition tarball

Everything runs locally, offline, and fast on a Raspberry Pi.

## 🧰 Requirements
- Raspberry Pi 4 or 5
- Raspberry Pi OS (64‑bit recommended)
- At least 16GB storage
- Internet connection
- Your Pi Edition tarball: `openwebui-pi-edition.tar.gz`

## 🔧 Step 1 — Update the Pi
sudo apt update && sudo apt upgrade -y

## 🐋 Step 2 — Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
sudo reboot

After reboot:
docker --version

## 🦙 Step 3 — Install Ollama (ARM build)
curl -fsSL https://ollama.com/install.sh | sh

Verify:
ollama --version

## 🤖 Step 4 — Pull Qwen Coder
ollama pull qwen2.5-coder:7b

## 📦 Step 5 — Extract the Pi Edition
Place your tarball in your home directory, then run:
tar -xzvf openwebui-pi-edition.tar.gz -C ~/

This creates:
~/open-webui/

Containing:
- backend/ (Python backend + venv)
- build/ (prebuilt frontend)
- patched dependencies

## 🚀 Step 6 — Start Open WebUI Backend
cd ~/open-webui/backend
source .venv/bin/activate
bash start.sh

You should see logs like:
- Started server process
- Scheduler worker started
- v0.11.0 banner

## 🌐 Step 7 — Access Open WebUI
On any device on your network:
http://<your-pi-ip>:8080

You’ll see:
OPEN·WEBUI — Welcome to your AI home.

## 🧠 Step 8 — Connect Ollama
Inside Open WebUI:
1. Settings → Models
2. Add endpoint:
   http://localhost:11434
3. Qwen coder will appear automatically.

## 🔌 Optional: Autostart on Boot
sudo nano /etc/systemd/system/openwebui.service

Paste:
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

Enable:
sudo systemctl enable openwebui
sudo systemctl start openwebui

## 📚 Troubleshooting
- PyTorch not found → normal on Pi (you use Ollama)
- CORS warning → safe for local use
- USER_AGENT warning → harmless
- Missing frontend → ensure ~/open-webui/build exists

## 🎉 You’re done
Your Raspberry Pi now runs:
- Open WebUI
- Ollama
- Qwen Coder
- Fully local AI stack
- No cloud
- No external dependencies
- No compilation required
