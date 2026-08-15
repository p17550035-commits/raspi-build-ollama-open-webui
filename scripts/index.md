# Installer Index 📜  
This page lists every installer script included in the Raspberry Pi AI stack.  
All installers are modular, Pi‑safe, and designed for both basic and enterprise deployments.

---

## 🧰 Core Installers

These scripts install the base system components needed for Open WebUI and Ollama.

```
scripts/core/
  install-basic.sh
  install-basic-no-ollama.sh
  install-basic-with-ollama.sh
  install-enterprise.sh
  install-enterprise-no-ollama.sh
  install-enterprise-with-ollama.sh
  install-upgrade-docker.sh
  install-upgrade-manual.sh
  uninstall-everything.sh
```

### What they do:

- Install Docker  
- Install Ollama (optional)  
- Install Open WebUI Pi Edition  
- Install enterprise stack (optional)  
- Handle upgrades  
- Provide full uninstall  

---

## 🏢 Component Installers (Enterprise Services)

These scripts install each enterprise service individually.

```
scripts/components/
  install-postgres.sh
  install-redis.sh
  install-qdrant.sh
  install-minio.sh
  install-gitea.sh
  install-openwebui-only.sh
  install-ollama-only.sh
  install-docker-only.sh
  install-drive-check.sh
```

### What they do:

- Create persistent directories  
- Launch Docker containers  
- Configure ports  
- Apply Pi‑safe settings  
- Auto‑restart services  

---

## 🧠 Model Installers

Model installers for both Ollama and Open WebUI backend (GGUF).

```
scripts/models/
  ollama/
    install-phi3-mini.sh
    install-phi3-small.sh
    install-qwen2.5-7b.sh
    install-llama3-8b.sh
    install-llama3.1-8b.sh
    install-mistral-7b.sh
    install-gemma2-2b.sh

  openwebui/
    install-phi3-mini-gguf.sh
    install-gemma2-2b-gguf.sh
    install-mistral-7b-gguf.sh
    install-llama3-8b-gguf.sh
```

### What they do:

- Download models  
- Verify integrity  
- Place models in correct directories  
- Ensure Open WebUI or Ollama detects them  

---

## 🔄 Upgrade Installers

Scripts for updating Docker, Open WebUI, or the enterprise stack.

```
scripts/upgrades/
  upgrade-openwebui.sh
  upgrade-enterprise.sh
  upgrade-docker.sh
  upgrade-ollama.sh
```

---

## 🧹 Maintenance & Utility Scripts

```
scripts/util/
  cleanup.sh
  verify-services.sh
  check-drive.sh
  rebuild-venv.sh
```

### What they do:

- Clean logs  
- Verify service health  
- Check external drive  
- Rebuild Python virtual environment  

---

## 🎉 Final Notes

This index gives you a complete overview of every installer available in the project.  
Use these scripts to deploy, upgrade, maintain, and customize your Raspberry Pi AI cloud.

For model‑specific installers, see:

👉 `scripts/models/index.md`
