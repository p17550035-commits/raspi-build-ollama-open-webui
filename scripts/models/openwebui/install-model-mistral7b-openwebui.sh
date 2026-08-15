```bash
#!/bin/bash
# ============================================================
# MODEL INSTALLER — MISTRAL 7B GGUF (OPENWEBUI BACKEND)
# ============================================================
# SYSTEM: OPENWEBUI BACKEND
# MODEL: mistral-7b.gguf
#
# This model:
#   - Runs inside OpenWebUI ONLY
#   - Does NOT use Ollama
#   - Slower than Phi/Gemma but still Pi-safe
# ============================================================

MODEL_URL="https://huggingface.co/your/gguf/path/mistral-7b.gguf"
TARGET_DIR="/mnt/pidrive/stack/openwebui/models"

echo "=== INSTALLING MISTRAL 7B GGUF (OPENWEBUI BACKEND) ==="

mkdir -p "$TARGET_DIR"

echo "Downloading model..."
wget -O "$TARGET_DIR/mistral-7b.gguf" "$MODEL_URL"

echo "=== MISTRAL 7B GGUF INSTALL COMPLETE ==="
echo "System: OPENWEBUI BACKEND"
echo "Model: mistral-7b.gguf"
```
