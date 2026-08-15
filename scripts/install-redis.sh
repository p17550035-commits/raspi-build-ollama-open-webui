```bash
#!/bin/bash
# ============================================================
# COMPONENT INSTALLER — REDIS
# ============================================================
# This script:
#   - Installs Redis server
#   - Creates Redis data directory on external drive (if mounted)
#   - Moves Redis data safely
#   - Updates Redis config to point to new data directory
#   - Restarts Redis
#
# Safe to run standalone OR inside any master installer.
# ============================================================

MOUNT_POINT="/mnt/pidrive"
REDIS_DIR="$MOUNT_POINT/stack/redis"

echo "=== REDIS INSTALLER STARTED ==="

# Install Redis
echo "Installing Redis..."
sudo apt-get update
sudo apt-get install -y redis-server

# Ensure mount exists
if [ ! -d "$MOUNT_POINT" ]; then
    echo "External drive not mounted. Using default Redis location."
    exit 0
fi

# Create directory
echo "Creating Redis directory at $REDIS_DIR..."
mkdir -p "$REDIS_DIR"

# Stop Redis
echo "Stopping Redis..."
sudo systemctl stop redis-server

# Move existing data
echo "Moving Redis data to external drive..."
sudo mv /var/lib/redis "$REDIS_DIR/"

# Update config
echo "Updating Redis config..."
sudo sed -i "s|/var/lib/redis|$REDIS_DIR/redis|g" /etc/redis/redis.conf

# Restart Redis
echo "Restarting Redis..."
sudo systemctl start redis-server

echo "=== REDIS INSTALL COMPLETE ==="
echo "Data directory: $REDIS_DIR/redis"
```
