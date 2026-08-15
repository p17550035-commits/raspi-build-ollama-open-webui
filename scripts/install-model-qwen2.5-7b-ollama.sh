```bash
#!/bin/bash
# ============================================================
# MODEL INSTALLER — QWEN 2.5 7B (OLLAMA)
# ============================================================
# SYSTEM: OLLAMA
# MODEL: qwen2.5:7b
#
# This model:
#   - Runs under Ollama ONLY
#   - Great for coding + reasoning
# ============================================================

MODEL="qwen2.5:7b"

echo "=== INSTALLING QWEN 2.5 7B (OLLAMA) ==="

# Check Ollama
if ! command -v ollama >/dev/null 2>&1; then
    echo "ERROR: Ollama is not installed."
    exit 1
fi

# Pull model
echo "Pulling model: $MODEL ..."
ollama pull "$MODEL"

echo "=== QWEN 2.5 7B INSTALL COMPLETE ==="
echo "System: OLLAMA"
echo "Model: $MODEL"
```
