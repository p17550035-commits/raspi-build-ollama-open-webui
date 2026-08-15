---
layout: default
title: Roadmap
---



# Project Roadmap

This roadmap outlines the planned development phases for the Pi Edition. It covers upcoming tarballs, installers, enterprise services, and long-term expansion goals. All items listed here are supported by the existing documentation and will be activated once the required hardware and tarballs are available.

---

## Current Status

The following components are complete:

- Open WebUI tarball  
- Basic installer  
- External drive deployment  
- Folder structure  
- Documentation suite  
- Architecture design  
- Model compatibility framework  
- Tarball workflow  
- Manual update system  

The system is ready for expansion once additional hardware arrives.

---

## Planned Tarballs

These tarballs will be created and added to the release system:

1. Enterprise service tarball  
2. Model installer tarball set  
3. System service tarball  
4. Upgrade tarball for future versions  

Each tarball will follow the same structure as the existing Open WebUI tarball, including checksum verification and external-drive-safe extraction.

---

## Planned Installers

The installer system will expand to include:

1. Enterprise installer  
2. Model installer  
3. Update installer  

These installers will integrate with the existing folder structure and tarball workflow. They will be modular and follow the same safety rules as the basic installer.

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

Documentation for these services already exists in the architecture and systems pages. They will be activated once the enterprise tarball is created.

---

## Model System

The model system will include:

- Model tarballs  
- Model installer  
- Model folder structure  
- Compatibility tables  
- Runtime configuration  

The model compatibility page is already prepared. Only the tarball URLs and installer script need to be added.

---

## Update Workflow

The update workflow will remain manual. Users will download new tarballs and run the update installer. This prevents unexpected changes and keeps the system stable.

---

## Long-Term Goals

The long-term plan includes:

- Full enterprise deployment  
- Local Git hosting  
- Local S3 storage  
- Vector memory integration  
- Workflow automation  
- Offline AI cloud environment  
- Additional model support  
- Optional reverse proxy configuration  

These goals align with the architecture design and will be implemented as hardware and tarballs become available.

---

{% include footer.html %}
