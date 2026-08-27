---
layout: default
title: Bootstrap Node Pairing Protocol
---

# Bootstrap Node Pairing Protocol  
## Secure Pairing, Syncing, and Trust Inheritance for Layer 0.5 Nodes

This document defines the complete pairing protocol for bootstrap hardware nodes. It describes how low-resource nodes securely pair with full nodes, sync pruned ledger segments, inherit trust relationships, and safely participate in the sovereign mesh network without ever being treated as authoritative.

============================================================
1. PURPOSE AND SCOPE
============================================================

This document exists to:

- define how bootstrap nodes pair with full nodes  
- describe trust inheritance and validation rules  
- outline pruned ledger syncing and update behavior  
- ensure bootstrap nodes cannot impersonate full nodes  
- provide a service-manual blueprint for future implementers  

This is a conceptual architecture document, not a vendor-specific implementation.

============================================================
2. BOOTSTRAP NODE PRINCIPLES
============================================================

Bootstrap nodes must:

- be easy to run on old or limited hardware  
- rely on full nodes for validation and trust  
- contribute bandwidth, caching, and availability  
- never enforce governance  
- never validate ledger segments  
- never issue domains  
- never act as root servers  

Bootstrap nodes are **supporting participants**, not authoritative ones.

============================================================
3. PAIRING OVERVIEW
============================================================

Bootstrap node pairing consists of six stages:

1. **Discovery of Nearby Full Nodes**  
2. **Identity Exchange**  
3. **Trust Inheritance**  
4. **Pruned Ledger Sync**  
5. **Role Assignment**  
6. **Operational Participation**

Full nodes control the pairing process.  
Bootstrap nodes request pairing but cannot demand it.

============================================================
4. STAGE 1 — DISCOVERY OF NEARBY FULL NODES
============================================================

Bootstrap nodes discover full nodes using:

- local network broadcast  
- mesh routing hints  
- cached peer lists  
- manual pairing (optional fallback)  

Discovery must:

- avoid leaking sensitive data  
- avoid trusting unknown peers  
- prefer physically nearby nodes  

If no full node is found:

- bootstrap node enters **DISCOVERY MODE**  
- retries periodically  
- may operate offline as a local cache  

============================================================
5. STAGE 2 — IDENTITY EXCHANGE
============================================================

### 5.1 Bootstrap Node Behavior

Bootstrap nodes send:

- **Node Identity Key (NIK)**  
- hardware profile  
- resource availability (bandwidth, storage, uptime)  
- pairing request  

Bootstrap nodes do **not** send:

- personal data  
- DIK or LVK (they do not possess these)  
- any sensitive configuration  

### 5.2 Full Node Behavior

Full nodes respond with:

- their own NIK  
- trust metadata  
- governance rule version  
- ledger segment availability  

Full nodes verify:

- bootstrap node NIK signature  
- bootstrap node hardware profile  
- bootstrap node resource claims  

If verification fails:

- pairing is rejected  
- bootstrap node enters **PAIRING FAILURE MODE**  

============================================================
6. STAGE 3 — TRUST INHERITANCE
============================================================

Bootstrap nodes cannot establish trust independently.

They must inherit trust from a full node.

### 6.1 Full Node Responsibilities

Full nodes:

- validate bootstrap node identity  
- assign trust level (e.g., LIMITED TRUST)  
- record pairing in local trust tables  
- optionally record pairing in the ledger (non-authoritative metadata)  

### 6.2 Bootstrap Node Responsibilities

Bootstrap nodes:

- accept trust level  
- store full node identity  
- use full node as primary validator  
- refuse to trust any other node without full node approval  

============================================================
7. STAGE 4 — PRUNED LEDGER SYNC
============================================================

Bootstrap nodes cannot store or validate the full ledger.

They must:

- request pruned ledger segments  
- verify signatures only  
- store segments in encrypted storage  
- request updates periodically  

Full nodes must:

- provide pruned ledger segments  
- ensure segments contain no sensitive data  
- ensure segments are signed and versioned  
- refuse to send full ledger history  

If pruned ledger sync fails:

- bootstrap node enters **LEDGER SYNC FAILURE MODE**  

============================================================
8. STAGE 5 — ROLE ASSIGNMENT
============================================================

Full nodes assign roles to bootstrap nodes based on:

- hardware capability  
- bandwidth availability  
- storage capacity  
- uptime reliability  
- network topology  

Bootstrap node roles may include:

- public page caching  
- bandwidth contribution  
- mesh redundancy  
- local access point  
- limited routing assistance  

Bootstrap nodes may **not**:

- issue domains  
- validate ledger entries  
- participate in governance  
- act as authoritative routing nodes  

============================================================
9. STAGE 6 — OPERATIONAL PARTICIPATION
============================================================

Bootstrap nodes enter operational mode when:

- pairing is complete  
- trust is inherited  
- pruned ledger is synced  
- roles are assigned  
- network connectivity is stable  

Operational bootstrap nodes:

- contribute bandwidth  
- cache public pages  
- assist routing under supervision  
- extend network reach  
- improve availability  

They remain **non-authoritative** at all times.

============================================================
10. RE-PAIRING AND MULTI-NODE PAIRING
============================================================

Bootstrap nodes may:

- re-pair with a different full node  
- maintain multiple pairings for redundancy  
- switch primary pairing based on reliability  

Full nodes may:

- drop pairing if bootstrap node becomes unstable  
- reassign roles dynamically  
- require re-validation after key rotation  

============================================================
11. FAILURE MODES
============================================================

Bootstrap nodes may enter:

- **DISCOVERY MODE:** no full node found  
- **PAIRING FAILURE MODE:** identity or trust failure  
- **LEDGER SYNC FAILURE MODE:** pruned ledger unavailable  
- **NETWORK FAILURE MODE:** connectivity issues  
- **LIMITED MODE:** hardware issues  

Failure modes prevent bootstrap nodes from corrupting the network.

============================================================
12. SECURITY EXPECTATIONS
============================================================

Bootstrap nodes must:

- encrypt pruned ledger storage  
- protect NIK from extraction  
- refuse to trust unknown nodes  
- refuse to impersonate full nodes  
- obey governance rules at all times  

Full nodes must:

- validate bootstrap node identity  
- enforce trust inheritance rules  
- refuse unauthorized pairing  
- monitor bootstrap node behavior  

============================================================
13. RELATION TO GOVERNANCE AND INCENTIVES
============================================================

### 13.1 Governance

Bootstrap nodes:

- obey governance  
- cannot enforce governance  
- cannot validate governance rules  
- rely entirely on full nodes for rule interpretation  

### 13.2 Incentives

Bootstrap nodes earn:

- ≤ 10–20% user rewards  
- never equal to full nodes  
- never exceeding 49%  
- reduced rewards if unstable or frequently failing  

============================================================
14. IMPLEMENTATION GUIDELINES
============================================================

Future implementers should:

- use existing secure pairing protocols (mutual TLS, signed handshakes)  
- minimize custom code  
- design pairing to be simple and robust  
- ensure bootstrap nodes cannot escalate privileges  
- ensure pairing is safe even on low-resource devices  

This document is intended as a conceptual blueprint.

============================================================
15. STATUS
============================================================

This document defines the pairing protocol for bootstrap nodes at Layer 0.5.  
It may be expanded as ledger, routing, and governance documents are formalized.

It exists to:

- ensure bootstrap nodes join the network safely  
- prevent corruption or impersonation  
- guide future teams in building sovereign infrastructure  

Nothing here is final.  
Everything here is a starting point.

{% include footer.html %}
