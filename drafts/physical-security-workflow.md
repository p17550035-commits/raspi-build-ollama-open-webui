---
layout: default
title: Physical Security Workflow (Draft)
---

# Physical Security Workflow (Draft)

This document outlines the conceptual physical‑security workflow for the sovereign Raspberry Pi AI Stack.  
It is intentionally high‑level and non‑binding.  
No decisions in this draft are final.  
This workflow exists to preserve intent and guide future implementation.

============================================================
1. PURPOSE OF THIS WORKFLOW
============================================================

The physical‑security workflow ensures that sensitive, private, or identity‑scoped data is only accessible when the user is physically present and has intentionally enabled access.

This workflow protects against:
- remote compromise  
- accidental exposure  
- unauthorized scraping  
- unintended uploads  
- catastrophic data loss  

It enforces sovereignty through physical control.

============================================================
2. CORE PRINCIPLES
============================================================

- Sensitive data is never stored on the Pi  
- Sensitive data is never stored online  
- Sensitive data is never stored in plaintext  
- Sensitive data is only accessible when physically unlocked  
- Sensitive data is removed by unplugging a device  
- Sensitive data is encrypted at rest and in transit  
- Sensitive data is decrypted only in memory  

============================================================
3. PHYSICAL COMPONENTS
============================================================

1. **Encrypted Drive**
   - Stores all vaults  
   - Stores all encrypted repos  
   - Stores all identity metadata  
   - Must be physically plugged in to access  
   - Unplugging removes all sensitive data from the system  

2. **Optional FIDO2 Key**
   - Provides hardware‑backed identity  
   - Provides hardware‑backed encryption  
   - Provides hardware‑backed signing  
   - Required for unlocking identities or repos  

3. **Raspberry Pi**
   - Hosts the sovereign stack  
   - Never stores secrets  
   - Never stores decrypted data  
   - Never stores identity keys  

============================================================
4. WORKFLOW OVERVIEW
============================================================

General workflow:

1. **Start (Pi Offline or Idle)**
   - Pi contains no sensitive data  
   - No vaults mounted  
   - No identities loaded  
   - No encrypted repos accessible  

2. **Plug In Encrypted Drive**
   - Pi detects physical presence  
   - Identity metadata becomes available  
   - Vaults and repos remain encrypted  

3. **Authenticate (Optional FIDO2 Key)**
   - User proves identity  
   - Repo unlock keys are derived  
   - Vault unlock keys are derived  

4. **Mount Identity**
   - Identity metadata loaded  
   - Permissions applied  
   - Identity‑scoped repos and vaults become accessible  

5. **Mount Vaults (In Memory Only)**
   - Vault contents decrypted in memory  
   - No decrypted data written to disk  
   - Applications interact with encrypted blobs  

6. **Use the Stack**
   - Open WebUI, Gitea, MinIO, Qdrant, etc.  
   - Access encrypted manifests  
   - Access encrypted metadata  
   - Access encrypted workflows  
   - Sensitive data never touches disk  

7. **Unplug Encrypted Drive**
   - All sensitive data disappears instantly  
   - Vaults unmounted  
   - Repos inaccessible  
   - Identity unloaded  
   - Pi returns to safe state  

8. **End (Pi Safe State)**
   - No sensitive data remains  
   - No decrypted data remains  
   - No keys remain in memory  

============================================================
5. THREAT MODEL (CONCEPT)
============================================================

This workflow protects against:

- remote attackers  
- compromised networks  
- malicious scripts  
- accidental uploads  
- filesystem scraping  
- unauthorized physical access  
- cloud service breaches  
- Pi compromise  

It does not rely on:
- cloud trust  
- online identity providers  
- remote key storage  
- plaintext caching  

============================================================
6. FAILURE MODES AND SAFETY
============================================================

If the Pi is compromised:
- no sensitive data is present  
- no keys are present  
- no decrypted data is present  
- unplugging the drive removes all access  

If the encrypted drive is stolen:
- data remains encrypted  
- keys are not stored on the drive  
- FIDO2 key required for unlock  

If the FIDO2 key is stolen:
- encrypted drive still required  
- Pi still required  
- identity metadata still required  

============================================================
7. FUTURE IMPLEMENTATION NOTES
============================================================

This subsystem will require:

- vault mount logic  
- repo mount logic  
- identity unlock logic  
- memory‑only decryption  
- safezone integration  
- wizard stack integration  
- tarball integration  
- hardware event detection  

These components will be designed later using:

- existing open‑source tools  
- stripped‑down components  
- custom sovereign implementations  

============================================================
8. STATUS
============================================================

This is a draft.  
Nothing in this document is final.  
This workflow exists to preserve intent and guide future development.

{% include footer.html %}
