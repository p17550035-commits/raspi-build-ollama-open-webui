---
title: "Hardware Node Diagnostics"
layout: default
---
#
# # Hardware Node Diagnostics
# Sovereign Internet — Zero Layer Hardware Specification  
# Version: 1.0.0  
# Last Updated: 2026‑08‑26
#
# ---
#
# ## Purpose
#
# Hardware node diagnostics define the baseline health model for all sovereign nodes.  
# They ensure deterministic behavior, predictable repair paths, and zero external telemetry.
#
# Diagnostics apply to:
#
# - Raspberry Pi nodes  
# - x86 mini‑PC nodes  
# - Future sovereign node form factors  
#
# All diagnostics produce machine‑readable codes and human‑readable summaries.
#
# ---
#
# ## Diagnostic Layers
#
# ### Power & Physical Integrity
#
# **Checks:**
#
# - PSU voltage stability  
# - Undervoltage throttling  
# - Cable integrity  
# - Cooling (heatsink, fan, airflow)  
# - Case integrity  
#
# **Codes:**  
# `POWER_OK`, `POWER_WARN`, `POWER_FAIL`
#
# ---
#
# ### Storage Health
#
# **Checks:**
#
# - Storage type (SD, SSD, eMMC)  
# - SMART metrics (if supported)  
# - Read/write test (64–256 MB)  
# - I/O latency sampling  
#
# **Codes:**  
# `STORAGE_OK`, `STORAGE_DEGRADED`, `STORAGE_FAIL`
#
# ---
#
# ### Filesystem Integrity
#
# **Checks:**
#
# - Partition presence  
# - Partition labels  
# - Safe `fsck` or scheduled repair  
# - Critical directory presence:
#   - `/sovereign/`  
#   - `/sovereign/nodes/`  
#   - `/sovereign/logs/`  
#   - `/sovereign/cache/`  
#
# **Codes:**  
# `FS_OK`, `FS_REPAIR_NEEDED`, `FS_CRITICAL`
#
# ---
#
# ### Network Stack
#
# **Checks:**
#
# - Interface enumeration  
# - Link state  
# - IP assignment  
# - Latency tests:
#   - Local gateway  
#   - Mesh neighbors  
#   - Optional external sentinel  
#
# **Codes:**  
# `NET_OK`, `NET_PARTIAL`, `NET_FAIL`
#
# ---
#
# ### Sovereign Services
#
# **Checks:**
#
# - Node agent  
# - Ledger client  
# - Sovereign DNS layer  
# - Replication/storage service  
# - Local API endpoints  
#
# **Codes:**  
# `SERVICES_OK`, `SERVICES_DEGRADED`, `SERVICES_DOWN`
#
# ---
#
# ## Diagnostic Modes
#
# ### Quick Mode
# Lightweight, fast, no disk‑intensive operations.
#
# ### Full Mode
# Includes storage tests, extended network probes, optional `fsck`.
#
# ### Offline‑Safe Mode
# No external calls; only local and mesh checks.
#
# ---
#
# ## Invocation
#
# ### CLI
# ```
# sovereign-node diag --mode <quick|full|offline-safe>
# ```
#
# ### API
# ```
# POST /node/diagnostics
# {
#   "mode": "full",
#   "include_logs": true
# }
# ```
#
# ---
#
# ## Output Format
#
# ### Summary Fields
#
# - `status` — OK / WARN / FAIL  
# - `node_id` — stable identifier  
# - `timestamp` — ISO 8601  
# - `profile` — hardware profile  
#
# ### Example Output
#
# ```json
# {
#   "status": "WARN",
#   "node_id": "pi4-01",
#   "timestamp": "2026-08-26T22:35:00",
#   "profile": {
#     "model": "Raspberry Pi 4B",
#     "ram": "4GB",
#     "storage": "SSD"
#   },
#   "layers": [
#     {
#       "layer": "power",
#       "status": "OK",
#       "details": "No undervoltage events detected",
#       "codes": ["POWER_OK"]
#     },
#     {
#       "layer": "storage",
#       "status": "WARN",
#       "details": "SMART reports 3 reallocated sectors",
#       "codes": ["STORAGE_DEGRADED"]
#     }
#   ]
# }
# ```
#
# ---
#
# ## Repair Guidance
#
# ### Power Issues
# Replace PSU, check cabling, verify wall power stability.
#
# ### Storage Issues
# Migrate to new device, run backup snapshot, schedule controlled reboot.
#
# ### Filesystem Issues
# Queue `fsck`, avoid new writes, mark node for maintenance.
#
# ### Network Issues
# Check cables, verify switch ports, validate overlay config.
#
# ### Service Issues
# Restart services, inspect logs, mark node for deeper diagnostics.
#
# ---
#
# ## Logging & Privacy
#
# - Logs stored at: `/sovereign/logs/diagnostics/`  
# - Retention configurable per node  
# - No external telemetry  
# - Diagnostics remain fully sovereign  
#
# ---
#
 {% include footer.html %}
