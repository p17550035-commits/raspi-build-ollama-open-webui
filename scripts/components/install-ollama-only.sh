```bash
#!/bin/bash
# ============================================================
# COMPONENT INSTALLER — OLLAMA ONLY
# ============================================================
# This script:
#   - Installs ONLY Ollama (ARM build)
#   - Creates Ollama model/data directory on external drive (if mounted)
#   - Moves Ollama data safely
#   - Restarts Ollama service
#
# Safe to run standalone OR inside any master installer.
# ============================================================

MOUNT_POINT="/mnt/pidrive"
OLLAMA_DIR="$MOUNT_POINT/stack/ollama"

echo "=== OLLAMA INSTALLER STARTED ==="

# ------------------------------------------------------------
# Install Ollama
# ------------------------------------------------------------
echo "Installing Ollama..."
curl -fsSL https://ollama.com/install.sh | sh

# Stop Ollama before moving data
echo "Stopping Ollama..."
systemctl stop ollama 2>/dev/null

# ------------------------------------------------------------
# Prepare external drive directory
# ------------------------------------------------------------
if [ ! -d "$MOUNT_POINT" ]; then
    echo "External drive not mounted. Using default Ollama location."
    DATA_DIR="/usr/share/ollama"
else
    echo "Creating Ollama directory at $OLLAMA_DIR..."
    mkdir -p "$OLLAMA_DIR"
    DATA_DIR="$OLLAMA_DIR"

    echo "Moving Ollama data to external drive..."
    mv /usr/share/ollama/* "$OLLAMA_DIR/" 2>/dev/null
fi

# ------------------------------------------------------------
# Update Ollama config
# ------------------------------------------------------------
echo "Updating Ollama config..."

mkdir -p /etc/ollama

cat >/etc/ollama/config.toml <<EOF
models = "$DATA_DIR"
EOF

# ------------------------------------------------------------
# Restart Ollama
# ------------------------------------------------------------
echo "Restarting Ollama..."
systemctl start ollama 2>/dev/null

echo "=== OLLAMA INSTALL COMPLETE ==="
echo "Model directory: $DATA_DIR"
echo "Service: ollama"
```
