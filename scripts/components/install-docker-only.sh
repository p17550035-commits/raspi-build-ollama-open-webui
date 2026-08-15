```bash
#!/bin/bash
# ============================================================
# COMPONENT INSTALLER — DOCKER ONLY
# ============================================================
# This script:
#   - Installs ONLY Docker Engine
#   - Installs Docker Compose plugin
#   - Enables + starts Docker service
#   - Creates Docker directory on external drive (if mounted)
#
# Safe to run standalone OR inside any master installer.
# ============================================================

MOUNT_POINT="/mnt/pidrive"
DOCKER_DIR="$MOUNT_POINT/stack/docker"

echo "=== DOCKER INSTALLER STARTED ==="

# ------------------------------------------------------------
# Install Docker
# ------------------------------------------------------------
echo "Installing Docker Engine..."
curl -fsSL https://get.docker.com | sh

echo "Enabling Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

# ------------------------------------------------------------
# Install Docker Compose plugin
# ------------------------------------------------------------
echo "Installing Docker Compose plugin..."
sudo apt-get update
sudo apt-get install -y docker-compose-plugin

# ------------------------------------------------------------
# Prepare external drive directory
# ------------------------------------------------------------
if [ -d "$MOUNT_POINT" ]; then
    echo "Creating Docker directory at $DOCKER_DIR..."
    mkdir -p "$DOCKER_DIR"

    echo "Setting Docker data-root to external drive..."

    sudo mkdir -p /etc/docker

    sudo bash -c "cat >/etc/docker/daemon.json" <<EOF
{
  "data-root": "$DOCKER_DIR"
}
EOF

    echo "Restarting Docker with new data-root..."
    sudo systemctl restart docker
else
    echo "External drive not mounted. Using default Docker location."
fi

echo "=== DOCKER INSTALL COMPLETE ==="
echo "Docker data directory: ${DOCKER_DIR} (if mounted)"
echo "Service: docker"
```
