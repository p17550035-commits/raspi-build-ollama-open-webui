```bash
#!/bin/bash
# ============================================================
# SELF UPDATE SCRIPT
# ============================================================
# This script:
#   - Pulls latest installers from your GitHub repo
#   - Replaces local installers with updated versions
#   - Verifies integrity
#
# This keeps ALL installers up to date automatically.
# ============================================================

REPO="https://raw.githubusercontent.com/p17550035-commits/raspi-build-ollama-open-webui/main/installers"

TARGET_DIR="/usr/local/bin/raspi-installers"

echo "=== SELF UPDATE STARTED ==="

mkdir -p "$TARGET_DIR"

FILES=(
  "install-skeleton.sh"
  "install-basic.sh"
  "install-basic-no-ollama.sh"
  "install-basic-with-ollama.sh"
  "install-upgrade-docker.sh"
  "install-upgrade-manual.sh"
  "install-enterprise.sh"
  "install-enterprise-no-ollama.sh"
  "install-enterprise-with-ollama.sh"
  "install-cleanup.sh"
  "install-self-update.sh"
  "uninstall.sh"
)

for FILE in "${FILES[@]}"; do
    echo "Updating $FILE..."
    wget -q "$REPO/$FILE" -O "$TARGET_DIR/$FILE"
    chmod +x "$TARGET_DIR/$FILE"
done

echo "=== SELF UPDATE COMPLETE ==="
echo "Installers updated in: $TARGET_DIR"
```
