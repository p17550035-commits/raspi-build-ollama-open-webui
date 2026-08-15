---
layout: default
title: Raspi Build — Home
---

{% toc %}

# Raspi Build — Ollama + Open WebUI (Pi Edition)

This site contains the complete documentation for the Raspberry Pi AI stack known as the Pi Edition. It explains the installers, tarball system, architecture, models, services, and update workflow.

## Purpose of the Project

The Pi Edition provides a stable, offline, modular AI environment for Raspberry Pi. It uses tarball-based deployment instead of package managers to avoid dependency issues and ensure predictable installations. Everything is designed to run from an external drive for performance and reliability.

## What the Pi Edition Includes

1. Open WebUI (UI and backend extracted from Docker)
2. Ollama (model runtime for GGUF models)
3. Tarball-based installers
4. External-drive-safe deployment
5. Enterprise architecture support
6. Manual update system
7. Model installer framework
8. Future enterprise service stack

## Recommended Starting Points

- README.md — Overview  
- INSTALLERS.md — Installer documentation  
- ARCHITECTURE.md — Enterprise system design  
- TARBALLS.md — Tarball workflow  
- MODELS.md — Model installer system  
- MODEL-COMPATIBILITY.md — Supported models  
- SYSTEMS.md — Enterprise services  
- ROADMAP.md — Future plans  

## Deployment Method

The system installs directly onto an external drive under:

/mnt/pidrive/stack/

This folder contains the UI, logs, backups, and future enterprise services. Tarballs are extracted directly into this structure. Installers handle drive detection, mounting, folder creation, checksum verification, and extraction.

## Folder Structure

openwebui/  
logs/  
backups/  
models/ (future)  
postgres/ (future)  
redis/ (future)  
qdrant/ (future)  
minio/ (future)  
gitea/ (future)  
docker-compose.yml (future)

## Tarball Integrity

All installers verify downloads using SHA256. The current UI/backend tarball uses:

a5b0574c14bc6645c9a040fc955a1d27ab47181f6532cf802f1f880aa5fde197

Checksum verification ensures the tarball is valid before extraction.

## Update Philosophy

Updates are manual. Nothing is forced or automatic. Users choose when to update by downloading new tarballs and running the appropriate installer. This prevents unexpected changes and keeps the system stable.

## Roadmap Summary

After hardware arrives, the following will be added:

- Enterprise tarball  
- Model tarball suite  
- System service tarball  
- Upgrade tarballs  
- Enterprise installer  
- Model installer  
- Update installer  

Documentation for these components already exists. Only the tarball URLs will need to be added.

{% include footer.html %}
