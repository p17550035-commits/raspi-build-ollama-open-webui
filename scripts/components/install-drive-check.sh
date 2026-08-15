```bash
#!/bin/bash
# ============================================================
# COMPONENT INSTALLER — DRIVE CHECK ONLY
# ============================================================
# This script:
#   - Detects external drives (sdX)
#   - Shows filesystem type
#   - Shows mount status
#   - Offers to mount if unmounted
#   - Warns if not ext4
#   - Does NOT install anything
#
# Safe to run standalone OR inside any master installer.
# ============================================================

RED="\033[1;31m"
YELLOW="\033[1;33m"
GREEN="\033[1;32m"
NC="\033[0m"

echo -e "${YELLOW}"
echo "============================================================"
echo "                DRIVE CHECK UTILITY"
echo "============================================================"
echo -e "${NC}"

# ------------------------------------------------------------
# Detect external drives
# ------------------------------------------------------------
echo -e "${GREEN}Detecting external drives...${NC}"

DRIVES=$(lsblk -o NAME,TYPE | grep "disk" | awk '{print $1}' | grep "sd")

if [ -z "$DRIVES" ]; then
    echo -e "${RED}ERROR: No external drives detected.${NC}"
    exit 1
fi

echo "Detected drive(s):"
echo "$DRIVES"
echo ""

if [ $(echo "$DRIVES" | wc -l) -gt 1 ]; then
    echo -e "${YELLOW}Multiple drives detected.${NC}"
    echo "Enter the drive to inspect (example: sda):"
    read -r DRIVE
else
    DRIVE="$DRIVES"
fi

TARGET="/dev/$DRIVE"

echo -e "${GREEN}Selected drive: $TARGET${NC}"
echo ""

# ------------------------------------------------------------
# Check mount status
# ------------------------------------------------------------
MOUNTED=$(lsblk -o NAME,MOUNTPOINT | grep "$DRIVE" | awk '{print $2}' | grep "/")

if [ -n "$MOUNTED" ]; then
    echo -e "${GREEN}Drive is mounted at: $MOUNTED${NC}"
else
    echo -e "${YELLOW}Drive is NOT mounted.${NC}"
fi

# ------------------------------------------------------------
# Detect filesystem type
# ------------------------------------------------------------
FS_TYPE=$(blkid "$TARGET" | awk -F 'TYPE="' '{print $2}' | awk -F '"' '{print $1}')

if [ -z "$FS_TYPE" ]; then
    FS_TYPE="UNFORMATTED"
fi

echo -e "${GREEN}Filesystem detected: $FS_TYPE${NC}"
echo ""

# ------------------------------------------------------------
# Warn if not ext4
# ------------------------------------------------------------
if [ "$FS_TYPE" != "ext4" ]; then
    echo -e "${RED}WARNING: Drive is NOT ext4.${NC}"
    echo "Formatting to ext4 is recommended for all installers."
fi

# ------------------------------------------------------------
# Offer to mount if unmounted
# ------------------------------------------------------------
if [ -z "$MOUNTED" ]; then
    echo ""
    echo "Mount drive now?"
    echo "  1) Yes"
    echo "  2) No"
    read -r CHOICE

    if [ "$CHOICE" == "1" ]; then
        MOUNT_POINT="/mnt/pidrive"
        echo -e "${GREEN}Mounting drive at $MOUNT_POINT...${NC}"
        sudo mkdir -p "$MOUNT_POINT"
        sudo mount "$TARGET" "$MOUNT_POINT"
        echo "$TARGET $MOUNT_POINT ext4 defaults 0 0" | sudo tee -a /etc/fstab
        echo -e "${GREEN}Drive mounted successfully.${NC}"
    else
        echo -e "${YELLOW}Skipping mount.${NC}"
    fi
fi

echo ""
echo -e "${GREEN}=== DRIVE CHECK COMPLETE ===${NC}"
echo "Drive: $TARGET"
echo "Filesystem: $FS_TYPE"
echo "Mount: ${MOUNTED:-Not mounted}"
```
