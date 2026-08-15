---
layout: default
title: Models
---

# Model Installers 🧠  
This page covers everything related to models on the Raspberry Pi AI stack, including Ollama models, Open WebUI backend GGUF models, Pi‑safe model recommendations, and installer scripts.

---

# 🐮 1. Ollama Models (CPU‑Optimized)

Ollama runs directly on the Pi host and provides fast, efficient inference for Pi‑safe models.

## ✔️ Recommended Pi‑Safe Ollama Models

- Phi‑3 Mini (3.8B) — fastest  
- Phi‑3 Small (7B) — excellent coder  
- Qwen 2.5 (7B) — top coding model  
- LLaMA 3 (8B) — best general model  
- LLaMA 3.1 (8B) — slightly heavier  
- Mistral (7B) — stable + reliable  
- Gemma 2 (2B) — tiny + fast

## 📥 Install Ollama Models

```bash
ollama pull phi3:mini
ollama pull phi3:small
ollama pull qwen2.5:7b
ollama pull llama3:8b
ollama pull llama3.1:8b
ollama pull mistral:7b
ollama pull gemma2:2b
```

## 📜 Ollama Model Installer Scripts

Located in:

```
scripts/models/ollama/
```

Includes installers for:

- Phi‑3 Mini  
- Phi‑3 Small  
- LLaMA 3 8B  
- Qwen 2.5 7B  
- Mistral 7B  

Each installer:

- Pulls the model  
- Verifies Ollama  
- Logs output  
- Ensures Pi‑safe configuration  

---

# 🧩 2. Open WebUI Backend Models (GGUF)

These models run inside the Open WebUI Python backend using GGUF format.

## ✔️ Recommended Pi‑Safe GGUF Models

- Phi‑3 Mini GGUF  
- Gemma 2 2B GGUF  
- Mistral 7B GGUF  
- LLaMA 3 8B GGUF  

## 📁 GGUF Model Locations

External drive (recommended):

```
/mnt/pidrive/stack/openwebui/models/
```

Local fallback:

```
~/open-webui/models/
```

## 📜 GGUF Model Installer Scripts

Located in:

```
scripts/models/openwebui/
```

Includes installers for:

- Phi‑3 Mini GGUF  
- Gemma 2 2B GGUF  
- Mistral 7B GGUF  

Each installer:

- Downloads GGUF  
- Places it in the correct directory  
- Ensures Open WebUI detects it  

---

# 🔌 3. Connecting Models to Open WebUI

## Ollama Endpoint

Inside Open WebUI:

```
http://localhost:11434
```

## GGUF Models

Open WebUI automatically detects GGUF models placed in:

```
openwebui/models/
```

---

# ❌ 4. Unsafe Models (Do Not Use on Pi)

These models are too heavy or require GPU acceleration:

| Category | Reason |
|----------|--------|
| > 8B models | Too slow / memory limits |
| Vision models | GPU required |
| Audio models | GPU required |
| Multimodal models | Too heavy |
| Large embedding models | RAM issues |

---

# 📊 5. Model Compatibility Table

See full compatibility table:

👉 `MODEL-COMPATIBILITY.md`

---

# 📜 6. Model Installer Index

All model installers are listed here:

👉 `scripts/models/index.md`

---

# 🎉 Final Notes

Your Raspberry Pi can run **real LLMs** locally — Phi‑3, Qwen, LLaMA, Mistral — all offline, all free, all yours.

This page gives you everything you need to install, manage, and understand model behavior on the Pi.
