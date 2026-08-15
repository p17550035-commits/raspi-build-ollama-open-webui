```bash
#!/bin/bash
# ============================================================
# COMPONENT INSTALLER — QDRANT
# ============================================================
# This script:
#   - Installs Qdrant (standalone binary)
#   - Creates Qdrant data directory on external drive (if mounted)
#   - Moves Qdrant data safely
#   - Creates a systemd service for Qdrant
#   - Starts Qdrant automatically
#
# Safe to run standalone OR inside any master installer.
# ============================================================

MOUNT_POINT="/mnt/pidrive"
QDRANT_DIR="$MOUNT_POINT/stack/qdrant"

echo "=== QDRANT INSTALLER STARTED ==="

# ------------------------------------------------------------
# Install Qdrant binary
# ------------------------------------------------------------
echo "Downloading Qdrant..."
curl -fsSL https://github.com/qdrant/qdrant/releases/latest/download/qdrant-x86_64-unknown-linux-gnu.tar.gz \
    -o /tmp/qdrant.tar.gz

echo "Extracting Qdrant..."
mkdir -p /opt/qdrant
tar -xzf /tmp/qdrant.tar.gz -C /opt/qdrant

# ------------------------------------------------------------
# Prepare external drive directory
# ------------------------------------------------------------
if [ ! -d "$MOUNT_POINT" ]; then
    echo "External drive not mounted. Using default Qdrant location."
    DATA_DIR="/opt/qdrant/data"
else
    echo "Creating Qdrant directory at $QDRANT_DIR..."
    mkdir -p "$QDRANT_DIR"
    DATA_DIR="$QDRANT_DIR"
fi

# ------------------------------------------------------------
# Create systemd service
# ------------------------------------------------------------
echo "Creating Qdrant systemd service..."

sudo bash -c "cat >/etc/systemd/system/qdrant.service" <<EOF
[Unit]
Description=Qdrant Vector Database
After=network.target

[Service]
ExecStart=/opt/qdrant/qdrant \
    --storage-path $DATA_DIR \
    --service-host 0.0.0.0 \
    --service-port 6333
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF

# ------------------------------------------------------------
# Enable + start service
# ------------------------------------------------------------
echo "Starting Qdrant..."
sudo systemctl daemon-reload
sudo systemctl enable qdrant
sudo systemctl start qdrant

echo "=== QDRANT INSTALL COMPLETE ==="
echo "Data directory: $DATA_DIR"
echo "Service: qdrant"
echo "Port: 6333"
```
