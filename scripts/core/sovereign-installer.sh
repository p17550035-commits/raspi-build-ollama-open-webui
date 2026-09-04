#!/bin/bash

# ============================================================
#  SOVEREIGN INSTALLER — BLOCK 1
#  Core Initialization + Curses Input System + Global Setup
# ============================================================

# --- GLOBAL COLOR CODES -------------------------------------
CLR_RESET="\033[0m"
CLR_HIGHLIGHT="\033[1;37;44m"
CLR_NORMAL="\033[0;37m"
CLR_WARN="\033[1;33m"
CLR_ERR="\033[1;31m"
CLR_OK="\033[1;32m"

# --- GLOBAL STATE -------------------------------------------
CURRENT_STAGE=0
SELECTED_INDEX=0
MAX_OPTIONS=0
EXIT_FLAG=0
CTRLX_FLAG=0

# --- STAGING FILES ------------------------------------------
STAGE1_FILE="/tmp/stage1.sov"
STAGE2_FILE="/tmp/stage2.sov"
STAGE3_FILE="/tmp/stage3.sov"
STAGE4_FILE="/tmp/stage4.sov"

# --- CLEAN STAGING ------------------------------------------
rm -f "$STAGE1_FILE" "$STAGE2_FILE" "$STAGE3_FILE" "$STAGE4_FILE"

# --- CURSES SETUP -------------------------------------------
stty -echo -icanon time 0 min 0

# --- DRAW MENU FUNCTION -------------------------------------
draw_menu() {
    clear
    echo -e "${CLR_OK}SOVEREIGN INSTALLER — STAGE $CURRENT_STAGE${CLR_RESET}"
    echo ""

    local idx=0
    while IFS= read -r line; do
        if [[ $idx -eq $SELECTED_INDEX ]]; then
            echo -e "${CLR_HIGHLIGHT}${line}${CLR_RESET}"
        else
            echo -e "${CLR_NORMAL}${line}${CLR_RESET}"
        fi
        idx=$((idx+1))
    done <<< "$MENU_CONTENT"
}

# --- READ KEY FUNCTION --------------------------------------
read_key() {
    local key
    key=$(dd bs=1 count=1 2>/dev/null)

    case "$key" in
        $'\x1b')
            key+=$(dd bs=1 count=2 2>/dev/null)
            case "$key" in
                $'\x1b[A') SELECTED_INDEX=$((SELECTED_INDEX-1));;
                $'\x1b[B') SELECTED_INDEX=$((SELECTED_INDEX+1));;
            esac
        ;;
        $'\x18')
            CTRLX_FLAG=1
        ;;
        $'\x1bOP') CURRENT_STAGE=1;;
        $'\x1bOQ') CURRENT_STAGE=2;;
        $'\x1bOR') CURRENT_STAGE=3;;
        $'\x1bOS') CURRENT_STAGE=4;;
        "")
            EXIT_FLAG=1
        ;;
    esac

    if [[ $SELECTED_INDEX -lt 0 ]]; then
        SELECTED_INDEX=$((MAX_OPTIONS-1))
    fi
    if [[ $SELECTED_INDEX -ge $MAX_OPTIONS ]]; then
        SELECTED_INDEX=0
    fi
}

# --- LOAD MENU FOR STAGE ------------------------------------
load_stage_menu() {
    case "$CURRENT_STAGE" in
        1)
            MENU_CONTENT="Use existing drive
Format drive
Mount drive
Skip
Abort"
            MAX_OPTIONS=5
        ;;
        2)
            MENU_CONTENT="Keep folder
Overwrite folder
Repair folder
Create folder
Skip
Abort"
            MAX_OPTIONS=6
        ;;
        3)
            MENU_CONTENT="Use existing image
Replace image
Download tarball
Validate SHA256
Load image
Skip
Abort"
            MAX_OPTIONS=7
        ;;
        4)
            MENU_CONTENT="Start container
Restart container
Rebuild container
Skip
Abort"
            MAX_OPTIONS=5
        ;;
    esac
}

# --- MAIN INPUT LOOP ----------------------------------------
main_loop() {
    while [[ $EXIT_FLAG -eq 0 ]]; do
        load_stage_menu
        draw_menu
        read_key

        if [[ $CTRLX_FLAG -eq 1 ]]; then
            break
        fi
    done
}

# --- START ---------------------------------------------------
CURRENT_STAGE=1
main_loop

# ============================================================
#  END OF BLOCK 1
#  (Block 2 will continue EXACTLY from here)
# ============================================================
# ============================================================
#  SECTION 2 — STAGE MENU LOADER + MENU DEFINITIONS
# ============================================================

# --- MENU DEFINITIONS ---------------------------------------
menu_stage1() {
    MENU_CONTENT="Use existing drive
Format drive
Mount drive
Skip
Abort"
    MAX_OPTIONS=5
}

menu_stage2() {
    MENU_CONTENT="Keep folder
Overwrite folder
Repair folder
Create folder
Skip
Abort"
    MAX_OPTIONS=6
}

menu_stage3() {
    MENU_CONTENT="Use existing image
Replace image
Download tarball
Validate SHA256
Load image
Skip
Abort"
    MAX_OPTIONS=7
}

menu_stage4() {
    MENU_CONTENT="Start container
Restart container
Rebuild container
Skip
Abort"
    MAX_OPTIONS=5
}

# --- STAGE MENU LOADER --------------------------------------
load_stage_menu() {
    case "$CURRENT_STAGE" in
        1) menu_stage1 ;;
        2) menu_stage2 ;;
        3) menu_stage3 ;;
        4) menu_stage4 ;;
        *)
            MENU_CONTENT="Invalid stage"
            MAX_OPTIONS=1
        ;;
    esac
}


#=============end of section 2=================================

# ============================================================
#  SECTION 3 — INPUT LOOP + KEY HANDLING REFINEMENTS
# ============================================================

# --- KEY HANDLING -------------------------------------------
handle_arrow_keys() {
    case "$1" in
        $'\x1b[A') SELECTED_INDEX=$((SELECTED_INDEX-1)) ;;  # Up
        $'\x1b[B') SELECTED_INDEX=$((SELECTED_INDEX+1)) ;;  # Down
    esac

    # Wrap-around protection
    if [[ $SELECTED_INDEX -lt 0 ]]; then
        SELECTED_INDEX=$((MAX_OPTIONS-1))
    fi
    if [[ $SELECTED_INDEX -ge $MAX_OPTIONS ]]; then
        SELECTED_INDEX=0
    fi
}

handle_function_keys() {
    case "$1" in
        $'\x1bOP') CURRENT_STAGE=1 ;;  # F1
        $'\x1bOQ') CURRENT_STAGE=2 ;;  # F2
        $'\x1bOR') CURRENT_STAGE=3 ;;  # F3
        $'\x1bOS') CURRENT_STAGE=4 ;;  # F4
    esac
}

handle_control_keys() {
    case "$1" in
        $'\x18') CTRLX_FLAG=1 ;;  # CTRL+X
        "") EXIT_FLAG=1 ;;        # Enter / Null input
    esac
}

# --- RAW KEY READER -----------------------------------------
read_key() {
    local key
    key=$(dd bs=1 count=1 2>/dev/null)

    case "$key" in
        $'\x1b')
            key+=$(dd bs=1 count=2 2>/dev/null)
            handle_arrow_keys "$key"
            handle_function_keys "$key"
        ;;
        *)
            handle_control_keys "$key"
        ;;
    esac
}

# --- MAIN INPUT LOOP ----------------------------------------
main_loop() {
    while [[ $EXIT_FLAG -eq 0 ]]; do
        load_stage_menu
        draw_menu
        read_key

        if [[ $CTRLX_FLAG -eq 1 ]]; then
            break
        fi
    done
}

# === END OF SECTION 3 ===

# ============================================================
#  SECTION 4 — STAGE 1 LOGIC (DRIVE DETECTION + SELECTION)
# ============================================================

# --- DRIVE DETECTION ----------------------------------------
detect_drives() {
    AVAILABLE_DRIVES=$(lsblk -ndo NAME,TYPE | awk '$2=="disk"{print "/dev/"$1}')
}

# --- DRIVE ACTION: USE EXISTING -----------------------------
stage1_use_existing() {
    detect_drives
    echo "Using existing drive..." > "$STAGE1_FILE"
}

# --- DRIVE ACTION: FORMAT -----------------------------------
stage1_format_drive() {
    detect_drives
    echo "Format drive selected" > "$STAGE1_FILE"
}

# --- DRIVE ACTION: MOUNT ------------------------------------
stage1_mount_drive() {
    detect_drives
    echo "Mount drive selected" > "$STAGE1_FILE"
}

# --- DRIVE ACTION: SKIP -------------------------------------
stage1_skip() {
    echo "Skip Stage 1" > "$STAGE1_FILE"
}

# --- DRIVE ACTION: ABORT ------------------------------------
stage1_abort() {
    echo "ABORT" > "$STAGE1_FILE"
    EXIT_FLAG=1
}

# --- STAGE 1 DISPATCH ---------------------------------------
run_stage1_action() {
    case "$SELECTED_INDEX" in
        0) stage1_use_existing ;;
        1) stage1_format_drive ;;
        2) stage1_mount_drive ;;
        3) stage1_skip ;;
        4) stage1_abort ;;
    esac
}

# === END OF SECTION 4 ===

