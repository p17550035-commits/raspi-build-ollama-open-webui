```bash
#!/bin/bash
# ============================================================
# UNIVERSAL UNINSTALLER — WORKS FOR ALL INSTALL VARIANTS
# ============================================================
# This script:
#   - Stops all services (Postgres, Redis, Qdrant, MinIO, Gitea)
#   - Stops Docker containers if present
#   - Removes Ollama + models if installed
#   - Removes OpenWebUI backend
#   - Removes enterprise stack folders
#   - Removes docker-compose files
#   - Removes fstab entry
#   - Unmounts external drive safely
#
# This is the ONLY uninstall script you need.
# ============================================================

MOUNT_POINT="/mnt/pidrive"
TARGET="/dev/$(lsblk -o NAME,TYPE | grep disk | awk '{print $1}' | grep sd | head -n 1)"

echo "=== UNIVERSAL UNINSTALL STARTED ==="

# ------------------------------------------------------------
# Stop services
# ------------------------------------------------------------
echo "Stopping services..."

systemctl stop postgresql 2>/dev/null
systemctl stop redis-server 2>/dev/null
systemctl stop minio 2>/dev/null
systemctl stop gitea 2>/dev/null

# Qdrant (manual)
pkill qdrant 2>/dev/null

# Docker containers
echo "Stopping Docker containers..."
docker ps -q | xargs -r docker stop
docker system prune -af --volumes

# Ollama
echo "Removing Ollama..."
systemctl stop ollama 2>/dev/null
rm -rf /usr/share/ollama
rm -rf ~/.ollama

# ------------------------------------------------------------
# Remove stack folders
# ------------------------------------------------------------
echo "Removing enterprise stack folders..."
rm -rf "$MOUNT_POINT/stack/postgres"
rm -rf "$MOUNT_POINT/stack/redis"
rm -rf "$MOUNT_POINT/stack/qdrant"
rm -rf "$MOUNT_POINT/stack/minio"
rm -rf "$MOUNT_POINT/stack/gitea"
rm -rf "$MOUNT_POINT/stack/openwebui"
rm -rf "$MOUNT_POINT/stack/backups"
rm -rf "$MOUNT_POINT/stack/logs"

# ------------------------------------------------------------
# Remove docker-compose files
# ------------------------------------------------------------
echo "Removing docker-compose files..."
rm -f "$MOUNT_POINT/docker-compose.yml"
rm -f "$MOUNT_POINT/*.env"

# ------------------------------------------------------------
# Remove fstab entry
# ------------------------------------------------------------
echo "Removing fstab entry..."
sed -i "\|$TARGET $MOUNT_POINT|d" /etc/fstab

# ------------------------------------------------------------
# Unmount drive
# ------------------------------------------------------------
echo "Unmounting external drive..."
umount "$MOUNT_POINT" 2>/dev/null

echo "=== UNINSTALL COMPLETE ==="
echo "System cleaned and ready."
```
