---
layout: default
title: Storage Allocation and Quotas
---

# Storage Allocation and Quotas  
## Sovereign Disk Management for Full and Bootstrap Nodes (Layer 0)

This document defines how sovereign hardware nodes (full and bootstrap) allocate storage for ledger, backups, caching, routing metadata, and system overhead. It describes quota rules, enforcement behavior, and how nodes respond when storage becomes constrained. This is a service‑manual style reference for future implementers.

============================================================
1. PURPOSE AND SCOPE
============================================================

This document exists to:

- define storage allocation rules for full and bootstrap nodes  
- describe quota enforcement and threshold behavior  
- ensure nodes never corrupt ledger or governance due to storage issues  
- provide a blueprint for future implementers  

This is a conceptual architecture document, not a vendor-specific implementation.

============================================================
2. STORAGE PRINCIPLES
============================================================

Sovereign nodes must:

- allocate storage predictably  
- protect critical data (ledger, governance)  
- enforce quotas to prevent corruption  
- degrade gracefully when storage is low  
- refuse unsafe operations when storage is insufficient  

Storage sovereignty is foundational to network stability.

============================================================
3. STORAGE DOMAINS
============================================================

Nodes divide storage into five domains:

1. **Ledger Storage**  
2. **Backup Storage**  
3. **Public Page Cache Storage**  
4. **Routing Metadata Storage**  
5. **System Overhead Storage**

Full nodes allocate all five domains.  
Bootstrap nodes allocate a subset.

============================================================
4. LEDGER STORAGE
============================================================

### 4.1 Full Node Requirements

Full nodes must:

- store the **entire ledger history**  
- store ledger index files  
- store ledger signatures  
- maintain ledger integrity at all times  

Minimum allocation:

- **20–40% of total disk** (configurable)  

Ledger storage must:

- never be pruned  
- never be overwritten  
- never be compressed in ways that break signatures  

### 4.2 Bootstrap Node Requirements

Bootstrap nodes must:

- store **pruned ledger segments**  
- store signatures only  
- store minimal index files  

Minimum allocation:

- **5–10% of total disk**  

Bootstrap nodes must never store the full ledger.

============================================================
5. BACKUP STORAGE
============================================================

### 5.1 Full Node Requirements

Full nodes may store encrypted backups for users.

Backup storage:

- is optional  
- is encrypted  
- is quota-limited  
- is never allowed to overwrite ledger storage  

Recommended allocation:

- **20–50% of total disk**  

Full nodes must enforce:

- per-user quotas  
- per-node quotas  
- global backup limits  

### 5.2 Bootstrap Node Requirements

Bootstrap nodes may store:

- small encrypted backups  
- temporary backup fragments  

Recommended allocation:

- **10–20% of total disk**  

Bootstrap nodes must:

- refuse large backups  
- refuse backups when storage is low  

============================================================
6. PUBLIC PAGE CACHE STORAGE
============================================================

### 6.1 Full Node Requirements

Full nodes cache:

- frequently accessed public pages  
- routing metadata  
- mesh announcements  

Recommended allocation:

- **5–15% of total disk**  

Cache may be:

- pruned automatically  
- overwritten safely  
- rebuilt on demand  

### 6.2 Bootstrap Node Requirements

Bootstrap nodes cache:

- public pages  
- mesh routing hints  

Recommended allocation:

- **10–20% of total disk**  

Bootstrap nodes may:

- aggressively prune cache  
- rebuild cache frequently  

============================================================
7. ROUTING METADATA STORAGE
============================================================

### 7.1 Full Node Requirements

Full nodes store:

- routing tables  
- mesh topology metadata  
- peer trust metadata  
- domain routing hints  

Recommended allocation:

- **1–5% of total disk**  

Routing metadata must:

- never overwrite ledger  
- never overwrite governance rules  

### 7.2 Bootstrap Node Requirements

Bootstrap nodes store:

- minimal routing hints  
- peer discovery metadata  

Recommended allocation:

- **1–3% of total disk**  

============================================================
8. SYSTEM OVERHEAD STORAGE
============================================================

Nodes must reserve storage for:

- OS  
- logs  
- temporary files  
- governance rule updates  
- identity key storage  
- swap (if enabled and encrypted)  

Recommended allocation:

- **10–20% of total disk**  

System overhead must never exceed its quota.

============================================================
9. QUOTA RULES
============================================================

Nodes must enforce quotas strictly.

### 9.1 Hard Quotas

Hard quotas:

- cannot be exceeded  
- trigger immediate refusal of new data  
- protect ledger and governance integrity  

Hard quotas apply to:

- ledger storage  
- routing metadata  
- system overhead  

### 9.2 Soft Quotas

Soft quotas:

- may be exceeded temporarily  
- trigger warnings  
- trigger cache pruning  
- trigger backup throttling  

Soft quotas apply to:

- backup storage  
- public page cache  

============================================================
10. STORAGE THRESHOLD BEHAVIOR
============================================================

Nodes must respond to storage thresholds.

### 10.1 Warning Threshold (80%)

Nodes must:

- prune cache  
- throttle backups  
- reduce non-critical logging  
- announce warning to peers  

### 10.2 Critical Threshold (95%)

Nodes must:

- stop accepting backups  
- stop caching new pages  
- stop non-essential services  
- prioritize ledger and governance  

### 10.3 Failure Threshold (99%)

Nodes must:

- enter **STORAGE FAILURE MODE**  
- refuse authoritative actions  
- require administrator intervention  

============================================================
11. STORAGE FAILURE MODE
============================================================

Nodes enter STORAGE FAILURE MODE when:

- storage is critically low  
- ledger cannot be written  
- governance rules cannot be updated  
- routing metadata cannot be stored  

Full nodes in this mode:

- stop ledger validation  
- stop domain issuance  
- stop routing authority  
- announce degraded status  

Bootstrap nodes in this mode:

- stop caching  
- stop bandwidth contribution  
- require re-pairing if pruned ledger is affected  

============================================================
12. STORAGE RECOVERY
============================================================

Nodes recover by:

- freeing space  
- replacing storage devices  
- migrating to larger storage  
- pruning non-critical data  
- re-syncing ledger or pruned ledger  

Full nodes must:

- validate ledger after recovery  
- validate governance rules  
- rejoin mesh only after validation  

Bootstrap nodes must:

- re-pair with full node  
- re-sync pruned ledger  

============================================================
13. RELATION TO GOVERNANCE AND INCENTIVES
============================================================

### 13.1 Governance

Nodes must:

- obey governance rules for storage allocation  
- refuse unsafe operations when storage is low  
- maintain ledger integrity at all costs  

### 13.2 Incentives

Nodes earn reduced incentives when:

- storage is critically low  
- node enters STORAGE FAILURE MODE  
- node cannot perform assigned roles  

Nodes earn full incentives only when:

- storage is stable  
- quotas are respected  
- node operates reliably  

============================================================
14. IMPLEMENTATION GUIDELINES
============================================================

Future implementers should:

- use existing filesystem quota tools  
- avoid custom storage engines  
- design storage allocation to be simple and robust  
- ensure ledger storage is always protected  
- ensure bootstrap nodes cannot exceed safe limits  

This document is intended as a conceptual blueprint.

============================================================
15. STATUS
============================================================

This document defines storage allocation and quota rules for hardware nodes at Layer 0.  
It may be expanded as governance, ledger, routing, and domain documents are formalized.

It exists to:

- ensure nodes manage storage safely  
- protect ledger and governance integrity  
- guide future teams in building sovereign infrastructure  

Nothing here is final.  
Everything here is a starting point.

{% include footer.html %}
