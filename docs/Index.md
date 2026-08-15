---
layout: default
title: Raspi Build — Home
---



# Raspi Build — Ollama + Open WebUI (Pi Edition)

This documentation site provides the complete reference for the Raspberry Pi AI stack known as the Pi Edition. It explains the installers, tarball system, architecture, services, models, update workflow, and long-term expansion plan.

The Pi Edition is designed to be stable, offline, modular, and fully driven by tarballs instead of package managers. Everything installs onto an external drive for reliability and performance.

---

## Project Overview

The Pi Edition provides a complete AI environment for Raspberry Pi. It includes:

- Open WebUI extracted from Docker and packaged as a tarball  
- Ollama for running GGUF models locally  
- A modular installer system  
- External-drive-safe deployment  
- Enterprise architecture support  
- A manual update system  
- A model installer framework  
- A future enterprise service stack  

This documentation explains how each part works and how the system expands over time.

---

## Where to Start

The following pages contain the full documentation:

- README.md — General overview  
- INSTALLERS.md — All installer scripts  
- ARCHITECTURE.md — Enterprise system design  
- TARBALLS.md — Tarball workflow and release structure  
- MODELS.md — Model installer documentation  
- MODEL-COMPATIBILITY.md — Supported GGUF models  
- SYSTEMS.md — Enterprise services  
- ROADMAP.md — Future additions  

---

## Deployment Method

The Pi Edition installs directly onto an external drive. The installers handle:

- Drive detection  
- Mounting  
- Folder creation  
- Tarball download  
- SHA256 verification  
- Extraction  
- Service setup (future)  

All components live under:

/mnt/pidrive/stack/

This structure keeps the system organized and easy to maintain.

---

## Folder Structure

The following folders exist now or will exist once enterprise mode is added:

openwebui/  
logs/  
backups/  
models/  
postgres/  
redis/  
qdrant/  
minio/  
gitea/  
docker-compose.yml  

This layout supports UI, models, databases, vector memory, storage, and local Git hosting.

---

## Tarball System

The Pi Edition uses tarballs instead of package managers to avoid dependency issues and ensure predictable installations. Tarballs contain prebuilt components that extract directly into the stack directory.

The current UI/backend tarball uses the following SHA256 checksum:

a5b0574c14bc6645c9a040fc955a1d27ab47181f6532cf802f1f880aa5fde197

Installers verify this automatically before extraction.

---

## Update Philosophy

Updates are manual and user-controlled. Nothing is forced or automatic. When new tarballs are released, users download them and run the appropriate installer. This prevents unexpected changes and keeps the system stable.

---

## Roadmap Summary

After hardware arrives, the following components will be added:

- Enterprise tarball  
- Model tarball suite  
- System service tarball  
- Upgrade tarballs  
- Enterprise installer  
- Model installer  
- Update installer  

Documentation for these components already exists. Only the tarball URLs will need to be added.

---

{% include footer.html %}
