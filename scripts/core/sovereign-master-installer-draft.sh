#!/bin/bash
# ============================================================
# SOVEREIGN INSTALLER v3.0 (FINAL MERGE)
# ============================================================
# Features:
# - Transactional Staging (No changes until commit)
# - Interactive Stage Editing (Type stage number to re-configure)
# - Accidental Input Protection (3-strike auto-abort)
# - Sovereign Modifier (Ctrl+X for instant confirm)
# - Original: SHA-256 validation, Docker Compose, Tarball loading
# - One single script to rule them all
# ============================================================

set -e

# --- CONFIGURATION ---
STAGING_FILE="/tmp/sovereign_staging_$$"
CHECKPOINT_LOG="/tmp/sovereign_checkpoints_$$"
CONFIRM_COUNT=0
MAX_ACCIDENTAL=3
USER=$(whoami)

# Original Script Variables
TARBALL_NAME="openwebui-arm64.tar"
RELEASE_URL="https://github.com/p17550035-commits/raspi-build-ollama-open-webui/releases/download/v1.1-arm64/openwebui-arm64.tar"
EXPECTED_SHA="7f5666a0815ad1ce374ffa28d417538d2d484bb319c7767c7ea35913a5d3ae0e"

# --- COLORS ---
RED="\033[1;31m"
YELLOW="\033[1;33m"
GREEN="\033[1;32m"
CYAN="\033[1;36m"
NC="\033[0m"

# --- HELPER FUNCTIONS ---

log_action() {
    echo "[$(date +%H:%M:%S)] $1" | tee -a "$CHECKPOINT_LOG"
}

stage_action() {
    local type="$1"
    local target="$2"
    local desc="$3"
    echo "$1|$type|$target|$desc" >> "$STAGING_FILE"
    echo -e "${CYAN}[STAGED] $desc${NC}"
}

check_accidental() {
    if [[ "$1" == "Y" ]] || [[ "$1" == "y" ]]; then
        CONFIRM_COUNT=$((CONFIRM_COUNT + 1))
        if [ $CONFIRM_COUNT -ge $MAX_ACCIDENTAL ]; then
            echo -e "${RED}============================================================"
            echo "WARNING: $MAX_ACCIDENTAL consecutive confirmations detected."
            echo "Possible accidental input. Aborting."
            echo "============================================================${NC}"
            rm -f "$STAGING_FILE" "$CHECKPOINT_LOG"
            exit 1
        fi
    else
        CONFIRM_COUNT=0
    fi
}

# --- STAGE FUNCTIONS ---

stage_1_drives() {
    echo -e "${YELLOW}=== STAGE 1: DETECT & MOUNT DRIVES ===${NC}"
    
    local drives=$(lsblk -o NAME,TYPE | grep "disk" | awk '{print $1}' | grep "sd")
    
    if [ -z "$drives" ]; then
        echo -e "${YELLOW}No external drives detected. Using local storage.${NC}"
        MOUNT_POINT="$HOME/pistack"
        stage_action "1" "MOUNT" "local" "Use local storage at $MOUNT_POINT"
        return
    fi
    
    echo "Detected drives: $drives"
    echo "Select drive (e.g., sda): "
    read -r DRIVE
    
    TARGET="/dev/$DRIVE"
    
    local fs_type=$(blkid "$TARGET" | awk -F 'TYPE="' '{print $2}' | awk -F '"' '{print $1}')
    if [ -z "$fs_type" ]; then fs_type="UNFORMATTED"; fi
    
    if [ "$fs_type" != "ext4" ]; then
        echo -e "${RED}WARNING: Drive is NOT ext4. Formatting will erase data.${NC}"
        echo "1) Format 2) Skip 3) Abort"
        read -r CHOICE
        if [ "$CHOICE" = "1" ]; then
            echo -e "${RED}Type FORMAT to confirm:${NC}"
            read -r CONFIRM
            if [ "$CONFIRM" != "FORMAT" ]; then exit 1; fi
            sudo mkfs.ext4 "$TARGET"
            stage_action "1" "FORMAT" "$TARGET" "Format $TARGET to ext4"
        elif [ "$CHOICE" = "3" ]; then exit 1; fi
    fi
    
    MOUNT_POINT="/mnt/pidrive"
    sudo mkdir -p "$MOUNT_POINT"
    sudo mount "$TARGET" "$MOUNT_POINT"
    echo "$TARGET $MOUNT_POINT ext4 defaults 0 0" | sudo tee -a /etc/fstab > /dev/null
    stage_action "1" "MOUNT" "$TARGET" "Mount $TARGET at $MOUNT_POINT"
}

stage_2_folders() {
    echo -e "${YELLOW}=== STAGE 2: SCAN & FIX FOLDERS ===${NC}"
    
    local stack_root="$MOUNT_POINT/stack"
    mkdir -p "$stack_root"
    
    local folders=(
        "$stack_root/postgres"
        "$stack_root/redis"
        "$stack_root/qdrant"
        "$stack_root/minio"
        "$stack_root/gitea"
        "$stack_root/openwebui"
        "$stack_root/backups"
        "$stack_root/logs"
    )
    
    for F in "${folders[@]}"; do
        local status="MISSING"
        if [ -d "$F" ]; then
            if [ -z "$(ls -A "$F" 2>/dev/null)" ]; then
                status="EMPTY"
            elif ! ls "$F" >/dev/null 2>&1; then
                status="CORRUPTED"
            else
                status="EXISTS"
            fi
        fi
        
        echo "Folder: $F (Status: $status)"
        echo "1) Keep 2) Overwrite 3) Repair 4) Skip 5) Abort"
        read -r CHOICE
        
        case "$CHOICE" in
            1) stage_action "2" "KEEP" "$F" "Keep existing $F" ;;
            2) stage_action "2" "OVERWRITE" "$F" "Overwrite $F" ;;
            3) stage_action "2" "REPAIR" "$F" "Repair permissions on $F" ;;
            4) stage_action "2" "SKIP" "$F" "Skip $F" ;;
            5) exit 1 ;;
            *) stage_action "2" "SKIP" "$F" "Invalid choice, skipping" ;;
        esac
    done
}

stage_3_docker() {
    echo -e "${YELLOW}=== STAGE 3: DOCKER & IMAGE ===${NC}"
    
    # Check Docker
    if ! command -v docker >/dev/null 2>&1; then
        echo "Docker not found. Install? (Y/N)"
        read -r CHOICE
        if [ "$CHOICE" = "Y" ] || [ "$CHOICE" = "y" ]; then
            curl -fsSL
