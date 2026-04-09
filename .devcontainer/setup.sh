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

# Create opencode wrapper in user's home directory (writable by vscode)
echo "📦 Creating opencode wrapper in home directory..."
mkdir -p /home/vscode/bin

# Create wrapper script that uses npx
cat > /home/vscode/bin/opencode << 'EOF'
#!/bin/bash
npx -y opencode-ai/opencode "$@"
EOF
chmod +x /home/vscode/bin/opencode

# Add to PATH for current and future sessions
export PATH="/home/vscode/bin:$PATH"
echo 'export PATH="/home/vscode/bin:$PATH"' >> /home/vscode/.bashrc

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