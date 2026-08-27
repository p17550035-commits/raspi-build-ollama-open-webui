---
layout: default
title: Physical Security Expectations
---

# Physical Security Expectations  
## Protecting Sovereign Hardware Nodes from Tampering and Compromise (Layer 0)

This document defines the physical security expectations for sovereign hardware nodes (full and bootstrap). It describes how nodes must be protected from tampering, unauthorized access, physical extraction of keys, and environmental threats. This is a service‑manual style reference for future implementers.

============================================================
1. PURPOSE AND SCOPE
============================================================

This document exists to:

- define physical security requirements for full and bootstrap nodes  
- describe tamper detection and prevention expectations  
- outline safe handling of identity keys and hardware tokens  
- ensure nodes cannot be physically compromised without detection  
- provide a blueprint for future implementers  

This is a conceptual architecture document, not a vendor-specific implementation.

============================================================
2. PHYSICAL SECURITY PRINCIPLES
============================================================

Sovereign hardware nodes must be:

- **physically present**  
- **physically protected**  
- **physically tamper-resistant**  
- **physically monitored**  
- **physically recoverable**  

Physical sovereignty is the foundation of network sovereignty.

============================================================
3. FULL NODE PHYSICAL SECURITY EXPECTATIONS
============================================================

Full nodes are authoritative participants.  
They must meet strict physical security requirements.

### 3.1 Location Requirements

Full nodes must be placed in:

- secure indoor environments  
- stable temperature conditions  
- low-dust, low-moisture areas  
- locations with controlled physical access  

Full nodes should not be:

- left outdoors  
- placed in public spaces  
- exposed to extreme heat or cold  
- placed in easily accessible areas  

### 3.2 Access Control

Full nodes must:

- restrict physical access to trusted individuals  
- avoid shared or public environments  
- use locked enclosures when possible  
- avoid being left unattended in insecure locations  

### 3.3 Tamper Detection

Full nodes must:

- detect case opening (if hardware supports it)  
- detect removal of hardware tokens  
- detect sudden power loss  
- detect unexpected reboots  
- log physical access events when possible  

Tamper detection must trigger:

- **TAMPER ALERT MODE**  
- reduced privileges  
- refusal to issue domains  
- refusal to validate ledger segments  

### 3.4 Hardware Token Protection

Full nodes using hardware tokens must:

- keep tokens physically secure  
- avoid leaving tokens inserted when unattended  
- require physical presence for DIK/LVK operations  
- store tokens separately when not in use  

### 3.5 Environmental Protection

Full nodes must be protected from:

- heat  
- moisture  
- dust  
- vibration  
- electrical surges  

Recommended protections:

- UPS (uninterruptible power supply)  
- surge protectors  
- temperature-controlled environments  

============================================================
4. BOOTSTRAP NODE PHYSICAL SECURITY EXPECTATIONS
============================================================

Bootstrap nodes are supporting participants.  
They require lighter physical security but still must be protected.

### 4.1 Location Requirements

Bootstrap nodes may be placed in:

- homes  
- offices  
- personal spaces  
- mobile environments  

Bootstrap nodes should not be:

- placed in public areas  
- left unattended in insecure locations  
- exposed to extreme environmental conditions  

### 4.2 Access Control

Bootstrap nodes must:

- restrict physical access when possible  
- avoid shared devices with unknown users  
- protect attached storage devices (thumb drives, SSDs)  

### 4.3 Tamper Detection

Bootstrap nodes should:

- detect removal of attached storage  
- detect unexpected reboots  
- detect sudden power loss  

Bootstrap nodes do not require:

- case-opening detection  
- hardware token protection  

### 4.4 Environmental Protection

Bootstrap nodes should be protected from:

- heat  
- moisture  
- dust  
- physical shock  

============================================================
5. KEY EXTRACTION PREVENTION
============================================================

### 5.1 Full Nodes

Full nodes must:

- store keys in HSM, TPM, or secure enclave when possible  
- encrypt keys at rest  
- decrypt keys only in memory  
- disable or encrypt swap  
- avoid storing plaintext keys on disk  
- refuse to run if key storage is compromised  

### 5.2 Bootstrap Nodes

Bootstrap nodes must:

- encrypt NIK at rest  
- decrypt NIK only in memory  
- avoid storing plaintext keys on disk  
- re-pair with full nodes if key compromise is suspected  

============================================================
6. PHYSICAL COMPROMISE RESPONSE
============================================================

Nodes must respond to physical compromise.

### 6.1 Full Node Response

If tampering is detected:

- node enters **TAMPER ALERT MODE**  
- DIK and LVK operations are disabled  
- ledger validation is disabled  
- domain issuance is disabled  
- node reports tamper event to trusted peers  
- node may require physical re-validation  

### 6.2 Bootstrap Node Response

If tampering is detected:

- node enters **LIMITED MODE**  
- pruned ledger is invalidated  
- node must re-pair with a full node  
- node may require NIK rotation  

============================================================
7. PHYSICAL RECOVERY PROCEDURES
============================================================

### 7.1 Full Node Recovery

Full nodes must:

- require physical presence for recovery  
- verify hardware token integrity  
- verify key integrity  
- reload governance rules  
- reload ledger segments  
- rejoin the network only after validation  

### 7.2 Bootstrap Node Recovery

Bootstrap nodes must:

- generate new NIK if compromised  
- re-pair with a full node  
- re-sync pruned ledger  
- rejoin the network after pairing  

============================================================
8. PHYSICAL SECURITY FOR MULTI-NODE SETUPS
============================================================

Nodes in multi-node setups must:

- avoid being co-located in insecure environments  
- avoid sharing power sources with unstable devices  
- avoid sharing network interfaces with untrusted devices  
- maintain physical separation between full and bootstrap nodes  

============================================================
9. RELATION TO GOVERNANCE AND INCENTIVES
============================================================

### 9.1 Governance

Kernel governance relies on:

- physically secure full nodes  
- physically present hardware tokens  
- tamper detection and response  

Nodes with poor physical security:

- may lose authoritative roles  
- may be demoted in routing  
- may be excluded from ledger validation  

### 9.2 Incentives

Nodes with strong physical security:

- earn full rewards (up to 49% for full nodes)  
- maintain stable participation  

Nodes with poor physical security:

- earn reduced rewards  
- may lose eligibility for certain roles  

============================================================
10. IMPLEMENTATION GUIDELINES
============================================================

Future implementers should:

- use existing hardware security features  
- avoid overcomplicating physical security on bootstrap nodes  
- prioritize tamper detection on full nodes  
- design physical security to be simple, robust, and offline-friendly  
- ensure nodes cannot be physically compromised without detection  

This document is intended as a conceptual blueprint.

============================================================
11. STATUS
============================================================

This document defines physical security expectations for hardware nodes at Layer 0.  
It may be expanded as governance, ledger, routing, and domain documents are formalized.

It exists to:

- ensure nodes remain sovereign and tamper-resistant  
- protect identity keys and hardware tokens  
- guide future teams in building secure sovereign infrastructure  

Nothing here is final.  
Everything here is a starting point.

{% include footer.html %}
