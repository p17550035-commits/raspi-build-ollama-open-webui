```bash
#!/bin/bash
# ============================================================
# MASTER ENTERPRISE INSTALLER — FULL STACK (NO OLLAMA)
# ============================================================
# This installer:
#   - Uses the drive‑safe skeleton
#   - Prepares external drive safely
#   - Creates full enterprise folder structure
#   - Installs ALL core services (manual mode):
#         • Postgres
#         • Redis
#         • Qdrant
#         • MinIO
#         • Gitea
#   - Prepares OpenWebUI backend directory
#   - Prepares system for future enterprise tarball
#
# NOTE:
#   This version DOES NOT install Ollama.
#   This version DOES NOT install Qwen.
#   This version DOES NOT install Docker.
#   This version DOES NOT install UI/backend tarball.
#
#   It ONLY installs the enterprise service stack manually
#   and prepares the Pi + external drive for future upgrades.
# ============================================================

RED="\033[1;31m"
YELLOW="\033[1;33m"
GREEN="\033[1;32m"
NC="\033[0m"

echo -e "${YELLOW}"
echo "============================================================"
echo "   MASTER ENTERPRISE INSTALLER — NO OLLAMA (SAFE MODE)"
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
# STEP 6 — Create full enterprise folder structure
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
# STEP 7 — Install enterprise services manually
# ------------------------------------------------------------
echo -e "${GREEN}Installing enterprise services...${NC}"

sudo apt-get update

# Postgres
echo -e "${GREEN}Installing Postgres...${NC}"
sudo apt-get install -y postgresql postgresql-contrib

# Redis
echo -e "${GREEN}Installing Redis...${NC}"
sudo apt-get install -y redis-server

# Qdrant
echo -e "${GREEN}Installing Qdrant...${NC}"
curl -fsSL https://github.com/qdrant/qdrant/releases/latest/download/qdrant-x86_64-unknown-linux-gnu.tar.gz \
    -o /tmp/qdrant.tar.gz
mkdir -p /opt/qdrant
tar -xzf /tmp/qdrant.tar.gz -C /opt/qdrant

# MinIO
echo -e "${GREEN}Installing MinIO...${NC}"
wget -q https://dl.min.io/server/minio/release/linux-arm64/minio -O /usr/local/bin/minio
chmod +x /usr/local/bin/minio

# Gitea
echo -e "${GREEN}Installing Gitea...${NC}"
wget -q https://dl.gitea.com/gitea/1.22.0/gitea-1.22.0-linux-arm64 -O /usr/local/bin/gitea
chmod +x /usr/local/bin/gitea

echo -e "${GREEN}Enterprise services installed.${NC}"
echo ""

# ------------------------------------------------------------
# STEP 8 — Placeholder for future enterprise tarball
# ------------------------------------------------------------
echo -e "${YELLOW}============================================================"
echo "Enterprise environment prepared."
echo "============================================================${NC}"

echo -e "${GREEN}This installer is ready for your future ENTERPRISE tarball."
echo "When you create your enterprise tarball later,"
echo "you will add the download + extract logic here.${NC}"

# ------------------------------------------------------------
# STEP 9 — Final message
# ------------------------------------------------------------
echo -e "${YELLOW}============================================================"
echo " ENTERPRISE INSTALLER (NO OLLAMA) COMPLETE"
echo "============================================================${NC}"

echo -e "${GREEN}Your enterprise environment is ready at:${NC}"
echo "$MOUNT_POINT/stack/"
```
