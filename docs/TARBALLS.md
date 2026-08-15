---
layout: default
title: Tarballs
---
{% toc %}

# Tarball System 📦  
This page explains how the Pi Edition tarball works, how to extract it, where everything goes, and how the patched environment enables Open WebUI to run on Raspberry Pi without Node, npm, or frontend builds.

---

## 📁 1. Tarball Contents

The Pi Edition tarball contains a fully prebuilt, Pi‑optimized Open WebUI distribution:

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
- **Everything runs locally on the Pi**  

This tarball is designed for **speed**, **stability**, and **zero frustration**.

---

## 📦 2. Extracting the Tarball

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

## 🚀 3. Starting the Backend

Activate the virtual environment and start Open WebUI:

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

## 🧩 4. Patched Dependencies (ARM‑Safe)

The Pi Edition includes:

### ✔️ Prebuilt Python wheels  
No compiling heavy packages on the Pi.

### ✔️ ARM‑safe replacements  
Packages that normally fail on ARM are patched or swapped.

### ✔️ Prebuilt frontend  
The entire UI is already compiled — no Node, no npm, no RAM explosions.

### ✔️ Stable environment  
Everything is tested on Raspberry Pi 4/5.

This is why the Pi Edition works even when the official Open WebUI build fails on ARM.

---

## 📁 5. GGUF Model Storage (Backend Models)

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

## 🔄 6. Updating the Tarball (Future Versions)

When a new Pi Edition tarball is released:

1. Stop Open WebUI  
2. Replace the tarball  
3. Extract again  
4. Restart backend  

Your data (agents, workflows, settings) lives in:

```
/mnt/pidrive/stack/openwebui/
```

So updates do **not** erase your content.

---

## 🛠️ 7. Troubleshooting Tarball Issues

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

### ❗ Ollama not detected  
Confirm service is running:

```bash
systemctl status ollama
```

### ❗ GGUF models not showing  
Check model directory path.

---

## 🎉 Final Notes

The Pi Edition tarball is the **heart** of the Raspberry Pi AI stack:

- Fully prebuilt  
- ARM‑optimized  
- Zero compilation  
- Zero cloud  
- Zero headaches  

Just extract → activate → run.

Your Raspberry Pi becomes a **real AI workstation**, offline and fully yours.

{% include footer.html %}
