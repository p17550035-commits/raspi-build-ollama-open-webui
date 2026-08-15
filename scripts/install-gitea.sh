```bash
#!/bin/bash
# ============================================================
# COMPONENT INSTALLER — GITEA (SELF-HOSTED GIT)
# ============================================================
# This script:
#   - Installs Gitea (ARM64 binary)
#   - Creates Gitea data directory on external drive (if mounted)
#   - Creates a dedicated gitea user
#   - Creates a Gitea systemd service
#   - Starts Gitea automatically
#
# Safe to run standalone OR inside any master installer.
# ============================================================

MOUNT_POINT="/mnt/pidrive"
GITEA_DIR="$MOUNT_POINT/stack/gitea"

echo "=== GITEA INSTALLER STARTED ==="

# ------------------------------------------------------------
# Install Gitea binary
# ------------------------------------------------------------
echo "Downloading Gitea..."
wget -q https://dl.gitea.com/gitea/1.22.0/gitea-1.22.0-linux-arm64 -O /usr/local/bin/gitea
chmod +x /usr/local/bin/gitea

# ------------------------------------------------------------
# Prepare external drive directory
# ------------------------------------------------------------
if [ ! -d "$MOUNT_POINT" ]; then
    echo "External drive not mounted. Using default Gitea location."
    DATA_DIR="/var/lib/gitea"
else
    echo "Creating Gitea directory at $GITEA_DIR..."
    mkdir -p "$GITEA_DIR"
    DATA_DIR="$GITEA_DIR"
fi

# ------------------------------------------------------------
# Create gitea user
# ------------------------------------------------------------
echo "Creating Gitea user..."
sudo useradd -r -m -U -d "$DATA_DIR" -s /bin/bash gitea 2>/dev/null
sudo chown -R gitea:gitea "$DATA_DIR"

# ------------------------------------------------------------
# Create systemd service
# ------------------------------------------------------------
echo "Creating Gitea systemd service..."

sudo bash -c "cat >/etc/systemd/system/gitea.service" <<EOF
[Unit]
Description=Gitea Git Service
After=network.target

[Service]
User=gitea
Group=gitea
WorkingDirectory=$DATA_DIR
ExecStart=/usr/local/bin/gitea web
Restart=always
Environment=USER=gitea HOME=$DATA_DIR GITEA_WORK_DIR=$DATA_DIR

[Install]
WantedBy=multi-user.target
EOF

# ------------------------------------------------------------
# Enable + start service
# ------------------------------------------------------------
echo "Starting Gitea..."
sudo systemctl daemon-reload
sudo systemctl enable gitea
sudo systemctl start gitea

echo "=== GITEA INSTALL COMPLETE ==="
echo "Data directory: $DATA_DIR"
echo "Service: gitea"
echo "Web UI: http://<your-pi-ip>:3000"
```
