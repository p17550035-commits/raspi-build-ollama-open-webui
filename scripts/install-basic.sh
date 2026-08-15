```bash
#!/bin/bash
# ============================================================
# MASTER BASIC INSTALLER (WITH DRIVE SAFETY)
# ============================================================
# Includes:
#  - External drive detection
#  - Safe formatting logic
#  - Folder creation
#  - Pull + extract UI/backend tarball
#  - Basic environment setup
#
# NOTE:
#  This version DOES NOT install Ollama.
#  This version DOES NOT install Docker.
#  This version ONLY installs your UI/backend tarball.
# ============================================================

RED="\033[1;31m"
YELLOW="\033[1;33m"
GREEN="\033[1;32m"
NC="\033[0m"

echo -e "${YELLOW}"
echo "============================================================"
echo "        MASTER BASIC INSTALLER — DRIVE SAFE EDITION"
echo "============================================================"
echo -e "${NC}"

# ------------------------------------------------------------
# STEP 1 — Detect external drive automatically
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
    echo "Enter the drive to use (example: sda):"
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
    echo -e "${YELLOW}Drive already mounted at: $MOUNTED${NC}"
    MOUNT_POINT="$MOUNTED"
else
    MOUNT_POINT="/mnt/pidrive"
    echo -e "${GREEN}Will mount drive at: $MOUNT_POINT${NC}"
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
    echo "WARNING: Drive is NOT ext4."
    echo "Formatting will ERASE ALL DATA on $TARGET."
    echo "============================================================${NC}"
    echo ""
    echo "Choose:"
    echo "  1) Format drive (DESTROYS ALL DATA)"
    echo "  2) Skip formatting"
    echo "  3) Abort"
    read -r CHOICE

    case "$CHOICE" in
        1)
            echo -e "${RED}Type FORMAT to confirm:${NC}"
            read -r CONFIRM
            if [ "$CONFIRM" != "FORMAT" ]; then
                echo -e "${RED}Format aborted.${NC}"
                exit 1
            fi
            sudo mkfs.ext4 "$TARGET"
            ;;
        2)
            echo -e "${YELLOW}Skipping formatting.${NC}"
            ;;
        3)
            echo -e "${RED}Aborted.${NC}"
            exit 1
            ;;
        *)
            echo -e "${RED}Invalid choice.${NC}"
            exit 1
            ;;
    esac
fi

# ------------------------------------------------------------
# STEP 5 — Mount drive if needed
# ------------------------------------------------------------
if [ -z "$MOUNTED" ]; then
    sudo mkdir -p "$MOUNT_POINT"
    sudo mount "$TARGET" "$MOUNT_POINT"
    echo "$TARGET $MOUNT_POINT ext4 defaults 0 0" | sudo tee -a /etc/fstab
fi

echo -e "${GREEN}Drive mounted at: $MOUNT_POINT${NC}"
echo ""

# ------------------------------------------------------------
# STEP 6 — Create folder structure
# ------------------------------------------------------------
echo -e "${GREEN}Creating basic stack directories...${NC}"

mkdir -p "$MOUNT_POINT/stack/openwebui"
mkdir -p "$MOUNT_POINT/stack/logs"
mkdir -p "$MOUNT_POINT/stack/backups"

echo -e "${GREEN}Directory structure created.${NC}"
echo ""

# ------------------------------------------------------------
# STEP 7 — Pull + extract UI/backend tarball
# ------------------------------------------------------------
echo -e "${GREEN}Downloading UI/backend tarball...${NC}"

# Replace this URL with your actual tarball release URL
TARBALL_URL="https://raw.githubusercontent.com/p17550035-commits/raspi-build-ollama-open-webui/main/openwebui-pi-edition.tar.gz"

wget -O /tmp/openwebui.tar.gz "$TARBALL_URL"

echo -e "${GREEN}Extracting tarball...${NC}"

tar -xzf /tmp/openwebui.tar.gz -C "$MOUNT_POINT/stack/openwebui"

echo -e "${GREEN}UI/backend installed successfully.${NC}"
echo ""

# ------------------------------------------------------------
# STEP 8 — Final message
# ------------------------------------------------------------
echo -e "${YELLOW}============================================================"
echo " BASIC INSTALL COMPLETE"
echo "============================================================${NC}"

echo -e "${GREEN}Your UI/backend is installed at:${NC}"
echo "$MOUNT_POINT/stack/openwebui"

echo -e "${GREEN}You can now run your Pi Edition manually or integrate it later with Docker/Enterprise installers.${NC}"
```
