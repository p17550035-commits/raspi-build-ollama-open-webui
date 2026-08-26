---
layout: default
title: Tarballs
---

# Tarball System 📦  
This page explains how the Pi Edition tarball system works, how to extract each tarball, where everything goes, and how the patched environments enable Open WebUI to run on Raspberry Pi without Node, npm, or frontend builds.  
It also covers the Docker ARM64 tarball, Smart Installer integration, and future enterprise tarballs.

---

# 📁 1. Tarball Types

The Pi Edition currently provides **two official tarballs**:

### ✔️ Venv Edition (Pi Edition)
```
openwebui-pi-edition.tar.gz
```

### ✔️ Docker ARM64 Edition
```
openwebui-arm64.tar
```

Both are fully offline, prebuilt, and optimized for Raspberry Pi 4/5.

Future tarballs will include:

- Enterprise stack tarball  
- Model tarball suite  
- System service tarball  
- Upgrade tarballs  

---

# 🧩 2. Venv Edition Tarball Contents

```
open-webui/
  backend/      # Python backend + virtual environment
  build/        # Prebuilt production frontend (no Node required)
  patched/      # ARM-safe dependency patches
```

### What this means:

- **No Node.js**  
- **No npm**  
- **No frontend compilation**  
- **No GPU dependencies**  
- **No cloud services**  
- Fully prebuilt, fully offline.

This tarball is designed for **speed**, **stability**, and **zero frustration**.

---

# 📦 3. Extracting the Venv Tarball

Place the tarball in your home directory, then extract:

```bash
tar -xzvf openwebui-pi-edition.tar.gz -C ~/
```

This creates:

```
~/open-webui/
```

Inside you will find:

- `backend/` → Python backend + venv  
- `build/` → Prebuilt production frontend  
- `patched/` → ARM‑safe wheels + fixes  

---

# 🚀 4. Starting the Venv Backend

```bash
cd ~/open-webui/backend
source .venv/bin/activate
bash start.sh
```

Expected logs:

- Server started  
- Scheduler worker started  
- Open WebUI version banner  

Open the UI:

```
http://<pi-ip>:8080
```

---

# 🐳 5. Docker ARM64 Tarball

The Docker Edition tarball contains a **prebuilt ARM64 Docker image**:

```
openwebui-arm64.tar
```

This tarball is used by:

- The Smart Installer  
- Manual Docker deployments  
- Offline installations  
- Enterprise stack setups  

### Load the image:

```bash
sudo docker load -i openwebui-arm64.tar
```

### Run the container:

```bash
sudo docker run -d \
  --name openwebui \
  -p 8000:8080 \
  -v openwebui:/app/backend/data \
  openwebui-arm64:latest
```

Open:

```
http://<pi-ip>:8000
```

---

# 🔐 6. Tarball Verification (Smart Installer)

The Smart Installer automatically:

- Validates tarball integrity  
- Checks SHA‑256 checksum  
- Detects corruption  
- Prompts before overwriting  
- Loads Docker images safely  
- Repairs missing/corrupted folders  
- Handles external‑drive detection  

Current Docker tarball checksum:

```
7f5666a0815ad1ce374ffa28d417538d2d484bb319c7767c7ea35913a5d3ae0e
```

Current Venv tarball checksum:

```
a5b0574c14bc6645c9a040fc955a1d27ab47181f6532cf802f1f880aa5fde197
```

---

# 📁 7. GGUF Model Storage (Backend Models)

If you use Open WebUI’s GGUF backend, place models here:

External drive (recommended):

```
/mnt/pidrive/stack/openwebui/models/
```

Local fallback:

```
~/open-webui/models/
```

Open WebUI automatically detects GGUF models placed in these directories.

---

# 🔄 8. Updating Tarballs (Future Versions)

When a new tarball is released:

### Venv Edition:
1. Stop Open WebUI  
2. Replace the tarball  
3. Extract again  
4. Restart backend  

### Docker Edition:
1. Stop container  
2. Load new tarball  
3. Restart container  

Your data (agents, workflows, settings) lives in:

```
/mnt/pidrive/stack/openwebui/
```

So updates do **not** erase your content.

---

# 🛠️ 9. Troubleshooting Tarball Issues

### ❗ Missing frontend  
Ensure:

```
~/open-webui/build/
```

exists.

### ❗ Backend fails to start  
Try:

```bash
source .venv/bin/activate
pip install --upgrade pip
```

### ❗ Docker image not loading  
Verify checksum:

```bash
sha256sum openwebui-arm64.tar
```

### ❗ Ollama not detected  
Confirm service is running:

```bash
systemctl status ollama
```

### ❗ GGUF models not showing  
Check model directory path.

---

# 🎉 Final Notes

The Pi Edition tarball system is the **heart** of the Raspberry Pi AI stack:

- Fully prebuilt  
- ARM‑optimized  
- Zero compilation  
- Zero cloud  
- Zero headaches  

Just extract → validate → run.

Your Raspberry Pi becomes a **real AI workstation**, offline and fully yours.

{% include footer.html %}
