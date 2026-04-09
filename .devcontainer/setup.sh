#!/bin/bash
set -e

echo "=========================================="
echo "🚀 BEAST MODE: Setting up OpenCode..."
echo "=========================================="

# Install opencode via npm
echo "📦 Installing opencode via npm..."
npm install -g opencode-ai/opencode
echo "✅ OpenCode installed!"

# Get npm global bin path
NPM_GLOBAL_BIN=$(npm root -g)/bin

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
    echo "✅ Config already exists, skipping..."
fi

# Add to PATH permanently
if ! grep -q "$NPM_GLOBAL_BIN" ~/.bashrc 2>/dev/null; then
    echo "📝 Adding npm bin to PATH in ~/.bashrc..."
    echo "export PATH=\"$NPM_GLOBAL_BIN:\$PATH\"" >> ~/.bashrc
fi

# Add to PATH for current session
export PATH="$NPM_GLOBAL_BIN:$PATH"

# Verify it's installed
if command -v opencode &> /dev/null; then
    echo "=========================================="
    echo "🔥 BEAST MODE: READY TO CODE!"
    echo "   Run 'opencode' to start coding!"
    echo "=========================================="
else
    echo "⚠️ Warning: opencode not found in PATH"
    echo "   NPM bin is at: $NPM_GLOBAL_BIN"
    ls -la "$NPM_GLOBAL_BIN/"
fi