```bash
#!/bin/bash
# ============================================================
# MODEL INSTALLER — PHI-3 SMALL (OLLAMA)
# ============================================================
# SYSTEM: OLLAMA
# MODEL: phi3:small (7B)
#
# This model:
#   - Runs under Ollama ONLY
#   - Slightly slower than Mini but still Pi-safe
#   - Great for coding + reasoning
# ============================================================

MODEL="phi3:small"

echo "=== INSTALLING PHI-3 SMALL (OLLAMA) ==="

# Check Ollama
if ! command -v ollama >/dev/null 2>&1; then
    echo "ERROR: Ollama is not installed."
    exit 1
fi

# Pull model
echo "Pulling model: $MODEL ..."
ollama pull "$MODEL"

echo "=== PHI-3 SMALL INSTALL COMPLETE ==="
echo "System: OLLAMA"
echo "Model: $MODEL"
```
