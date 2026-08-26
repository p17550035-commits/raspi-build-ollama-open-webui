#!/bin/bash
# ============================================================
# MASTER SMART INSTALLER — DOCKER STACK + HEALTH CHECK
# ============================================================
# This installer:
#   - Detects external drive OR falls back to local storage
#   - Runs health checks on folder structure (stack paths)
#   - Detects existing, missing, empty, and corrupted folders
#   - Prompts BEFORE creating, overwriting, or repairing folders
#   - Installs Docker + Docker Compose (if missing)
#   - Validates OpenWebUI ARM64 Docker tarball via SHA-256
#   - Loads Docker image from tarball (optional, user-confirmed)
#   - Runs OpenWebUI ARM64 container (optional, user-confirmed)
#
# SAFETY:
#   - No destructive action happens without explicit confirmation
#   - All prompts require deliberate input (no blind Enter)
#   - Existing data is NEVER overwritten silently
#
# NOTE:
#   - This script can act as installer, repair tool, and health check.
#   - Nothing is mandatory: user can skip installs or repairs.
# ============================================================

RED="\033[1;31m"
YELLOW="\033[1;33m"
GREEN="\033[1;32m"
CYAN="\033[1;36m"
NC="\033[0m"

EXPECTED_SHA="7f5666a0815ad1ce374ffa28d417538d2d484bb319c7767c7ea35913a5d3ae0e"
TARBALL_NAME="openwebui-arm64.tar"
RELEASE_URL="https://github.com/p17550035-commits/raspi-build-ollama-open-webui/releases/download/v1.1-arm64/openwebui-arm64.tar"

echo -e "${YELLOW}"
echo "============================================================"
echo "     MASTER SMART INSTALLER — DOCKER STACK (SAFE MODE)"
echo "============================================================"
echo -e "${NC}"

# ------------------------------------------------------------
# HELPER — Prompt with explicit input (no blind Enter)
# ------------------------------------------------------------
prompt_choice() {
    local prompt="$1"
    echo ""
    echo -e "${CYAN}${prompt}${NC}"
    read -r CHOICE
    echo "$CHOICE"
}

# ------------------------------------------------------------
# STEP 1 — Detect external drive OR local fallback
# ------------------------------------------------------------
echo -e "${GREEN}Detecting external drives...${NC}"

DRIVES=$(lsblk -o NAME,TYPE | grep "disk" | awk '{print $1}' | grep "sd")

MOUNT_POINT=""
TARGET=""
USE_LOCAL=0

if [ -z "$DRIVES" ]; then
    echo -e "${YELLOW}No external drives detected. Using local storage.${NC}"
    MOUNT_POINT="$HOME/pistack"
    USE_LOCAL=1
else
    echo "Detected drive(s):"
    echo "$DRIVES"
    echo ""

    if [ "$(echo "$DRIVES" | wc -l)" -gt 1 ]; then
        echo -e "${YELLOW}Multiple drives detected.${NC}"
        echo "Enter the drive to use (example: sda):"
        read -r DRIVE
    else
        DRIVE="$DRIVES"
    fi

    TARGET="/dev/$DRIVE"
    echo -e "${GREEN}Selected drive: $TARGET${NC}"

    # Detect filesystem type
    FS_TYPE=$(blkid "$TARGET" | awk -F 'TYPE="' '{print $2}' | awk -F '"' '{print $1}')
    if [ -z "$FS_TYPE" ]; then
        FS_TYPE="UNFORMATTED"
    fi

    echo -e "${GREEN}Filesystem detected: $FS_TYPE${NC}"
    echo ""

    # If not ext4, warn user and offer format/skip/abort
    if [ "$FS_TYPE" != "ext4" ]; then
        echo -e "${RED}============================================================"
        echo "WARNING: Drive is NOT ext4."
        echo "Formatting will ERASE ALL DATA on $TARGET."
        echo "============================================================${NC}"
        echo ""
        echo "Choose:"
        echo "  1) Format drive (DESTROYS ALL DATA)"
        echo "  2) Skip formatting (use as-is)"
        echo "  3) Abort"
        CHOICE=$(prompt_choice "Type your choice and press Enter:")

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

    # Determine mount point for external drive
    MOUNTED=$(lsblk -o NAME,MOUNTPOINT | grep "$DRIVE" | awk '{print $2}' | grep "/")
    if [ -n "$MOUNTED" ]; then
        echo -e "${YELLOW}Drive already mounted at: $MOUNTED${NC}"
        MOUNT_POINT="$MOUNTED"
    else
        MOUNT_POINT="/mnt/pidrive"
        echo -e "${GREEN}Will mount drive at: $MOUNT_POINT${NC}"
        sudo mkdir -p "$MOUNT_POINT"
        sudo mount "$TARGET" "$MOUNT_POINT"
        echo "$TARGET $MOUNT_POINT ext4 defaults 0 0" | sudo tee -a /etc/fstab
    fi
fi

if [ "$USE_LOCAL" -eq 1 ]; then
    mkdir -p "$MOUNT_POINT"
    echo -e "${GREEN}Using local storage at: $MOUNT_POINT${NC}"
else
    echo -e "${GREEN}Drive mounted at: $MOUNT_POINT${NC}"
fi

# ------------------------------------------------------------
# STEP 2 — Define stack folder paths
# ------------------------------------------------------------
STACK_ROOT="$MOUNT_POINT/stack"

FOLDERS=(
    "$STACK_ROOT/postgres"
    "$STACK_ROOT/redis"
    "$STACK_ROOT/qdrant"
    "$STACK_ROOT/minio"
    "$STACK_ROOT/gitea"
    "$STACK_ROOT/openwebui"
    "$STACK_ROOT/backups"
    "$STACK_ROOT/logs"
)

# ------------------------------------------------------------
# HELPER — Check folder status (exists/empty/corrupted/missing)
# ------------------------------------------------------------
check_folder_status() {
    local path="$1"

    if [ -d "$path" ]; then
        # Exists — check contents and permissions
        if [ -z "$(ls -A "$path" 2>/dev/null)" ]; then
            echo "EMPTY"
        else
            # Try listing to detect permission issues
            if ! ls "$path" >/dev/null 2>&1; then
                echo "CORRUPTED"
            else
                echo "EXISTS"
            fi
        fi
    else
        echo "MISSING"
    fi
}

# ------------------------------------------------------------
# STEP 3 — Scan and show ALL folder statuses
# ------------------------------------------------------------
echo -e "${GREEN}Scanning stack folder structure...${NC}"
echo ""
echo "Detected folder status:"
declare -A FOLDER_STATUS

for F in "${FOLDERS[@]}"; do
    STATUS=$(check_folder_status "$F")
    FOLDER_STATUS["$F"]="$STATUS"
    case "$STATUS" in
        EXISTS)
            echo "[EXISTS]   $F"
            ;;
        EMPTY)
            echo "[EMPTY]    $F"
            ;;
        CORRUPTED)
            echo "[CORRUPTED] $F"
            ;;
        MISSING)
            echo "[MISSING]  $F"
            ;;
    esac
done

echo ""

# ------------------------------------------------------------
# STEP 4 — Prompt ONE folder at a time for action
# ------------------------------------------------------------
echo -e "${YELLOW}Now processing each folder individually...${NC}"

for F in "${FOLDERS[@]}"; do
    STATUS="${FOLDER_STATUS[$F]}"
    echo ""
    echo -e "${CYAN}Folder: $F${NC}"
    echo "Status: $STATUS"

    case "$STATUS" in
        EXISTS)
            echo "Choose:"
            echo "  1) Keep existing folder"
            echo "  2) Overwrite folder (DESTROYS ALL DATA)"
            echo "  3) Repair folder (fix permissions, keep contents)"
            echo "  4) Skip this folder"
            echo "  5) Abort installer"
            CHOICE=$(prompt_choice "Type your choice and press Enter:")

            case "$CHOICE" in
                1)
                    echo -e "${GREEN}Keeping existing folder: $F${NC}"
                    ;;
                2)
                    echo -e "${RED}Overwriting folder: $F${NC}"
                    sudo rm -rf "$F"
                    sudo mkdir -p "$F"
                    ;;
                3)
                    echo -e "${YELLOW}Repairing folder: $F${NC}"
                    sudo chown -R "$USER":"$USER" "$F" || true
                    sudo chmod -R 755 "$F" || true
                    ;;
                4)
                    echo -e "${YELLOW}Skipping folder: $F${NC}"
                    ;;
                5)
                    echo -e "${RED}Installer aborted by user.${NC}"
                    exit 1
                    ;;
                *)
                    echo -e "${RED}Invalid choice. Skipping folder.${NC}"
                    ;;
            esac
            ;;
        EMPTY)
            echo "Choose:"
            echo "  1) Keep empty folder"
            echo "  2) Overwrite (recreate)"
            echo "  3) Skip"
            echo "  4) Abort installer"
            CHOICE=$(prompt_choice "Type your choice and press Enter:")

            case "$CHOICE" in
                1)
                    echo -e "${GREEN}Keeping empty folder: $F${NC}"
                    ;;
                2)
                    echo -e "${YELLOW}Recreating folder: $F${NC}"
                    sudo rm -rf "$F"
                    sudo mkdir -p "$F"
                    ;;
                3)
                    echo -e "${YELLOW}Skipping folder: $F${NC}"
                    ;;
                4)
                    echo -e "${RED}Installer aborted by user.${NC}"
                    exit 1
                    ;;
                *)
                    echo -e "${RED}Invalid choice. Skipping folder.${NC}"
                    ;;
            esac
            ;;
        CORRUPTED)
            echo "Folder appears corrupted — recommended: Repair"
            echo "Choose:"
            echo "  1) Repair folder (fix permissions, keep contents)"
            echo "  2) Overwrite folder (DESTROYS ALL DATA)"
            echo "  3) Skip"
            echo "  4) Abort installer"
            CHOICE=$(prompt_choice "Type your choice and press Enter:")

            case "$CHOICE" in
                1)
                    echo -e "${YELLOW}Repairing corrupted folder: $F${NC}"
                    sudo chown -R "$USER":"$USER" "$F" || true
                    sudo chmod -R 755 "$F" || true
                    ;;
                2)
                    echo -e "${RED}Overwriting corrupted folder: $F${NC}"
                    sudo rm -rf "$F"
                    sudo mkdir -p "$F"
                    ;;
                3)
                    echo -e "${YELLOW}Skipping corrupted folder: $F${NC}"
                    ;;
                4)
                    echo -e "${RED}Installer aborted by user.${NC}"
                    exit 1
                    ;;
                *)
                    echo -e "${RED}Invalid choice. Skipping folder.${NC}"
                    ;;
            esac
            ;;
        MISSING)
            echo "Choose:"
            echo "  1) Create folder"
            echo "  2) Skip"
            echo "  3) Abort installer"
            CHOICE=$(prompt_choice "Type your choice and press Enter:")

            case "$CHOICE" in
                1)
                    echo -e "${GREEN}Creating folder: $F${NC}"
                    sudo mkdir -p "$F"
                    ;;
                2)
                    echo -e "${YELLOW}Skipping missing folder: $F${NC}"
                    ;;
                3)
                    echo -e "${RED}Installer aborted by user.${NC}"
                    exit 1
                    ;;
                *)
                    echo -e "${RED}Invalid choice. Skipping folder.${NC}"
                    ;;
            esac
            ;;
    esac
done

echo ""
echo -e "${GREEN}Folder structure processing complete.${NC}"
echo ""

# ------------------------------------------------------------
# STEP 5 — Install Docker + Docker Compose (if needed)
# ------------------------------------------------------------
echo -e "${GREEN}Checking Docker installation...${NC}"

if ! command -v docker >/dev/null 2>&1; then
    echo -e "${YELLOW}Docker not found. Install now?${NC}"
    echo "  1) Yes"
    echo "  2) No (skip)"
    CHOICE=$(prompt_choice "Type your choice and press Enter:")

    if [ "$CHOICE" = "1" ]; then
        echo -e "${GREEN}Installing Docker...${NC}"
        curl -fsSL https://get.docker.com | sh
        sudo systemctl enable docker
        sudo systemctl start docker
        echo -e "${GREEN}Docker installed.${NC}"
    else
        echo -e "${YELLOW}Skipping Docker installation.${NC}"
    fi
else
    echo -e "${GREEN}Docker already installed.${NC}"
fi

echo -e "${GREEN}Checking Docker Compose plugin...${NC}"

if ! docker compose version >/dev/null 2>&1; then
    echo -e "${YELLOW}Docker Compose plugin not found. Install now?${NC}"
    echo "  1) Yes"
    echo "  2) No (skip)"
    CHOICE=$(prompt_choice "Type your choice and press Enter:")

    if [ "$CHOICE" = "1" ]; then
        sudo apt-get update
        sudo apt-get install -y docker-compose-plugin
        echo -e "${GREEN}Docker Compose plugin installed.${NC}"
    else
        echo -e "${YELLOW}Skipping Docker Compose plugin installation.${NC}"
    fi
else
    echo -e "${GREEN}Docker Compose plugin already installed.${NC}"
fi

# ------------------------------------------------------------
# STEP 6 — Check for existing OpenWebUI ARM64 image
# ------------------------------------------------------------
echo -e "${GREEN}Checking for existing OpenWebUI ARM64 Docker image...${NC}"

IMAGE_EXISTS=$(sudo docker images | grep "openwebui-arm64" | awk '{print $1":"$2}' || true)

if [ -n "$IMAGE_EXISTS" ]; then
    echo -e "${YELLOW}Existing image detected: $IMAGE_EXISTS${NC}"
    echo "Use existing image or install from tarball?"
    echo "  1) Use existing image"
    echo "  2) Install from tarball (overwrite image)"
    echo "  3) Skip image operations"
    CHOICE=$(prompt_choice "Type your choice and press Enter:")

    case "$CHOICE" in
        1)
            echo -e "${GREEN}Using existing image: $IMAGE_EXISTS${NC}"
            USE_TARBALL=0
            ;;
        2)
            echo -e "${YELLOW}Will install from tarball and overwrite existing image.${NC}"
            USE_TARBALL=1
            ;;
        3)
            echo -e "${YELLOW}Skipping image operations.${NC}"
            USE_TARBALL=0
            SKIP_IMAGE=1
            ;;
        *)
            echo -e "${RED}Invalid choice. Skipping image operations.${NC}"
            USE_TARBALL=0
            SKIP_IMAGE=1
            ;;
    esac
else
    echo -e "${YELLOW}No existing OpenWebUI ARM64 image found.${NC}"
    echo "Install from tarball now?"
    echo "  1) Yes"
    echo "  2) No (skip)"
    CHOICE=$(prompt_choice "Type your choice and press Enter:")

    if [ "$CHOICE" = "1" ]; then
        USE_TARBALL=1
    else
        USE_TARBALL=0
        SKIP_IMAGE=1
    fi
fi

# ------------------------------------------------------------
# STEP 7 — Download + validate tarball (if chosen)
# ------------------------------------------------------------
if [ "${USE_TARBALL:-0}" -eq 1 ]; then
    echo -e "${GREEN}Downloading Docker image tarball...${NC}"
    curl -L "$RELEASE_URL" -o "$TARBALL_NAME"

    echo -e "${GREEN}Validating Docker image checksum...${NC}"
    CALCULATED_SHA=$(sha256sum "$TARBALL_NAME" | awk '{print $1}')

    if [ "$CALCULATED_SHA" != "$EXPECTED_SHA" ]; then
        echo -e "${RED}============================================================"
        echo "CHECKSUM MISMATCH!"
        echo "Expected:   $EXPECTED_SHA"
        echo "Calculated: $CALCULATED_SHA"
        echo "============================================================${NC}"
        echo ""
        echo "Choose:"
        echo "  1) Abort installation"
        echo "  2) Redownload tarball"
        echo "  3) Continue anyway (NOT recommended)"
        CHOICE=$(prompt_choice "Type your choice and press Enter:")

        case "$CHOICE" in
            1)
                echo -e "${RED}Installation aborted due to checksum mismatch.${NC}"
                exit 1
                ;;
            2)
                echo -e "${YELLOW}Redownloading tarball...${NC}"
                curl -L "$RELEASE_URL" -o "$TARBALL_NAME"
                CALCULATED_SHA=$(sha256sum "$TARBALL_NAME" | awk '{print $1}')
                if [ "$CALCULATED_SHA" != "$EXPECTED_SHA" ]; then
                    echo -e "${RED}Checksum still mismatched after redownload. Aborting.${NC}"
                    exit 1
                else
                    echo -e "${GREEN}Checksum OK after redownload.${NC}"
                fi
                ;;
            3)
                echo -e "${YELLOW}Continuing despite checksum mismatch (NOT recommended).${NC}"
                ;;
            *)
                echo -e "${RED}Invalid choice. Aborting.${NC}"
                exit 1
                ;;
        esac
    else
        echo -e "${GREEN}Checksum OK.${NC}"
    fi

    echo -e "${GREEN}Loading Docker image from tarball...${NC}"
    sudo docker load -i "$TARBALL_NAME"
    echo -e "${GREEN}Docker image loaded.${NC}"
fi

# ------------------------------------------------------------
# STEP 8 — Run OpenWebUI container (optional)
# ------------------------------------------------------------
if [ "${SKIP_IMAGE:-0}" -ne 1 ]; then
    echo -e "${GREEN}Ready to run OpenWebUI ARM64 container.${NC}"
    echo "Run container now?"
    echo "  1) Yes"
    echo "  2) No (skip)"
    CHOICE=$(prompt_choice "Type your choice and press Enter:")

    if [ "$CHOICE" = "1" ]; then
        echo -e "${GREEN}Starting OpenWebUI container...${NC}"
        sudo docker run -d \
          --name openwebui \
          -p 8000:8080 \
          -v openwebui:/app/backend/data \
          openwebui-arm64:latest

        echo -e "${GREEN}OpenWebUI container started on port 8000.${NC}"
    else
        echo -e "${YELLOW}Skipping container run.${NC}"
    fi
else
    echo -e "${YELLOW}Image operations were skipped; not starting container.${NC}"
fi

# ------------------------------------------------------------
# STEP 9 — Final summary
# ------------------------------------------------------------
echo ""
echo -e "${YELLOW}============================================================"
echo " SMART DOCKER STACK INSTALLER COMPLETE"
echo "============================================================${NC}"
echo -e "${GREEN}Storage root:${NC} $STACK_ROOT"
echo -e "${GREEN}Docker status:${NC} $(command -v docker >/dev/null 2>&1 && echo 'Installed' || echo 'Not installed')"
echo -e "${GREEN}Docker Compose:${NC} $(docker compose version >/dev/null 2>&1 && echo 'Installed' || echo 'Not installed')"
echo -e "${GREEN}OpenWebUI image:${NC} $(sudo docker images | grep 'openwebui-arm64' || echo 'Not present / skipped')"
echo ""
echo -e "${CYAN}This script acted as:${NC}"
echo " - Installer"
echo " - Health check"
echo " - Repair tool"
echo " - Safe drive + folder manager"
echo ""
echo -e "${GREEN}You can rerun this script anytime to re-check or repair.${NC}"
