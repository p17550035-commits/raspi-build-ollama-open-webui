---
layout: default
title: Sovereign Node Architecture
---

# Sovereign Node Architecture  
## Hardware, Bootstrap, and Software Node Classes (Layer 0 and Up)

This document defines the architecture of nodes in the sovereign internet stack, starting from the absolute bottom layer. It describes:

- full hardware nodes (Layer 0)  
- bootstrap hardware nodes (Layer 0.5)  
- software nodes (Layer 3+)  

It also explains how incentives, governance, and expansion are tied to each node class, so that future builders can implement this system with today’s technology and minimal custom code.

============================================================
1. PURPOSE AND SCOPE
============================================================

The sovereign internet depends on **nodes** as its physical and logical backbone.

This document exists to:

- define what a node is at the hardware level  
- distinguish between full hardware nodes and bootstrap nodes  
- distinguish hardware nodes from software-only nodes  
- describe minimum requirements and expansion paths  
- tie node behavior to kernel governance and incentives  
- provide a service-manual-style reference for future implementers  

This is a conceptual and architectural document.  
It does not prescribe specific code, libraries, or vendors.

============================================================
2. NODE CLASSES OVERVIEW
============================================================

The sovereign internet uses three primary node classes:

1. **Full Hardware Nodes (Layer 0)**  
   - physical devices with sufficient resources  
   - fully independent and fully trusted  
   - enforce governance, maintain ledger, route traffic, issue domains  
   - receive full incentives (up to 49%)

2. **Bootstrap Hardware Nodes (Layer 0.5)**  
   - low-resource, entry-level devices (old phones, tablets, laptops, Pi with minimal storage)  
   - dependent on pairing with full nodes  
   - contribute storage, bandwidth, caching, and availability  
   - receive limited incentives (e.g., 10–20%)

3. **Software Nodes (Layer 3+)**  
   - purely logical nodes inside higher layers (routing, identity, cloud, browser, workflows)  
   - do not provide physical presence or hardware resources  
   - do not receive incentives  
   - extend functionality but do not anchor the network  

This distinction is critical for sovereignty, security, and fairness.

============================================================
3. FULL HARDWARE NODES (LAYER 0)
============================================================

### 3.1 Definition

A **full hardware node** is a physical device that:

- has dedicated CPU, RAM, and storage  
- has stable power and network connectivity  
- can run kernel-level governance logic  
- can store and maintain a full copy of the ledger  
- can participate in domain issuance and routing  
- can provide encrypted cloud backup and storage  
- can operate independently of any other node  

Examples:

- Raspberry Pi with SSD and Ethernet  
- home server with sufficient resources  
- dedicated sovereign appliance  
- mini-PC with stable uptime  

### 3.2 Responsibilities

Full hardware nodes:

- **Enforce Kernel Governance:**  
  - run the encrypted kernel logic  
  - apply rules to ledger, routing, and domains  

- **Maintain Ledger:**  
  - store full ledger history  
  - participate in daily merge and reconciliation  
  - validate new entries via timestamp + proof-of-work  

- **Issue Domains:**  
  - process domain registration requests  
  - record domain ownership in the ledger  
  - enforce collision resolution rules  

- **Route Traffic:**  
  - participate in mesh routing  
  - relay sovereign traffic  
  - adapt to node failures  

- **Provide Cloud Backup:**  
  - store encrypted backups for contributing users  
  - enforce storage quotas and policies  

- **Anchor the Network:**  
  - act as root-level infrastructure  
  - ensure the network remains sovereign and stable  

### 3.3 Minimum Hardware Requirements

Minimum viable full node:

- CPU: enough to run kernel, ledger, routing, and basic services  
- RAM: enough to hold decrypted working sets in memory  
- Storage: enough to store full ledger + backups (encrypted)  
- Network: stable connection (Ethernet preferred, Wi-Fi acceptable)  
- Power: reliable power source (UPS optional but recommended)  

These requirements are intentionally modest to allow broad participation.

### 3.4 Expansion Path

Full nodes can expand by:

- adding more storage (larger SSDs, HDDs)  
- adding more RAM  
- upgrading CPU or device class  
- adding hardware tokens for identity and signing  
- adding dedicated network interfaces  
- running additional sovereign services (apps, workflows, automation)  

Expansion increases:

- capacity  
- redundancy  
- routing quality  
- backup availability  

But does not change the fundamental role: full nodes remain Layer 0 anchors.

============================================================
4. BOOTSTRAP HARDWARE NODES (LAYER 0.5)
============================================================

### 4.1 Definition

A **bootstrap node** is a low-resource, hardware-based node that:

- runs on old or limited devices (phones, tablets, laptops, Pi with small storage)  
- relies on pairing with a trusted full node  
- cannot independently enforce governance or maintain a full ledger  
- contributes to the network via storage, bandwidth, caching, and availability  

Examples:

- old Android phone + USB-C hub + thumb drive  
- low-end Pi with small SD card and Wi-Fi  
- old laptop with limited resources  

### 4.2 Responsibilities

Bootstrap nodes:

- **Replicate Ledger (Pruned):**  
  - store a pruned, read-only subset of the ledger  
  - sync from a trusted full node  
  - never act as authoritative ledger sources  

- **Cache Public Pages:**  
  - store frequently accessed public content  
  - reduce load on full nodes  
  - improve local performance  

- **Contribute Bandwidth:**  
  - relay traffic where possible  
  - assist in mesh routing under supervision  

- **Provide Availability:**  
  - act as local access points for nearby devices  
  - extend reach of the sovereign network  

### 4.3 Limitations

Bootstrap nodes:

- cannot issue domains  
- cannot validate ledger entries  
- cannot enforce kernel governance independently  
- cannot act as root servers  
- cannot be treated as equal to full nodes  

They must always be:

- paired with at least one full node  
- regularly synced and pruned  
- monitored for integrity and uptime  

### 4.4 Incentives

Bootstrap nodes receive **limited incentives**, for example:

- Network: ≥ 80–90%  
- User: ≤ 10–20%  

They:

- are rewarded for participation  
- are encouraged as entry-level nodes  
- are never allowed to earn as much as full nodes  
- are never allowed to exceed 49% user reward  

This keeps incentives fair and prevents corruption.

============================================================
5. SOFTWARE NODES (LAYER 3+)
============================================================

### 5.1 Definition

A **software node** is a logical construct that:

- exists inside higher layers of the stack  
- does not correspond to a physical device  
- does not provide hardware resources  
- does not anchor the network  

Examples:

- routing nodes in the mesh layer  
- identity nodes in the identity layer  
- cloud nodes in the storage layer  
- browser nodes in the interface layer  
- workflow nodes in the automation layer  

### 5.2 Responsibilities

Software nodes:

- extend functionality  
- manage layer-specific tasks  
- coordinate services and workflows  
- interact with hardware nodes and users  

They do not:

- enforce kernel governance  
- maintain the ledger  
- issue domains  
- receive incentives  

### 5.3 Placement in the Stack

Software nodes live in layer-specific folders, for example:

- `sovereign_internet/routing/nodes/`  
- `sovereign_internet/identity/nodes/`  
- `sovereign_internet/cloud/nodes/`  
- `sovereign_internet/browser/nodes/`  
- `sovereign_internet/workflows/nodes/`  

This keeps the distinction between physical and logical nodes clear.

============================================================
6. INCENTIVE MODEL AND FAIRNESS
============================================================

### 6.1 Core Principle

Incentives must:

- reward contribution  
- support network growth  
- avoid speculation and corruption  
- never allow individuals to dominate the network  

### 6.2 Full Hardware Nodes

- Network: ≥ 51%  
- User: ≤ 49%  

Full nodes receive meaningful rewards, but the network always benefits more.

### 6.3 Bootstrap Nodes

- Network: ≥ 80–90%  
- User: ≤ 10–20%  

Bootstrap nodes are rewarded, but never treated as equal to full nodes.

### 6.4 Software Nodes

- Network: 100%  
- User: 0%  

Software nodes are functional constructs, not incentive targets.

### 6.5 Rationale

This model:

- encourages participation at all levels  
- protects the network from incentive abuse  
- keeps sovereignty and stability as the primary goals  
- ensures that hardware nodes remain the backbone of the system  

============================================================
7. GOVERNANCE TIE-IN
============================================================

Kernel governance (defined in a separate document) relies on:

- full hardware nodes to enforce rules  
- bootstrap nodes to extend reach without authority  
- software nodes to obey governance but not define it  

Node architecture must:

- respect governance constraints  
- ensure that only full nodes participate in consensus  
- ensure that bootstrap nodes cannot override rules  
- ensure that software nodes cannot impersonate hardware nodes  

This document is the hardware-level foundation for governance.

============================================================
8. IMPLEMENTATION GUIDELINES
============================================================

Future implementers should:

- start with full hardware nodes as the initial backbone  
- add bootstrap nodes to increase reach and accessibility  
- introduce software nodes only when higher layers are defined  
- keep the hardware/software distinction strict and documented  
- avoid mixing incentive logic into software-only layers  
- design with today’s technology (Pi, phones, laptops, hubs, drives)  
- minimize custom code where possible, using existing tools and protocols  

This document is intended to be used like a service manual:  
a reference for building, deploying, and maintaining nodes in a sovereign internet.

============================================================
9. STATUS
============================================================

This is a foundational architecture document.  
It is not final and may be expanded as other layers (kernel governance, ledger, routing, domains, browser, cloud) are defined.

It exists to:

- anchor the concept of nodes at the hardware level  
- provide a clear distinction between full, bootstrap, and software nodes  
- guide future teams or individuals who may implement this system  

Nothing here is set in stone.  
Everything here is a starting point.

{% include footer.html %}
