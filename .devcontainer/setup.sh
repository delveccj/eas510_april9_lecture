#!/bin/bash
set -e

echo "=========================================="
echo "🚀 BEAST MODE: Setting up OpenCode..."
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

# Try to install opencode using npx first (no global install needed!)
echo "📦 Checking for opencode..."
if command -v opencode &> /dev/null; then
    echo "✅ OpenCode already installed!"
else
    echo "📦 Trying to install via npx..."
    # Create a wrapper script that uses npx
    echo '#!/bin/bash' > /usr/local/bin/opencode
    echo 'npx -y opencode-ai/opencode "$@"' >> /usr/local/bin/opencode
    chmod +x /usr/local/bin/opencode
    echo "✅ OpenCode wrapper created!"
fi

# Verify
echo ""
echo "📁 Checking opencode..."
which opencode || echo "   not in PATH"

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
echo "🔥 BEAST MODE: READY!"
echo "   Run 'opencode' to start coding!"
echo "=========================================="