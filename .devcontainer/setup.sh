#!/bin/bash
set -e

echo "Setting up OpenCode environment..."

# Install opencode via npm
echo "Installing opencode via npm..."
npm install -g opencode-ai/opencode

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