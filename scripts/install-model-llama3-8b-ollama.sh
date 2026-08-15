```bash
#!/bin/bash
# ============================================================
# MODEL INSTALLER — LLAMA 3 8B (OLLAMA)
# ============================================================
# SYSTEM: OLLAMA
# MODEL: llama3:8b
#
# This model:
#   - Runs under Ollama ONLY
#   - Best general-purpose Pi-safe model
#   - Great for chat + reasoning
# ============================================================

MODEL="llama3:8b"

echo "=== INSTALLING LLAMA 3 8B (OLLAMA) ==="

# Check Ollama
if ! command -v ollama >/dev/null 2>&1; then
    echo "ERROR: Ollama is not installed."
    exit 1
fi

# Pull model
echo "Pulling model: $MODEL ..."
ollama pull "$MODEL"

echo "=== LLAMA 3 8B INSTALL COMPLETE ==="
echo "System: OLLAMA"
echo "Model: $MODEL"
```
