```bash
#!/bin/bash
# ============================================================
# COMPONENT INSTALLER — MINIO (S3 STORAGE)
# ============================================================
# This script:
#   - Installs MinIO server (ARM64 binary)
#   - Creates MinIO data directory on external drive (if mounted)
#   - Creates a MinIO systemd service
#   - Starts MinIO automatically
#
# Safe to run standalone OR inside any master installer.
# ============================================================

MOUNT_POINT="/mnt/pidrive"
MINIO_DIR="$MOUNT_POINT/stack/minio"

echo "=== MINIO INSTALLER STARTED ==="

# ------------------------------------------------------------
# Install MinIO binary
# ------------------------------------------------------------
echo "Downloading MinIO..."
wget -q https://dl.min.io/server/minio/release/linux-arm64/minio -O /usr/local/bin/minio
chmod +x /usr/local/bin/minio

# ------------------------------------------------------------
# Prepare external drive directory
# ------------------------------------------------------------
if [ ! -d "$MOUNT_POINT" ]; then
    echo "External drive not mounted. Using default MinIO location."
    DATA_DIR="/var/minio"
else
    echo "Creating MinIO directory at $MINIO_DIR..."
    mkdir -p "$MINIO_DIR"
    DATA_DIR="$MINIO_DIR"
fi

# ------------------------------------------------------------
# Create user for MinIO
# ------------------------------------------------------------
echo "Creating MinIO user..."
sudo useradd -r minio-user 2>/dev/null
sudo chown -R minio-user:minio-user "$DATA_DIR"

# ------------------------------------------------------------
# Create systemd service
# ------------------------------------------------------------
echo "Creating MinIO systemd service..."

sudo bash -c "cat >/etc/systemd/system/minio.service" <<EOF
[Unit]
Description=MinIO Object Storage
After=network.target

[Service]
User=minio-user
Group=minio-user
ExecStart=/usr/local/bin/minio server $DATA_DIR --console-address :9001
Restart=always
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF

# ------------------------------------------------------------
# Enable + start service
# ------------------------------------------------------------
echo "Starting MinIO..."
sudo systemctl daemon-reload
sudo systemctl enable minio
sudo systemctl start minio

echo "=== MINIO INSTALL COMPLETE ==="
echo "Data directory: $DATA_DIR"
echo "Service: minio"
echo "API Port: 9000"
echo "Console Port: 9001"
```
