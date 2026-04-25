#!/bin/bash
set -e

echo "=========================================="
echo "🚀 Setting up OpenCode..."
echo "=========================================="

# Check for Node.js
if ! command -v node &> /dev/null; then
    echo "📦 Installing Node.js..."
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
    apt-get install -y nodejs
    echo "✅ Node.js installed!"
else
    echo "✅ node found: $(which node)"
    echo "   node version: $(node --version)"
fi

# Install opencode globally
echo "📦 Installing opencode-ai..."
npm install -g opencode-ai@latest
echo "✅ opencode installed!"

# Create opencode config directory
mkdir -p ~/.config/opencode

# Create config.json with Big Pickle model (only if doesn't exist)
if [ ! -f ~/.config/opencode/opencode.json ]; then
    echo "⚙️ Creating opencode config with Big Pickle..."
    cat > ~/.config/opencode/opencode.json << 'EOF'
{
  "$schema": "https://opencode.ai/config.json",
  "model": "opencode/big-pickle"
}
EOF
    echo "✅ Config created!"
else
    echo "✅ Config already exists"
fi

echo "=========================================="
echo "📁 Setting up OpenCode capture directory..."
echo "=========================================="

# ---- MAGIC SAUCE STARTS HERE ----

# In Codespaces, repo root is current working directory
REPO_ROOT="$(pwd)"
TARGET="$REPO_ROOT/opencode_capture"
SOURCE="$HOME/.local/share/opencode"

mkdir -p "$TARGET"
mkdir -p "$HOME/.local/share"

# If OpenCode already created data, preserve it
if [ -d "$SOURCE" ] && [ ! -L "$SOURCE" ]; then
    echo "🔄 Migrating existing OpenCode data into repo..."
    cp -a "$SOURCE"/. "$TARGET"/ 2>/dev/null || true
    mv "$SOURCE" "$SOURCE.backup.$(date +%s)"
fi

# Create symlink so OpenCode writes into repo
if [ ! -e "$SOURCE" ]; then
    ln -s "$TARGET" "$SOURCE"
    echo "🔗 Linked $SOURCE → $TARGET"
else
    echo "ℹ️ OpenCode directory already linked or exists"
fi

# Ensure directory is visible in git even if empty
touch "$TARGET/.gitkeep"

echo "✅ OpenCode data will be captured in: $TARGET"

# ---- MAGIC SAUCE ENDS HERE ----

echo "=========================================="
echo "🔥 READY!"
echo "   Run 'opencode' to start coding!"
echo "=========================================="
