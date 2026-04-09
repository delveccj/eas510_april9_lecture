#!/bin/bash
set -e

echo "Setting up OpenCode environment..."

# Check if Node.js is installed (it should be via features)
if ! command -v node &> /dev/null; then
    echo "Installing Node.js..."
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
    apt-get install -y nodejs
fi

# Install opencode if not already installed
if ! command -v opencode &> /dev/null; then
    echo "Installing opencode via npm..."
    npm install -g opencode-ai/opencode
fi

# Create opencode config directory
mkdir -p ~/.config/opencode

# Create config.json with Big Pickle model (only if doesn't exist)
if [ ! -f ~/.config/opencode/opencode.json ]; then
    echo "Creating opencode config..."
    cat > ~/.config/opencode/opencode.json << 'EOF'
{
  "$schema": "https://opencode.ai/config.json",
  "model": "opencode/big-pickle"
}
EOF
fi

echo "OpenCode setup complete!"
echo "Run 'opencode' to start."