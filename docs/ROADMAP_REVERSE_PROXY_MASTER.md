---
layout: default
title: Master Reverse Proxy Routing Map (ASCII)
---

# Master Reverse Proxy Routing Map — Sovereign Dev Stack (ASCII)

This page contains the complete reverse proxy routing map for the Sovereign Dev Stack.  
It shows how Caddy/Nginx routes traffic from your sovereign domain to each internal service.

All ASCII.  
GitHub‑safe.  
No rendering issues.

---

# 🌐 Sovereign Reverse Proxy Routing Map

```
                           +---------------------------+
                           |        Internet           |
                           +-------------+-------------+
                                         |
                                         v
                           +---------------------------+
                           |     Caddy / Nginx         |
                           |   Reverse Proxy (80/443)  |
                           +------+------+-------------+
                                  |      |
          -------------------------      -------------------------
          |                                                     |
          v                                                     v

+---------------------------+                     +---------------------------+
|  ui.yourdomain.eu.org     |                     |  git.yourdomain.eu.org    |
|  → Open WebUI (8080/8000) |                     |  → Gitea (3000 / 222)     |
+---------------------------+                     +---------------------------+

+---------------------------+                     +---------------------------+
|  s3.yourdomain.eu.org     |                     |  vector.yourdomain.eu.org |
|  → MinIO (9000/9001)      |                     |  → Qdrant (6333)          |
+---------------------------+                     +---------------------------+

+---------------------------+                     +---------------------------+
|  db.yourdomain.eu.org     |                     |  code.yourdomain.eu.org   |
|  → Postgres (5432)        |                     |  → VS Code Server         |
+---------------------------+                     +---------------------------+

+---------------------------+                     +---------------------------+
| wizard.yourdomain.eu.org  |                     | bots.yourdomain.eu.org    |
| → Wizard Stack UI         |                     | → Automation Dashboards   |
+---------------------------+                     +---------------------------+
```

---

# 🔁 Routing Summary

```
Caddy/Nginx (80/443)
    |
    +--> ui.domain        → Open WebUI
    +--> git.domain       → Gitea
    +--> s3.domain        → MinIO
    +--> vector.domain    → Qdrant
    +--> db.domain        → Postgres
    +--> code.domain      → VS Code Server
    +--> wizard.domain    → Wizard Stack UI
    +--> bots.domain      → Automation Bots
```

### ✔ Clean separation  
Each service gets its own subdomain.

### ✔ Zero port conflicts  
Reverse proxy handles all public traffic.

### ✔ Full sovereignty  
All routing stays inside your Pi.

---

# 🧭 Notes

- This is the **canonical reverse proxy routing map** for the Sovereign Dev Stack.  
- ASCII format ensures GitHub Pages cannot distort or break it.  
- Store as:  
  ```
  docs/ROADMAP_REVERSE_PROXY_MASTER.md
  ```

---

{% include footer.html %}
