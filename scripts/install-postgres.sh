```bash
#!/bin/bash
# ============================================================
# COMPONENT INSTALLER — POSTGRES
# ============================================================
# This script:
#   - Installs Postgres + contrib
#   - Creates data directory on external drive (if mounted)
#   - Moves Postgres data to external drive safely
#   - Updates Postgres config to point to new data directory
#   - Restarts Postgres
#
# Safe to run standalone OR inside any master installer.
# ============================================================

MOUNT_POINT="/mnt/pidrive"
PG_DIR="$MOUNT_POINT/stack/postgres"

echo "=== POSTGRES INSTALLER STARTED ==="

# Install Postgres
echo "Installing Postgres..."
sudo apt-get update
sudo apt-get install -y postgresql postgresql-contrib

# Ensure mount exists
if [ ! -d "$MOUNT_POINT" ]; then
    echo "External drive not mounted. Using default Postgres location."
    exit 0
fi

# Create directory
echo "Creating Postgres directory at $PG_DIR..."
mkdir -p "$PG_DIR"

# Stop Postgres
echo "Stopping Postgres..."
sudo systemctl stop postgresql

# Move existing data
echo "Moving Postgres data to external drive..."
sudo mv /var/lib/postgresql "$PG_DIR/"

# Update config
echo "Updating Postgres config..."
sudo sed -i "s|/var/lib/postgresql|$PG_DIR/postgresql|g" /etc/postgresql/*/main/postgresql.conf

# Restart Postgres
echo "Restarting Postgres..."
sudo systemctl start postgresql

echo "=== POSTGRES INSTALL COMPLETE ==="
echo "Data directory: $PG_DIR/postgresql"
```
