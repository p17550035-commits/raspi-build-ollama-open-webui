```bash
#!/bin/bash
# ============================================================
# MODEL INSTALLER — PHI-3 MINI (OLLAMA)
# ============================================================
# SYSTEM: OLLAMA
# MODEL: phi3:mini (3.8B)
#
# This model:
#   - Runs under Ollama ONLY
#   - Is extremely fast on Raspberry Pi 4
#   - Great for coding, reasoning, chat
#
# Safe to run standalone OR inside any master installer.
# ============================================================

MODEL="phi3:mini"

echo "=== INSTALLING PHI-3 MINI (OLLAMA) ==="

# Check Ollama
if ! command -v ollama >/dev/null 2>&1; then
    echo "ERROR: Ollama is not installed."
    echo "Install Ollama first using: install-ollama-only.sh"
    exit 1
fi

# Pull model
echo "Pulling model: $MODEL ..."
ollama pull "$MODEL"

echo "=== PHI-3 MINI INSTALL COMPLETE ==="
echo "System: OLLAMA"
echo "Model: $MODEL"
```
