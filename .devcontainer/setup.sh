#!/bin/bash
set -e

echo "=========================================="
echo "🚀 BEAST MODE: Setting up OpenCode..."
echo "=========================================="

# Check if npm exists, if not install node
if ! command -v npm &> /dev/null; then
    echo "📦 Installing Node.js..."
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
    apt-get install -y nodejs
    echo "✅ Node.js installed!"
else
    echo "✅ npm found: $(which npm)"
    echo "   npm version: $(npm --version)"
fi

# Install opencode via npm
echo "📦 Installing opencode via npm..."
npm install -g opencode-ai/opencode
echo "✅ OpenCode installed!"

# Get npm global bin path
NPM_GLOBAL_BIN=$(npm root -g)/bin
echo "   NPM global bin: $NPM_GLOBAL_BIN"

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
echo "📝 Checking PATH..."
if ! grep -q "$NPM_GLOBAL_BIN" ~/.bashrc 2>/dev/null; then
    echo "   Adding npm bin to PATH in ~/.bashrc..."
    echo "export PATH=\"$NPM_GLOBAL_BIN:\$PATH\"" >> ~/.bashrc
else
    echo "   PATH already configured"
fi

# Add to PATH for current session
export PATH="$NPM_GLOBAL_BIN:$PATH"

# Show what's in npm global bin
echo ""
echo "📁 Contents of npm global bin:"
ls -la "$NPM_GLOBAL_BIN/"

# Verify
echo ""
if command -v opencode &> /dev/null; then
    echo "=========================================="
    echo "🔥 BEAST MODE: READY TO CODE!"
    echo "   Run 'opencode' to start coding!"
    echo "=========================================="
else
    echo "⚠️ Still not in PATH. Trying to find it..."
    find /usr -name "opencode" -type f 2>/dev/null || true
    find /usr/local -name "opencode" -type f 2>/dev/null || true
fi