# Raspi Build — Ollama + Open WebUI (Pi Edition)

A complete, modular, Raspberry Pi–optimized AI stack featuring:

- **Ollama** (ARM‑compatible local LLM runtime)  
- **Open WebUI — Pi Edition** (prebuilt frontend + Python backend)  
- **Qwen Coder / LLaMA / Phi / Mistral models**  
- **Full installer suite** (core, components, models)  
- **Enterprise‑grade stack options**  
- **External‑drive‑aware deployments**  
- **Zero‑build setup** — extract and run  

This repository provides a **clean, reproducible, Pi‑safe AI environment** that avoids Node builds, frontend compilation, GPU dependencies, or cloud services.

Everything runs **locally** on a Raspberry Pi 4 or 5.

---

## 🚀 What This Project Provides

### ✔️ Prebuilt Open WebUI — Raspberry Pi Edition
A fully working, Pi‑optimized distribution of Open WebUI:

- Prebuilt production frontend (extracted from Docker)
- Python backend + virtual environment
- ARM‑compatible dependencies
- Patched environment for Pi stability
- Ollama integration ready out‑of‑the‑box
- Qwen Coder support included

### ✔️ Full Installer Suite
Located in `/scripts/`:

- Core installers  
- Component installers  
- Model installers (Ollama + OpenWebUI backend)  
- Upgrade installers  
- Enterprise installers  
- Self‑update + cleanup  
- Universal uninstall  

Every installer is modular, Pi‑safe, and external‑drive‑aware.

### ✔️ Tarball System
Located in `/tarballs/`:

- `openwebui-pi-edition.tar.gz`  
- Future tarballs for enterprise stack, models, etc.

---

## 📦 Contents of the Pi Edition Tarball

Inside `openwebui-pi-edition.tar.gz`:

```
open-webui/
│
├── backend/      # Python backend + virtual environment
├── build/        # Prebuilt production frontend
└── patched/      # ARM-safe dependency patches
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

## 🧠 Model Integration (OpenWebUI Backend)

Place GGUF models into:

```
/mnt/pidrive/stack/openwebui/models/
```

Or inside:

```
~/open-webui/models/
```

Supported Pi‑safe GGUF models include:

- Phi‑3 Mini  
- Gemma 2 2B  
- Mistral 7B (GGUF)  
- LLaMA 3 8B (GGUF)  

Full compatibility table is in the documentation.

---

## 🪛 Optional Autostart

Systemd service instructions are available in:

```
docs/INSTALLERS.md
```

---

## 🧩 Documentation

Full documentation is available at:

👉 **GitHub Pages Site**  
(Served from `/docs/`)

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
