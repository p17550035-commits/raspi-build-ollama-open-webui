```bash
#!/bin/bash
# ============================================================
# MASTER INSTALLER SKELETON WITH DRIVE SAFETY
# ============================================================
# This script:
#  - Detects external drive
#  - Checks filesystem type
#  - Warns before formatting
#  - Prevents accidental data loss
#  - Allows skip-format mode
#  - Creates required folders
#  - Prepares mount point
#  - Provides safe foundation for all future installers
#
# NOTE:
#  DO NOT USE ON A DRIVE WITH IMPORTANT DATA.
#  FORMATTING WILL ERASE EVERYTHING.
# ============================================================

RED="\033[1;31m"
YELLOW="\033[1;33m"
GREEN="\033[1;32m"
NC="\033[0m"

echo -e "${YELLOW}"
echo "============================================================"
echo "        MASTER INSTALLER — EXTERNAL DRIVE SAFETY"
echo "============================================================"
echo -e "${NC}"

# ------------------------------------------------------------
# STEP 1 — Detect external drive automatically
# ------------------------------------------------------------
echo -e "${GREEN}Detecting external drives...${NC}"

# Find all /dev/sdX devices (USB drives)
DRIVES=$(lsblk -o NAME,TYPE | grep "disk" | awk '{print $1}' | grep "sd")

if [ -z "$DRIVES" ]; then
    echo -e "${RED}ERROR: No external drives detected (no /dev/sdX found).${NC}"
    echo "Plug in your external drive and run this installer again."
    exit 1
fi

echo "Detected drive(s):"
echo "$DRIVES"
echo ""

# If multiple drives exist, ask user to choose
if [ $(echo "$DRIVES" | wc -l) -gt 1 ]; then
    echo -e "${YELLOW}Multiple external drives detected.${NC}"
    echo "Enter the drive you want to use (example: sda, sdb):"
    read -r DRIVE
else
    DRIVE="$DRIVES"
fi

TARGET="/dev/$DRIVE"

echo -e "${GREEN}Selected drive: $TARGET${NC}"
echo ""

# ------------------------------------------------------------
# STEP 2 — Check if drive is mounted
# ------------------------------------------------------------
MOUNTED=$(lsblk -o NAME,MOUNTPOINT | grep "$DRIVE" | awk '{print $2}' | grep "/")

if [ -n "$MOUNTED" ]; then
    echo -e "${YELLOW}Drive is already mounted at: $MOUNTED${NC}"
    echo "Installer will use this mount point."
    MOUNT_POINT="$MOUNTED"
else
    MOUNT_POINT="/mnt/pidrive"
    echo -e "${GREEN}Drive is not mounted. Will mount at: $MOUNT_POINT${NC}"
fi

# ------------------------------------------------------------
# STEP 3 — Detect filesystem type
# ------------------------------------------------------------
FS_TYPE=$(blkid "$TARGET" | awk -F 'TYPE="' '{print $2}' | awk -F '"' '{print $1}')

if [ -z "$FS_TYPE" ]; then
    FS_TYPE="UNFORMATTED"
fi

echo -e "${GREEN}Filesystem detected: $FS_TYPE${NC}"
echo ""

# ------------------------------------------------------------
# STEP 4 — If not ext4, warn user
# ------------------------------------------------------------
if [ "$FS_TYPE" != "ext4" ]; then
    echo -e "${RED}============================================================"
    echo "WARNING: The drive is NOT formatted as ext4."
    echo "Formatting will ERASE ALL DATA on $TARGET."
    echo "============================================================${NC}"
    echo ""
    echo "Choose an option:"
    echo "  1) Format drive as ext4 (DESTROYS ALL DATA)"
    echo "  2) Skip formatting and continue (use existing filesystem)"
    echo "  3) Abort installation"
    echo ""
    read -r CHOICE

    case "$CHOICE" in
        1)
            echo -e "${RED}FINAL WARNING: Formatting will erase EVERYTHING.${NC}"
            echo "Type EXACTLY: FORMAT"
            read -r CONFIRM
            if [ "$CONFIRM" != "FORMAT" ]; then
                echo -e "${RED}Format aborted.${NC}"
                exit 1
            fi

            echo -e "${GREEN}Formatting $TARGET as ext4...${NC}"
            sudo mkfs.ext4 "$TARGET"
            ;;
        2)
            echo -e "${YELLOW}Skipping formatting. Using existing filesystem.${NC}"
            ;;
        3)
            echo -e "${RED}Installation aborted.${NC}"
            exit 1
            ;;
        *)
            echo -e "${RED}Invalid choice. Aborting.${NC}"
            exit 1
            ;;
    esac
fi

# ------------------------------------------------------------
# STEP 5 — Mount drive if needed
# ------------------------------------------------------------
if [ -z "$MOUNTED" ]; then
    echo -e "${GREEN}Mounting drive at $MOUNT_POINT...${NC}"
    sudo mkdir -p "$MOUNT_POINT"
    sudo mount "$TARGET" "$MOUNT_POINT"

    # Add to fstab for persistence
    echo "$TARGET $MOUNT_POINT ext4 defaults 0 0" | sudo tee -a /etc/fstab
fi

echo -e "${GREEN}Drive mounted successfully at: $MOUNT_POINT${NC}"
echo ""

# ------------------------------------------------------------
# STEP 6 — Create required folder structure
# ------------------------------------------------------------
echo -e "${GREEN}Creating enterprise stack directories...${NC}"

mkdir -p "$MOUNT_POINT/stack/postgres"
mkdir -p "$MOUNT_POINT/stack/redis"
mkdir -p "$MOUNT_POINT/stack/qdrant"
mkdir -p "$MOUNT_POINT/stack/minio"
mkdir -p "$MOUNT_POINT/stack/gitea"
mkdir -p "$MOUNT_POINT/stack/openwebui"
mkdir -p "$MOUNT_POINT/stack/backups"
mkdir -p "$MOUNT_POINT/stack/logs"

echo -e "${GREEN}Directory structure created.${NC}"
echo ""

# ------------------------------------------------------------
# STEP 7 — Placeholder for future install logic
# ------------------------------------------------------------
echo -e "${YELLOW}============================================================"
echo "INSTALLER SKELETON COMPLETE"
echo "You can now insert:"
echo "  - Basic install logic"
echo "  - Docker upgrade logic"
echo "  - Enterprise stack logic"
echo "  - Ollama install logic"
echo "  - Qwen model pull logic"
echo "  - Tarball download/extract logic"
echo "============================================================${NC}"

echo -e "${GREEN}This skeleton is ready for extension.${NC}"
```
