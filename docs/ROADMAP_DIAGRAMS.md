---
layout: default
title: Master Diagrams — Sovereign Dev Stack
---

# Master Diagrams — Sovereign Dev Stack  
This page contains all major diagrams for the Sovereign Dev Stack.  
All diagrams are ASCII‑based to ensure GitHub Pages does not compress, distort, or break them.

---

# 🌐 1. DNS Chain Diagram

```
+-----------+        +-------------+        +--------------+
|  Client   | -----> | AdGuardHome | -----> |   Unbound    |
+-----------+        +-------------+        +--------------+
       |                     |                     |
       |                     |                     |
       |                     +---------------------+
       |                     |
       |                     v
       |              +-------------+
       +------------> |     NSD     |  (Authoritative DNS)
                      +-------------+
```

---

# 🔁 2. Reverse Proxy Routing Diagram (Caddy/Nginx)

```
                 +------------------+
                 |   Caddy/Nginx    |
                 |   (80 / 443)     |
                 +---------+--------+
                           |
        -------------------------------------------------
        |        |         |         |         |        |
        v        v         v         v         v        v
   +--------+ +-------+ +--------+ +--------+ +------+ +--------+
   | Open   | | Gitea | | MinIO  | | Qdrant | | VS   | | Wizard |
   | WebUI  | | 3000  | |9000/01 | | 6333   | | Code | | Stack  |
   |8080/80 | |  222  | |        | |        | |Server| |  UI    |
   +--------+ +-------+ +--------+ +--------+ +------+ +--------+
```

---

# 🔌 3. Port Map Diagram

```
53        → NSD (Authoritative DNS)
53        → AdGuard Home (LAN DNS)
5335      → Unbound (Recursive DNS)
80/443    → Caddy/Nginx (Reverse Proxy)
8080      → Open WebUI (Venv)
8000      → Open WebUI (Docker)
11434     → Ollama
5432      → Postgres
6379      → Redis
6333      → Qdrant
9000/9001 → MinIO
3000      → Gitea
222       → Gitea SSH
```

---

# 🏢 4. Enterprise Stack Diagram

```
+-----------+     +---------+     +---------+     +---------+
| Postgres  | <-- |  Redis  | <-- | Qdrant  | <-- |  MinIO  |
+-----------+     +---------+     +---------+     +---------+
       ^                ^               ^               ^
       |                |               |               |
       +----------------+---------------+---------------+
                           |
                           v
                     +-----------+
                     | OpenWebUI |
                     +-----------+
```

---

# 🧠 5. Tarball System Diagram

```
+-----------------------+
|  Tarball Download     |
+----------+------------+
           |
           v
+-----------------------+
|  SHA256 Verification  |
+----------+------------+
           |
           v
+-----------------------+
|  Smart Installer      |
|  - Extract            |
|  - Validate           |
|  - Repair             |
|  - Safe-mode          |
+----------+------------+
           |
           v
+-----------------------+
|  External Drive Stack |
+-----------------------+
```

---

# 🤖 6. Automation Bot Pipeline Diagram

```
+-----------+      +-----------+      +-----------+
|  Gitea    | ---> |  Bots     | ---> | Tarball   |
|  Push     |      |  Runner   |      | Builder   |
+-----------+      +-----------+      +-----------+
       |                 |                 |
       v                 v                 v
+-----------+      +-----------+      +-----------+
| Workflow  | ---> | Testing   | ---> | Release   |
| Trigger   |      | Pipeline  |      | Publish   |
+-----------+      +-----------+      +-----------+
```

---

# 🧱 7. Multi‑OS Runner Diagram (Proot + Docker)

```
+-----------------------+
|   Wizard Stack        |
+----------+------------+
           |
           v
+-----------------------+
|  Runner Manager       |
+----------+------------+
           |
           v
+-----------------------+     +-----------------------+
|  Proot Ubuntu Runner  |     |  Docker ARM64 Runner  |
+-----------------------+     +-----------------------+
           |                           |
           v                           v
+-----------------------+     +-----------------------+
|  Build Pipelines      |     |  Test Pipelines       |
+-----------------------+     +-----------------------+
```

---

# 🧩 8. Safezone Sandbox Diagram

```
+---------------------------+
|       Safezone            |
|  (Isolated Execution)     |
+-------------+-------------+
              |
              v
+---------------------------+
|  Tool Permissions         |
|  Resource Limits          |
|  Network Rules            |
|  Logging + Auditing       |
+-------------+-------------+
              |
              v
+---------------------------+
|  Agents / Bots / Tools    |
+---------------------------+
```

---

# 🧙 9. Wizard Stack Architecture Diagram  
(Your original Termux + proot Ubuntu version)

```
+---------------------------+
|       wizardctl CLI       |
+-------------+-------------+
              |
              v
+---------------------------+
|   CUE Schema Engine       |
+-------------+-------------+
              |
              v
+---------------------------+
|   Module Registry         |
+-------------+-------------+
              |
              v
+---------------------------+
|   Tool Registry           |
+-------------+-------------+
              |
              v
+---------------------------+
|   Build Orchestrator      |
+-------------+-------------+
              |
              v
+---------------------------+
|   Proot Ubuntu Runtime    |
+---------------------------+
```

---

# 🏁 Final Notes

This page contains every major diagram needed to understand, build, and maintain the Sovereign Dev Stack.  
It is designed to be ASCII‑safe so GitHub Pages cannot distort or break it.

{% include footer.html %}
