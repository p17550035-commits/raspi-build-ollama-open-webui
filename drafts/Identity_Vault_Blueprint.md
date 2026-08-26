---
layout: default
title: Identity & Vault Blueprint (Draft)
---

# Identity & Vault Blueprint (Draft)

This document outlines the conceptual design for the sovereign identity and encrypted vault subsystem.  
It is intentionally high‑level and non‑binding.  
No decisions in this draft are final.  
This blueprint exists to preserve intent and guide future implementation.

============================================================
1. PURPOSE OF THIS SUBSYSTEM
============================================================

The Identity & Vault subsystem protects all non‑public, sensitive, personal, or private data associated with the Raspberry Pi AI Stack.  
It ensures that private information is:

- encrypted before storage  
- encrypted before upload  
- encrypted before syncing  
- never stored on the Pi  
- never stored online  
- never stored in plaintext  
- only accessible with physical presence  

This subsystem is designed to respect sovereignty, privacy, and physical control.

============================================================
2. CORE PRINCIPLES
============================================================

- No keys stored online  
- No passwords stored online  
- No secrets stored on the Pi  
- No decrypted data stored anywhere  
- Everything encrypted client‑side  
- Everything grouped by identity  
- Everything stored in encrypted repos  
- Everything requires physical presence  
- Everything removable by unplugging a drive  

============================================================
3. PHYSICAL SECURITY MODEL
============================================================

The subsystem relies on physical devices:

1. **Encrypted Drive**
   - Contains all vaults and identity data  
   - Must be physically plugged in to access  
   - Unplugging removes all sensitive data from the system  
   - Zero exposure when offline  

2. **Optional FIDO2 Key**
   - Hardware‑backed identity  
   - Hardware‑backed encryption  
   - Hardware‑backed signing  
   - Hardware‑backed repo access  

These devices form the root of trust.

============================================================
4. IDENTITY LAYER (CONCEPT)
============================================================

Each identity is represented by:

- identity.json  
- metadata  
- tags  
- permissions  
- vault links  
- repo links  
- encryption keys (never stored on Pi)

Identities may represent:

- personal profiles  
- project profiles  
- service profiles  
- automation profiles  

Identities are isolated from each other.

============================================================
5. VAULT LAYER (CONCEPT)
============================================================

Each vault contains encrypted data:

- encrypted blobs  
- encrypted configs  
- encrypted secrets  
- encrypted notes  
- encrypted models  
- encrypted workflows  

Vaults are:

- identity‑scoped  
- encrypted client‑side  
- stored only on the encrypted drive  
- never stored on the Pi  
- never stored online  

============================================================
6. REPO LAYER (CONCEPT)
============================================================

Encrypted repos store:

- versioned encrypted data  
- encrypted manifests  
- encrypted metadata  
- encrypted artifacts  

Repos are:

- identity‑scoped  
- grouped  
- synced only when the encrypted drive is plugged in  
- never exposed to public Git hosting  

============================================================
7. APPLICATION LAYER (CONCEPT)
============================================================

Applications (Open WebUI, Gitea, MinIO, etc.) never see plaintext.

They only interact with:

- encrypted blobs  
- encrypted metadata  
- encrypted manifests  

Decryption happens:

- only in memory  
- only when the encrypted drive is plugged in  
- only with the user’s key  
- never written to disk  

============================================================
8. WORKFLOW (CONCEPT)
============================================================

General workflow:

1. Plug in encrypted drive  
2. Authenticate with FIDO2 key (optional)  
3. Identity is loaded  
4. Vaults are mounted in memory  
5. Repos sync encrypted data  
6. Applications access encrypted blobs  
7. Unplug drive to remove all sensitive data  

============================================================
9. FUTURE IMPLEMENTATION NOTES
============================================================

This subsystem will require:

- encryption libraries  
- identity schemas  
- vault schemas  
- repo schemas  
- hardware integration  
- safezone integration  
- wizard stack integration  
- tarball integration  

These components will be designed later using:

- existing open‑source tools  
- stripped‑down components  
- custom sovereign implementations  

============================================================
10. STATUS
============================================================

This is a draft.  
Nothing in this document is final.  
This blueprint exists to preserve intent and guide future development.

{% include footer.html %}
