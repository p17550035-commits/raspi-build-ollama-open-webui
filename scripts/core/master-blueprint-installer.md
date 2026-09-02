# ============================================================
# SOVEREIGN INSTALLER BLUEPRINT (FINAL ARCHITECTURE)
# ============================================================
# Objective:
#   Merge the original install-upgrade-docker.sh (Safety/Repair) 
#   with the sovereign-installer.sh (Staging/Editing) into 
#   a single, file-per-stage system.
# ============================================================

# ============================================================
# 1. FILE STRUCTURE
# ============================================================
# Create one file per stage in /tmp/:
#   /tmp/sovereign_stage_1.conf  (Drive Logic)
#   /tmp/sovereign_stage_2.conf  (Folder Logic)
#   /tmp/sovereign_stage_3.conf  (Docker & Image Logic)
#   /tmp/sovereign_stage_4.conf  (Container Start Logic)
# ============================================================

# ============================================================
# 2. UPDATED HELPER FUNCTIONS
# ============================================================

get_stage_file() {
    echo "/tmp/sovereign_stage_$1.conf"
}

stage_action() {
    local stage_num="$1"
    local type="$2"
    local target="$3"
    local desc="$4"
    
    local stage_file=$(get_stage_file "$stage_num")
    
    # Format: STAGE_NUM|TYPE|TARGET|DESC
    echo "$stage_num|$type|$target|$desc" >> "$stage_file"
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
            rm -f /tmp/sovereign_stage_*.conf
            rm -f /tmp/sovereign_checkpoints_*.log
            exit 1
        fi
    else
        CONFIRM_COUNT=0
    fi
}

# ============================================================
Got it. No code. Just the **exact instructions**. You're right—giving the blueprint to another AI is safer than me trying to output a messy block.

Here is the **plain-text blueprint**. Save this along with your `todo.md`.

---

### 📋 SOVEREIGN INSTALLER BLUEPRINT (Instructions)

**Goal:** Take the **Original Script** (from `scripts/core/install-upgrade-docker.sh`) and merge it with the **Safety Logic** (from `sovereign-installer.sh`) by using **one file per stage**.

**Step 1: Create the File Structure**
Create 4 separate configuration files in `/tmp/` instead of one big file:
1.  `/tmp/sovereign_stage_1.conf` (Drives)
2.  `/tmp/sovereign_stage_2.conf` (Folders)
3.  `/tmp/sovereign_stage_3.conf` (Docker/Image)
4.  `/tmp/sovereign_stage_4.conf` (Container Start)

**Step 2: Update the `stage_action()` Helper**
Change it so that when you call `stage_action`, it writes to the **specific stage file** designated by the first argument.

**Step 3: Update the `execute_staging()` Function**
Instead of reading one big file, loop through the 4 stage files one by one.
- For each file, read the actions line by line.
- Execute each action (Mount, Format, Install, Start).
- Log the action to the checkpoint log.

**Step 4: Update the Review Loop**
When the script asks for input (`Y/N/Stage#`):
- If the user types a number (e.g., `2`), delete the contents of `/tmp/sovereign_stage_2.conf` and **re-run the logic for Stage 2**.
- This allows the user to edit Stage 2 without affecting Stage 1 or 3.

**Step 5: Preserve Original Features**
Make sure the **SHA-256 validation**, **Docker Compose install**, and **Tarball loading** from the original script are moved into `stage_3.conf`.

---

**That’s it.** Once these 5 steps are done, the script will have the original functionality plus the safety features you designed.
