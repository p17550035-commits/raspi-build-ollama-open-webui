---
layout: default
title: Architecture
---

# Raspi Build — Installer Specification (Pi Edition)

This document defines the complete behavior of the installer system used in the Raspi Build — Ollama + Open WebUI (Pi Edition) project.
It serves as the single source of truth for all installation logic, repair logic, health-checks, storage handling, and Docker image validation.

This specification applies to:
- Venv Edition
- Docker ARM64 Edition
- Smart Installer (Install + Repair + Health-Check)
- External-Drive + SD Fallback
- Tarball System
- Enterprise Stack (future)
- Component Installers (future)

------------------------------------------------------------
1. Installer Overview
------------------------------------------------------------

The installer system is designed to be:
- Pi-safe
- External-drive aware
- Fully offline
- Modular
- Repair-capable
- Checksum-validated
- Human-verified (no silent overwrites)

Primary installer:
# scripts/core/install-upgrade-docker.sh

This script acts as:
- Installer
- Repair tool
- Health-check tool
- Safe-mode storage manager
- Docker environment validator
- Tarball loader
- Container runner

------------------------------------------------------------
2. Storage Architecture
------------------------------------------------------------

2.1 External Drive (Preferred)
If an external drive is detected (sdX):

# /mnt/pidrive/stack/

Used for:
- postgres
- redis
- qdrant
- minio
- gitea
- openwebui models
- backups
- logs
- docker volumes
- enterprise stack
- component installers

2.2 Local Fallback (SD Card)
If no external drive is detected:

# ~/pistack/stack/

All installers must support both paths.

------------------------------------------------------------
3. Folder Structure
------------------------------------------------------------

Managed folders:

# stack/postgres
# stack/redis
# stack/qdrant
# stack/minio
# stack/gitea
# stack/openwebui
# stack/backups
# stack/logs

Each folder is classified as:
- EXISTS
- EMPTY
- CORRUPTED
- MISSING

------------------------------------------------------------
4. Folder Health-Check Logic
------------------------------------------------------------

Before creating ANY folder:
1. Scan all folders
2. Display full overview
3. Prompt user one folder at a time
4. Offer safe actions

For EXISTING folders:
- Keep
- Overwrite (DESTROYS ALL DATA)
- Repair (permissions + structure)
- Skip
- Abort

For EMPTY folders:
- Keep
- Recreate
- Skip
- Abort

For CORRUPTED folders:
- Repair (recommended)
- Overwrite
- Skip
- Abort

For MISSING folders:
- Create
- Skip
- Abort

No destructive action occurs without explicit confirmation.

------------------------------------------------------------
5. External Drive Handling
------------------------------------------------------------

Installer:
- Detects external drives (sdX)
- Detects filesystem type
- Warns if not ext4
- Offers:
  - Format (DESTROYS ALL DATA)
  - Skip formatting
  - Abort
- Mounts drive safely
- Adds persistent mount to /etc/fstab
- Falls back to SD card if no drive present

------------------------------------------------------------
6. Docker Environment Logic
------------------------------------------------------------

Installer checks:
- Docker installed or not
- Docker Compose plugin installed or not
- Existing OpenWebUI ARM64 images
- Image architecture
- Image tag
- Image name
- Image version

User chooses whether to install missing components.

------------------------------------------------------------
7. Tarball System
------------------------------------------------------------

Current tarballs:
# openwebui-pi-edition.tar.gz
# openwebui-arm64.tar

Future tarballs (enterprise stack, models, etc.) will be added once external storage is available.

------------------------------------------------------------
8. Docker ARM64 Image Validation
------------------------------------------------------------

SHA-256 checksum:

# 7f5666a0815ad1ce374ffa28d417538d2d484bb319c7767c7ea35913a5d3ae0e

If mismatch:
- Abort
- Redownload
- Continue anyway (NOT recommended)

Ensures:
- No corruption
- No partial downloads
- No tampering
- No wrong versions

------------------------------------------------------------
9. Docker Image Loading
------------------------------------------------------------

Load image:
# docker load -i openwebui-arm64.tar

If existing image present:
User chooses:
- Use existing
- Overwrite
- Skip

------------------------------------------------------------
10. Container Run Logic
------------------------------------------------------------

Run container:
# docker run -d \
#   --name openwebui \
#   -p 8000:8080 \
#   -v openwebui:/app/backend/data \
#   openwebui-arm64:latest

Ports:
- 8000 (Docker Edition)
- 8080 (Venv Edition)

------------------------------------------------------------
11. Venv Edition Specification
------------------------------------------------------------

Tarball contents:
# open-webui/
#   backend/
#   build/
#   patched/

Run:
# source .venv/bin/activate
# bash start.sh

------------------------------------------------------------
12. Model Integration
------------------------------------------------------------

12.1 Ollama Models
Install:
# ollama pull <model>

Endpoint:
# http://localhost:11434

12.2 GGUF Models
Store in:
# /mnt/pidrive/stack/openwebui/models/
or fallback:
# ~/open-webui/models/

Supported Pi-safe models:
- Phi-3 Mini
- Gemma 2 2B
- Mistral 7B
- LLaMA 3 8B

------------------------------------------------------------
13. Enterprise Stack (Future)
------------------------------------------------------------

Will be finalized once external storage is available.

Planned components:
- PostgreSQL
- Redis
- Qdrant
- MinIO
- Gitea
- Open WebUI
- Ollama
- Docker Compose orchestration
- Tarball system
- Backup automation

------------------------------------------------------------
14. Safety Guarantees
------------------------------------------------------------

Installer guarantees:
- No silent overwrites
- No silent formatting
- No silent folder creation
- No silent repairs
- No silent Docker installs
- No silent image loads
- No silent container runs

All actions are user-verified.

------------------------------------------------------------
15. Rerun Behavior
------------------------------------------------------------

Installer can be rerun to:
- Repair folders
- Recreate missing structure
- Validate Docker environment
- Validate tarball integrity
- Load updated images
- Run containers
- Prepare external drives
- Switch SD -> external drive
- Switch venv -> Docker

------------------------------------------------------------
16. Documentation Integration
------------------------------------------------------------

This file is automatically included in GitHub Pages via:

# /docs/INSTALLER-SPEC.md

Other docs (README, index.html, INSTALLERS.md) should link to this file.

------------------------------------------------------------
End of Specification
------------------------------------------------------------
{% include footer.html %}
