---
layout: default
title: Model Compatibility
---

# Model Compatibility 📊  
A complete reference for all Pi‑safe models across Ollama and Open WebUI backend (GGUF).  
This page helps you choose the right model for speed, memory usage, and stability on Raspberry Pi 4/5.

---

# 🐮 1. Ollama Models (Host Runtime)

Ollama runs directly on the Pi host and is the fastest way to run LLMs on Raspberry Pi.

## ✔️ Pi‑Safe Ollama Models

| Model | Size | Pi‑Safe | Notes |
|-------|------|---------|-------|
| Phi‑3 Mini | 3.8B | ✔️ | Fastest + low RAM |
| Phi‑3 Small | 7B | ✔️ | Excellent coder |
| Qwen 2.5 7B | 7B | ✔️ | Best coding model |
| LLaMA 3 8B | 8B | ✔️ | Best general model |
| LLaMA 3.1 8B | 8B | ✔️ | Slightly heavier |
| Mistral 7B | 7B | ✔️ | Stable + reliable |
| Gemma 2 2B | 2B | ✔️ | Tiny + extremely fast |

## ⚙️ Performance Notes

- 3B–4B models → **fastest**, ideal for chat + tools  
- 7B models → **balanced**, ideal for coding + reasoning  
- 8B models → **heaviest**, still Pi‑safe but slower  

---

# 🧩 2. Open WebUI Backend Models (GGUF)

These models run inside the Python backend using GGUF format.

## ✔️ Pi‑Safe GGUF Models

| Model | Size | Pi‑Safe | Notes |
|-------|------|---------|-------|
| Phi‑3 Mini GGUF | 3.8B | ✔️ | Very fast |
| Gemma 2 2B GGUF | 2B | ✔️ | Tiny + efficient |
| Mistral 7B GGUF | 7B | ✔️ | Slower but stable |
| LLaMA 3 8B GGUF | 8B | ✔️ | Heavy but works |

## ⚙️ GGUF Performance Notes

- GGUF backend is **slower** than Ollama  
- GGUF backend uses **more RAM**  
- GGUF backend is ideal for **multi‑model UI workflows**  

---

# ❌ 3. Unsafe Models (Do Not Use on Pi)

These models are too heavy or require GPU acceleration:

| Category | Reason |
|----------|--------|
| > 8B models | Too slow / memory limits |
| Vision models | GPU required |
| Audio models | GPU required |
| Multimodal models | Too heavy |
| Large embedding models | RAM issues |
| Anything with “vision”, “audio”, “multimodal” | Unsupported on Pi |

---

# 🔌 4. Runtime Differences (Ollama vs GGUF)

| Feature | Ollama | OpenWebUI Backend (GGUF) |
|---------|--------|---------------------------|
| Speed | Faster | Slower |
| Memory | Lower | Higher |
| Format | GGUF | GGUF |
| Best For | Chat, coding, tools | Multi‑model UI |
| Runs As | Host service | Python backend |

---

# 📁 5. Model Storage Locations

## Ollama Models

Stored automatically under:

```
~/.ollama/models/
```

## GGUF Models

External drive (recommended):

```
/mnt/pidrive/stack/openwebui/models/
```

Local fallback:

```
~/open-webui/models/
```

---

# 📜 6. Installer Scripts

All model installers live under:

```
scripts/models/
```

Ollama installers:

```
scripts/models/ollama/
```

GGUF installers:

```
scripts/models/openwebui/
```

See full index:

👉 `scripts/models/index.md`

---

# 🎉 Final Notes

Your Raspberry Pi can run **real LLMs** locally — Phi‑3, Qwen, LLaMA, Mistral — all offline, all free, all yours.  
This compatibility page ensures you always pick the right model for speed, stability, and memory usage.
