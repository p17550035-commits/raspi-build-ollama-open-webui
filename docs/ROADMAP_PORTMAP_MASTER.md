---
layout: default
title: Master Port Map (ASCII)
---

# Master Port Map — Sovereign Dev Stack (ASCII)

This page contains the complete port map for the Sovereign Dev Stack.  
All ASCII.  
GitHub‑safe.  
No rendering issues.

---

# 🔌 Sovereign Dev Stack — Full Port Map

```
+---------------------------------------------------------------+
|                         PORT MAP                              |
+----------------------+----------------------------------------+
| 53 (TCP/UDP)         | NSD — Authoritative DNS                |
| 53                   | AdGuard Home — LAN DNS Filtering       |
| 5335 (TCP/UDP)       | Unbound — Recursive DNS Resolver       |
+----------------------+----------------------------------------+
| 80 / 443             | Caddy / Nginx — Reverse Proxy          |
+----------------------+----------------------------------------+
| 8080                 | Open WebUI (Venv Edition)              |
| 8000                 | Open WebUI (Docker Edition)            |
| 11434                | Ollama — LLM Runtime                   |
+----------------------+----------------------------------------+
| 5432                 | PostgreSQL — Database                  |
| 6379                 | Redis — Cache / Queue                  |
| 6333                 | Qdrant — Vector DB                     |
| 9000 / 9001          | MinIO — S3 Storage + Console           |
+----------------------+----------------------------------------+
| 3000                 | Gitea — Git Hosting                    |
| 222                  | Gitea — SSH Access                     |
+----------------------+----------------------------------------+
| 22                   | SSH — Pi System Access                 |
+----------------------+----------------------------------------+
| 5000–5999            | Wizard Stack Internal Ports (Reserved) |
+----------------------+----------------------------------------+
| 6000–6999            | Multi‑OS Runners (Proot/Docker)        |
+----------------------+----------------------------------------+
| 7000–7999            | Safezone Sandbox (Isolated Tools)      |
+----------------------+----------------------------------------+
| 9000–9999            | Automation Bots / Pipelines            |
+----------------------+----------------------------------------+
```

---

# 🧭 Notes

- This port map is the **canonical reference** for the entire Sovereign Dev Stack.  
- Every service, runner, sandbox, and automation layer is represented.  
- ASCII format ensures GitHub Pages cannot distort or break it.  
- Store as:  
  ```
  docs/ROADMAP_PORTMAP_MASTER.md
  ```

---

{% include footer.html %}
