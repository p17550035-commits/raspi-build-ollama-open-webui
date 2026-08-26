---
layout: default
title: Roadmap
---

# Project Roadmap

This roadmap outlines the planned development phases for the Pi Edition. It covers completed milestones, upcoming tarballs, installers, enterprise services, and long‑term expansion goals. All items listed here are supported by the existing documentation and will be activated once the required hardware and tarballs are available.

---

## Current Status

The following components are complete:

- Open WebUI Pi Edition tarball  
- Open WebUI Docker ARM64 tarball  
- Smart Installer (install + repair + health‑check)  
- External‑drive detection + SD fallback  
- Folder structure + storage architecture  
- Documentation suite  
- Architecture diagrams  
- Systems diagrams  
- Model compatibility framework  
- Tarball workflow  
- Manual update system  
- Installer Specification page  
- Updated README + Installers + Homepage  

The system is ready for expansion once additional hardware arrives.

---

## Planned Tarballs

These tarballs will be created and added to the release system:

1. Enterprise service tarball  
2. Model tarball suite (GGUF + Ollama)  
3. System service tarball  
4. Upgrade tarball for future versions  
5. Optional reverse‑proxy tarball (NGINX / Caddy)  

Each tarball will follow the same structure as the existing tarballs, including checksum verification and external‑drive‑safe extraction.

---

## Planned Installers

The installer system will expand to include:

1. Enterprise installer  
2. Model installer  
3. Update installer  
4. Service‑specific installers (Qdrant, MinIO, Gitea, etc.)  
5. Tarball‑based upgrade installer  

All installers will integrate with the Smart Installer’s safety rules:

- No silent overwrites  
- No silent destructive actions  
- Full folder health‑check  
- External‑drive awareness  
- Checksum validation  

---

## Enterprise Services

The enterprise stack will include:

- PostgreSQL  
- Redis  
- Qdrant  
- MinIO  
- Gitea  
- Docker Compose  
- Systemd service files  

Documentation for these services already exists in the architecture and systems pages.  
They will be activated once the enterprise tarball is created.

---

## Model System

The model system will include:

- Model tarballs  
- Model installer  
- Model folder structure  
- Compatibility tables  
- Runtime configuration  
- GGUF + Ollama integration  

The model compatibility page is already prepared.  
Only tarball URLs and installer scripts need to be added.

---

## Update Workflow

The update workflow will remain manual:

- Users download new tarballs  
- Run the update installer  
- Smart Installer validates checksums  
- Backend or Docker image is replaced safely  

This prevents unexpected changes and keeps the system stable.

---

## Long‑Term Goals

The long‑term plan includes:

- Full enterprise deployment  
- Local Git hosting (Gitea)  
- Local S3 storage (MinIO)  
- Vector memory integration (Qdrant)  
- Workflow automation  
- Offline AI cloud environment  
- Additional model support  
- Optional reverse proxy configuration  
- Automated backup + restore system  
- Tarball‑based versioning system  

These goals align with the architecture design and will be implemented as hardware and tarballs become available.

---

{% include footer.html %}
