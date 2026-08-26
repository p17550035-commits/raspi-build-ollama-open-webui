---
layout: default
title: Master Wizard Stack Flowchart (ASCII)
---

# Master Wizard Stack Flowchart — Sovereign Dev Stack (ASCII)

This page contains the complete flowchart for the Wizard Stack.  
It represents the *real* Wizard Stack you originally built in Termux using proot‑Ubuntu — not the simplified version.  
This is the full architecture: schema engine, module registry, tool registry, orchestrator, runners, tarball builder, DNS generator, and service installers.

All ASCII.  
GitHub‑safe.  
No rendering issues.

---

# 🧙 Sovereign Wizard Stack — Master Flowchart

```
                          +---------------------------+
                          |        wizardctl CLI      |
                          |  (wizard build / run /    |
                          |   generate / install)     |
                          +-------------+-------------+
                                        |
                                        v
                          +---------------------------+
                          |     CUE Schema Engine     |
                          |  - Validates modules      |
                          |  - Generates pipelines    |
                          |  - Enforces structure     |
                          +-------------+-------------+
                                        |
                                        v
                          +---------------------------+
                          |      Module Registry      |
                          |  - wizard.json modules    |
                          |  - templates / presets    |
                          |  - service definitions    |
                          +-------------+-------------+
                                        |
                                        v
                          +---------------------------+
                          |       Tool Registry       |
                          |  - Build tools            |
                          |  - System tools           |
                          |  - Network tools          |
                          |  - DNS tools              |
                          +-------------+-------------+
                                        |
                                        v
                          +---------------------------+
                          |     Build Orchestrator    |
                          |  - Multi-step pipelines   |
                          |  - Dependency resolver    |
                          |  - Task scheduler         |
                          +-------------+-------------+
                                        |
                                        v
        -------------------------------------------------------------------------
        |                                                                       |
        v                                                                       v

+---------------------------+                                   +---------------------------+
|     Proot Ubuntu Runner   |                                   |     Docker ARM64 Runner   |
|  - Isolated FS            |                                   |  - Containerized builds   |
|  - Multi-OS builds        |                                   |  - Service builds         |
|  - Toolchain sandbox      |                                   |  - CI/CD integration      |
+-------------+-------------+                                   +-------------+-------------+
              |                                                               |
              v                                                               v

+---------------------------+                                   +---------------------------+
|     Pipeline Executor     |                                   |     Test Executor         |
|  - Build pipelines        |                                   |  - Unit tests             |
|  - Tarball creation       |                                   |  - Integration tests      |
|  - Service installers     |                                   |  - Health checks          |
+-------------+-------------+                                   +-------------+-------------+
              |                                                               |
              v                                                               v

+---------------------------+                                   +---------------------------+
|     Tarball Builder       |                                   |     DNS Config Generator  |
|  - Service tarballs       |                                   |  - NSD zone files         |
|  - Model tarballs         |                                   |  - Caddy/Nginx routes     |
|  - Upgrade tarballs       |                                   |  - Subdomain mapping      |
+-------------+-------------+                                   +-------------+-------------+
              |                                                               |
              v                                                               v

+---------------------------+                                   +---------------------------+
|     Installer Engine      |                                   |     Wizard Stack UI       |
|  - Safe-mode installs     |                                   |  - Web interface          |
|  - Repair mode            |                                   |  - Runner management      |
|  - Health validation      |                                   |  - Tarball actions        |
+-------------+-------------+                                   +-------------+-------------+
              |                                                               |
              v                                                               v

+---------------------------+                                   +---------------------------+
|     Automation Bots       |                                   |     Safezone Sandbox      |
|  - CI/CD pipelines        |                                   |  - Isolated execution     |
|  - Tarball publishing     |                                   |  - Tool permissions       |
|  - Workflow automation    |                                   |  - Resource limits        |
+---------------------------+                                   +---------------------------+
```

---

# 🔁 Wizard Stack Summary

```
wizardctl CLI
    ↓
CUE Schema Engine
    ↓
Module Registry
    ↓
Tool Registry
    ↓
Build Orchestrator
    ↓
Runners (Proot + Docker)
    ↓
Pipeline Executor
    ↓
Tarball Builder + DNS Generator
    ↓
Installer Engine
    ↓
Bots + Safezone
```

This is the **full, real Wizard Stack** — the one you built on your phone, now adapted for the Sovereign Dev Stack.

---

# 🧭 Notes

- This is the **canonical Wizard Stack flowchart** for your Sovereign Dev Stack.  
- ASCII format ensures GitHub Pages cannot distort or break it.  
- Store as:  
  ```
  docs/ROADMAP_WIZARDSTACK_MASTER.md
  ```

---

{% include footer.html %}
