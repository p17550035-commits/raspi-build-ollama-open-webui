```bash
#!/bin/bash
# ============================================================
# COMPONENT INSTALLER — OPENWEBUI ONLY
# ============================================================
# This script:
#   - Installs ONLY the OpenWebUI backend + UI
#   - Creates OpenWebUI directory on external drive (if mounted)
#   - Downloads your Pi Edition tarball
#   - Extracts it cleanly
#   - Does NOT install Ollama
#   - Does NOT install Qwen
#   - Does NOT install Docker
#
# Safe to run standalone OR inside any master installer.
# ============================================================

MOUNT_POINT="/mnt/pidrive"
OWUI_DIR="$MOUNT_POINT/stack/openwebui"

TARBALL_URL="https://raw.githubusercontent.com/p17550035-commits/raspi-build-ollama-open-webui/main/openwebui-pi-edition.tar.gz"

echo "=== OPENWEBUI INSTALLER STARTED ==="

# ------------------------------------------------------------
# Prepare external drive directory
# ------------------------------------------------------------
if [ ! -d "$MOUNT_POINT" ]; then
    echo "External drive not mounted. Using default OpenWebUI location."
    OWUI_DIR="/opt/openwebui"
fi

echo "Creating OpenWebUI directory at $OWUI_DIR..."
mkdir -p "$OWUI_DIR"

# ------------------------------------------------------------
# Download tarball
# ------------------------------------------------------------
echo "Downloading OpenWebUI Pi Edition..."
wget -O /tmp/openwebui.tar.gz "$TARBALL_URL"

# ------------------------------------------------------------
# Extract tarball
# ------------------------------------------------------------
echo "Extracting OpenWebUI..."
tar -xzf /tmp/openwebui.tar.gz -C "$OWUI_DIR"

# ------------------------------------------------------------
# Final message
# ------------------------------------------------------------
echo "=== OPENWEBUI INSTALL COMPLETE ==="
echo "Installed at: $OWUI_DIR"
echo "This installer ONLY installs OpenWebUI."
echo "Add Ollama/Qwen/Docker manually if needed."
```
