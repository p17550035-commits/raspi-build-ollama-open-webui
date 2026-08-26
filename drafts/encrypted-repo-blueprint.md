---
layout: default
title: Encrypted Repo Blueprint (Draft)
---

# Encrypted Repo Blueprint (Draft)

This document outlines the conceptual design for encrypted repositories within the sovereign Raspberry Pi AI Stack.  
It is intentionally high‑level and non‑binding.  
No decisions in this draft are final.  
This blueprint exists to preserve intent and guide future implementation.

============================================================
1. PURPOSE OF ENCRYPTED REPOS
============================================================

Encrypted repos exist to store sensitive, private, or identity‑scoped data in a secure, versioned, and physically controlled manner.

They ensure that:
- all private data is encrypted before storage  
- no plaintext ever touches the Pi  
- no plaintext ever touches online services  
- repo contents are only accessible with physical presence  
- repo contents are grouped by identity  
- repo contents are removable by unplugging a drive  

Encrypted repos form the backbone of the sovereign privacy model.

============================================================
2. CORE PRINCIPLES
============================================================

- Repos store **only encrypted data**  
- Encryption happens **client‑side**  
- Decryption happens **in memory only**  
- No decrypted data is ever written to disk  
- Repos are **identity‑scoped**  
- Repos are **physically removable**  
- Repos are **never synced online in plaintext**  
- Repos are **versioned** but encrypted at rest  

============================================================
3. PHYSICAL STORAGE MODEL
============================================================

Encrypted repos live on a dedicated physical device:

1. **Encrypted Drive**
   - Contains all encrypted repos  
   - Must be physically plugged in to access  
   - Unplugging removes all sensitive data from the system  
   - Zero exposure when offline  

2. **Optional FIDO2 Key**
   - Used for repo unlock  
   - Used for repo signing  
   - Used for identity verification  

The Pi itself stores **no secrets** and **no decrypted data**.

============================================================
4. REPO STRUCTURE (CONCEPT)
============================================================

Each encrypted repo may contain:

- encrypted blobs  
- encrypted manifests  
- encrypted metadata  
- encrypted notes  
- encrypted configs  
- encrypted models  
- encrypted workflows  
- encrypted automation artifacts  

Repos are organized by identity:

identity-A/
  repo-1/
  repo-2/
  repo-3/

identity-B/
  repo-1/
  repo-2/

identity-C/
  repo-private/
  repo-secure/

Each repo is isolated from others.

============================================================
5. ENCRYPTION MODEL (CONCEPT)
============================================================

Encryption rules:

- All data encrypted **before** writing to repo  
- All data encrypted **before** syncing  
- All data encrypted **before** transfer  
- Keys never stored on Pi  
- Keys never stored online  
- Keys never stored in repo  
- Keys only exist on physical device or FIDO2 key  

Decryption rules:

- Decryption happens only in memory  
- Decrypted data is never written to disk  
- Decrypted data is never cached  
- Decrypted data is never logged  

============================================================
6. VERSIONING MODEL (CONCEPT)
============================================================

Encrypted repos support versioning:

- commits store encrypted blobs  
- diffs operate on encrypted chunks  
- metadata is encrypted  
- manifests are encrypted  
- rollback is possible but encrypted  

Versioning is identity‑scoped and physically controlled.

============================================================
7. SYNC MODEL (CONCEPT)
============================================================

Encrypted repos sync only when:

- the encrypted drive is plugged in  
- the identity is unlocked  
- the repo is mounted in memory  

Sync targets may include:

- local encrypted backups  
- offline encrypted mirrors  
- future sovereign cloud nodes (optional)  

No plaintext ever leaves the device.

============================================================
8. APPLICATION INTEGRATION (CONCEPT)
============================================================

Applications (Open WebUI, Gitea, MinIO, etc.) interact with encrypted repos through:

- encrypted manifests  
- encrypted metadata  
- encrypted blobs  

Applications never see plaintext.  
Decryption happens only in memory and only when required.

============================================================
9. FUTURE IMPLEMENTATION NOTES
============================================================

This subsystem will require:

- encryption libraries  
- repo schemas  
- manifest schemas  
- identity integration  
- vault integration  
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
