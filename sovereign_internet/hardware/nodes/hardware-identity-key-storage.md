---
layout: default
title: Hardware Identity and Key Storage
---

# Hardware Identity and Key Storage  
## Sovereign Cryptographic Identity at the Physical Layer (Layer 0)

This document defines how sovereign hardware nodes (full and bootstrap) generate, store, protect, and use cryptographic identity keys. It is written as a service‑manual style reference so future implementers can build secure, tamper‑resistant identity systems using today’s technology with minimal custom code.

============================================================
1. PURPOSE AND SCOPE
============================================================

This document exists to:

- define how hardware nodes create and store sovereign identity keys  
- describe physical and logical key protection mechanisms  
- distinguish identity handling between full nodes and bootstrap nodes  
- define how keys interact with kernel governance, ledger, and incentives  
- provide a blueprint for future implementers to build secure identity systems  

This is a conceptual architecture document, not a vendor‑specific implementation.

============================================================
2. SOVEREIGN IDENTITY PRINCIPLES
============================================================

Sovereign identity must be:

- **hardware‑anchored**  
- **cryptographically secure**  
- **non‑transferable**  
- **non‑spoofable**  
- **non‑recoverable without physical access**  
- **independent of accounts, emails, or personal data**  
- **usable offline**  
- **compatible with minimal hardware**  

Identity is not tied to a person — it is tied to a **node**.

============================================================
3. IDENTITY KEY TYPES
============================================================

Hardware nodes use three primary key types:

### 3.1 Node Identity Key (NIK)
- unique to each node  
- generated at first boot  
- stored in secure hardware or encrypted storage  
- used to authenticate the node to the network  
- used to sign ledger participation and routing metadata  

### 3.2 Domain Issuance Key (DIK)
- used only by full nodes  
- signs domain issuance requests  
- signs domain ownership records  
- never shared with bootstrap nodes  

### 3.3 Ledger Validation Key (LVK)
- used by full nodes  
- validates ledger segments  
- signs ledger merge participation  
- ensures ledger integrity  

Bootstrap nodes do not possess DIK or LVK.

============================================================
4. KEY GENERATION
============================================================

### 4.1 Requirements

Key generation must:

- occur on the node itself  
- never rely on external servers  
- use strong entropy sources  
- produce keys that never leave the device unencrypted  

### 4.2 Full Node Key Generation

Full nodes generate:

- NIK  
- DIK  
- LVK  

All keys are generated at first boot or during secure initialization.

### 4.3 Bootstrap Node Key Generation

Bootstrap nodes generate:

- NIK only  

Bootstrap nodes do not generate DIK or LVK because they cannot issue domains or validate ledger entries.

============================================================
5. KEY STORAGE METHODS
============================================================

Nodes may use one or more of the following storage methods:

### 5.1 Hardware Security Modules (HSM)
Ideal for:

- Raspberry Pi with hardware security add‑ons  
- dedicated sovereign appliances  
- mini‑servers with TPM or secure enclave  

Keys stored in HSMs:

- never leave the module  
- cannot be extracted  
- are used via secure signing operations  

### 5.2 Encrypted Storage on Disk
Used when HSM is unavailable.

Requirements:

- keys must be encrypted at rest  
- keys must be decrypted only in memory  
- keys must never be written to disk in plaintext  
- swap must be disabled or encrypted  

### 5.3 External Hardware Tokens
Optional but recommended for:

- DIK  
- LVK  

Tokens:

- store keys offline  
- require physical presence to sign critical operations  
- prevent remote compromise  

============================================================
6. KEY ACCESS RULES
============================================================

### 6.1 Full Nodes

Full nodes may:

- access NIK for authentication  
- access DIK for domain issuance  
- access LVK for ledger validation  

Full nodes must:

- restrict DIK and LVK access to kernel governance  
- never expose keys to user‑level processes  
- never transmit keys over the network  

### 6.2 Bootstrap Nodes

Bootstrap nodes may:

- access NIK for authentication  
- sign basic participation metadata  

Bootstrap nodes must:

- never attempt domain issuance  
- never attempt ledger validation  
- never request DIK or LVK from full nodes  

============================================================
7. KEY ROTATION
============================================================

### 7.1 Full Nodes

Full nodes may rotate:

- NIK (rarely)  
- DIK (periodically)  
- LVK (during governance updates)  

Rotation must:

- be signed by the previous key  
- be recorded in the ledger  
- require physical presence for DIK/LVK rotation  

### 7.2 Bootstrap Nodes

Bootstrap nodes may rotate:

- NIK only  

Rotation must:

- be signed by the previous NIK  
- be validated by a paired full node  

============================================================
8. KEY LOSS AND RECOVERY
============================================================

### 8.1 Full Nodes

If a full node loses:

- **NIK:** node must be re‑initialized  
- **DIK:** domain issuance authority is lost  
- **LVK:** ledger validation authority is lost  

Recovery requires:

- physical presence  
- secure re‑initialization  
- ledger update to reflect new keys  

### 8.2 Bootstrap Nodes

If a bootstrap node loses NIK:

- it must be re‑paired with a full node  
- it must generate a new NIK  
- the network must treat it as a new node  

============================================================
9. SECURITY EXPECTATIONS
============================================================

Nodes must:

- protect keys from physical theft  
- protect keys from remote extraction  
- protect keys from tampering  
- protect keys from unauthorized access  

Full nodes must:

- use hardware tokens or HSMs when possible  
- enforce kernel governance restrictions on key usage  

Bootstrap nodes must:

- use encrypted storage  
- rely on full nodes for validation  

============================================================
10. RELATION TO GOVERNANCE AND INCENTIVES
============================================================

### 10.1 Governance

Kernel governance relies on:

- NIK for node identity  
- DIK for domain issuance  
- LVK for ledger validation  

Full nodes enforce governance.  
Bootstrap nodes obey governance.  
Software nodes follow governance.

### 10.2 Incentives

Nodes must sign participation with NIK.

Full nodes earn:

- up to 49% user rewards  

Bootstrap nodes earn:

- up to 10–20% user rewards  

Software nodes earn:

- 0%  

============================================================
11. IMPLEMENTATION GUIDELINES
============================================================

Future implementers should:

- use existing hardware security features (TPM, secure enclave, HSM)  
- avoid storing plaintext keys on disk  
- disable swap or encrypt it  
- require physical presence for DIK/LVK operations  
- design key storage to be simple, robust, and offline‑friendly  

This document is intended as a conceptual blueprint.

============================================================
12. STATUS
============================================================

This document defines identity and key storage expectations for hardware nodes at Layer 0.  
It may be expanded as kernel governance, ledger protocol, and domain issuance documents are formalized.

It exists to:

- anchor sovereign identity at the hardware layer  
- ensure nodes are secure and tamper‑resistant  
- guide future teams in building sovereign infrastructure  

Nothing here is final.  
Everything here is a starting point.

{% include footer.html %}
