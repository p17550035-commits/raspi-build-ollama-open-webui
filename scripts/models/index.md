# Model Installer Index 🧠  
This page lists every model installer script included in the Raspberry Pi AI stack.  
Installers are grouped by runtime: **Ollama** (host) and **Open WebUI backend** (GGUF).

---

## 🐮 Ollama Model Installers (Host Runtime)

These installers pull and configure Pi‑safe Ollama models.

```
scripts/models/ollama/
  install-phi3-mini.sh
  install-phi3-small.sh
  install-qwen2.5-7b.sh
  install-llama3-8b.sh
  install-llama3.1-8b.sh
  install-mistral-7b.sh
  install-gemma2-2b.sh
```

### What they do:

- Pull the model from Ollama  
- Verify Ollama installation  
- Log output  
- Ensure Pi‑safe configuration  
- Provide clean error handling  

### Supported Ollama Models:

- Phi‑3 Mini (3.8B)  
- Phi‑3 Small (7B)  
- Qwen 2.5 (7B)  
- LLaMA 3 (8B)  
- LLaMA 3.1 (8B)  
- Mistral (7B)  
- Gemma 2 (2B)  

---

## 🧩 Open WebUI Backend Model Installers (GGUF)

These installers download GGUF models and place them in the correct directory for Open WebUI’s Python backend.

```
scripts/models/openwebui/
  install-phi3-mini-gguf.sh
  install-gemma2-2b-gguf.sh
  install-mistral-7b-gguf.sh
  install-llama3-8b-gguf.sh
```

### What they do:

- Download GGUF model  
- Verify file integrity  
- Place model in the correct directory  
- Ensure Open WebUI detects it  
- Log installation steps  

### Supported GGUF Models:

- Phi‑3 Mini GGUF  
- Gemma 2 2B GGUF  
- Mistral 7B GGUF  
- LLaMA 3 8B GGUF  

---

## 📁 Model Storage Locations

### Ollama Models

Stored automatically under:

```
~/.ollama/models/
```

### GGUF Models (Open WebUI Backend)

External drive (recommended):

```
/mnt/pidrive/stack/openwebui/models/
```

Local fallback:

```
~/open-webui/models/
```

---

## 📚 Related Documentation

- `docs/MODELS.md`  
- `docs/MODEL-COMPATIBILITY.md`  
- `docs/TARBALLS.md`  

---

## 🎉 Final Notes

This index gives you a complete overview of every model installer available in the project.  
Use these scripts to install, manage, and customize your Raspberry Pi’s LLM capabilities — all offline, all free, all yours.
