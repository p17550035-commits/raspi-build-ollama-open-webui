```bash
#!/bin/bash
# ============================================================
# MODEL INSTALLER — PHI-3 MINI GGUF (OPENWEBUI BACKEND)
# ============================================================
# SYSTEM: OPENWEBUI BACKEND
# MODEL: phi3-mini.gguf
#
# This model:
#   - Runs inside OpenWebUI ONLY
#   - Does NOT use Ollama
#   - Very fast on Pi 4
# ============================================================

MODEL_URL="https://huggingface.co/your/gguf/path/phi3-mini.gguf"
TARGET_DIR="/mnt/pidrive/stack/openwebui/models"

echo "=== INSTALLING PHI-3 MINI GGUF (OPENWEBUI BACKEND) ==="

mkdir -p "$TARGET_DIR"

echo "Downloading model..."
wget -O "$TARGET_DIR/phi3-mini.gguf" "$MODEL_URL"

echo "=== PHI-3 MINI GGUF INSTALL COMPLETE ==="
echo "System: OPENWEBUI BACKEND"
echo "Model: phi3-mini.gguf"
```
