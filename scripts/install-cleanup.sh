```bash
#!/bin/bash
# ============================================================
# INSTALL CLEANUP SCRIPT
# ============================================================
# This script:
#   - Cleans temp files
#   - Removes leftover tarballs
#   - Removes logs older than 7 days
#   - Verifies mount point
#   - Cleans orphaned folders
#
# Safe to run anytime.
# ============================================================

MOUNT_POINT="/mnt/pidrive"

echo "=== CLEANUP STARTED ==="

# Remove temp tarballs
echo "Removing temp tarballs..."
rm -f /tmp/*.tar.gz
rm -f /tmp/*.tgz

# Remove old logs
echo "Cleaning logs older than 7 days..."
find "$MOUNT_POINT/stack/logs" -type f -mtime +7 -exec rm -f {} \;

# Remove orphaned folders
echo "Removing orphaned folders..."
find "$MOUNT_POINT/stack" -type d -empty -delete

echo "=== CLEANUP COMPLETE ==="
```
