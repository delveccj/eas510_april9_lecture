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
echo "🔥 READY!"
echo "   Run 'opencode' to start coding!"
echo "=========================================="