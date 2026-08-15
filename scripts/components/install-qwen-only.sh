```bash
#!/bin/bash
# ============================================================
# COMPONENT INSTALLER — QWEN ONLY (MODEL INSTALLER)
# ============================================================
# This script:
#   - Installs ONLY the Qwen model(s)
#   - Requires Ollama to already be installed
#   - Creates model directory on external drive (if mounted)
#   - Moves Qwen model safely
#
# Safe to run standalone OR inside any master installer.
# ============================================================

MOUNT_POINT="/mnt/pidrive"
OLLAMA_DIR="$MOUNT_POINT/stack/ollama"
MODEL="qwen2.5-coder:7b"

echo "=== QWEN MODEL INSTALLER STARTED ==="

# ------------------------------------------------------------
# Check if Ollama is installed
# ------------------------------------------------------------
if ! command -v ollama >/dev/null 2>&1; then
    echo "ERROR: Ollama is not installed."
    echo "Install Ollama first using: install-ollama-only.sh"
    exit 1
fi

# ------------------------------------------------------------
# Pull Qwen model
# ------------------------------------------------------------
echo "Pulling Qwen model: $MODEL ..."
ollama pull "$MODEL"

# ------------------------------------------------------------
# Prepare external drive directory
# ------------------------------------------------------------
if [ ! -d "$MOUNT_POINT" ]; then
    echo "External drive not mounted. Using default Ollama model location."
    DATA_DIR="/usr/share/ollama/models"
else
    echo "Creating Ollama model directory at $OLLAMA_DIR..."
    mkdir -p "$OLLAMA_DIR/models"
    DATA_DIR="$OLLAMA_DIR/models"
fi

# ------------------------------------------------------------
# Move Qwen model to external drive (if applicable)
# ------------------------------------------------------------
if [ "$DATA_DIR" != "/usr/share/ollama/models" ]; then
    echo "Moving Qwen model to external drive..."
    mv /usr/share/ollama/models/* "$DATA_DIR/" 2>/dev/null
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
systemctl restart ollama 2>/dev/null

echo "=== QWEN MODEL INSTALL COMPLETE ==="
echo "Model directory: $DATA_DIR"
echo "Installed model: $MODEL"
```
