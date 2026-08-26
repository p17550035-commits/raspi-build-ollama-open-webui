---
layout: default
title: Master DNS Routing Map (ASCII)
---

# Master DNS Routing Map — Sovereign Dev Stack (ASCII)

This page contains the complete DNS routing map for the Sovereign Dev Stack.  
It shows how NSD, AdGuard Home, Unbound, and the reverse proxy interact to provide a fully sovereign DNS chain.

All ASCII.  
GitHub‑safe.  
No rendering issues.

---

# 🌐 Sovereign DNS Routing Map

```
                         +---------------------------+
                         |        Client Device      |
                         |  (Phone / PC / Pi / LAN)  |
                         +-------------+-------------+
                                       |
                                       v
                         +---------------------------+
                         |       AdGuard Home        |
                         |  (LAN DNS Filter / 53)    |
                         +-------------+-------------+
                                       |
                 -------------------------------------------------
                 |                                               |
                 v                                               v

+---------------------------+                     +---------------------------+
|         Unbound           |                     |           NSD             |
|  Recursive Resolver       |                     |  Authoritative DNS        |
|  DNSSEC / 5335            |                     |  Zone: yourdomain.eu.org  |
+-------------+-------------+                     +-------------+-------------+
              |                                               |
              |                                               |
              v                                               v

+---------------------------+                     +---------------------------+
|   Root DNS Infrastructure |                     |   Local Zone Records      |
|   (Global Root Servers)   |                     |   A / AAAA / CNAME / TXT  |
+-------------+-------------+                     |   SRV / MX / NS           |
              |                                   +-------------+-------------+
              |                                               |
              v                                               v

                         +---------------------------+
                         |       Caddy / Nginx       |
                         |   Reverse Proxy (80/443)  |
                         +-------------+-------------+
                                       |
                                       v

                         +---------------------------+
                         |     Sovereign Services    |
                         |  (OpenWebUI, Gitea, etc.) |
                         +---------------------------+
```

---

# 📡 DNS Flow Summary

```
Client → AdGuard → Unbound → Root Servers
Client → AdGuard → NSD → Local Zone → Reverse Proxy → Services
```

### ✔ External lookups  
Handled by **Unbound** → Root servers → DNSSEC validated.

### ✔ Internal + domain lookups  
Handled by **NSD** → authoritative zone → Caddy/Nginx → services.

### ✔ LAN filtering  
Handled by **AdGuard Home**.

### ✔ Full sovereignty  
No external DNS dependency required.

---

# 🧭 Notes

- This is the **canonical DNS routing map** for the Sovereign Dev Stack.  
- ASCII format ensures GitHub Pages cannot distort or break it.  
- Store as:  
  ```
  docs/ROADMAP_DNS_MASTER.md
  ```

---

{% include footer.html %}
