```bash
#!/bin/bash
# ============================================================
# MODEL INSTALLER — GEMMA 2 2B (OPENWEBUI BACKEND)
# ============================================================
# SYSTEM: OPENWEBUI BACKEND
# MODEL: gemma-2-2b.gguf
#
# This model:
#   - Runs inside OpenWebUI ONLY
#   - Does NOT use Ollama
#   - Very fast on Pi 4
# ============================================================

MODEL_URL="https://huggingface.co/your/gguf/path/gemma-2-2b.gguf"
TARGET_DIR="/mnt/pidrive/stack/openwebui/models"

echo "=== INSTALLING GEMMA 2 2B (OPENWEBUI BACKEND) ==="

mkdir -p "$TARGET_DIR"

echo "Downloading model..."
wget -O "$TARGET_DIR/gemma-2-2b.gguf" "$MODEL_URL"

echo "=== GEMMA 2 2B INSTALL COMPLETE ==="
echo "System: OPENWEBUI BACKEND"
echo "Model: gemma-2-2b.gguf"
echo "Place this model in OpenWebUI model settings."
```
