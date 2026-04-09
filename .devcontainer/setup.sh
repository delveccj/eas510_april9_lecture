#!/bin/bash
set -e

echo "Setting up OpenCode environment..."

# Install opencode via npm
echo "Installing opencode via npm..."
npm install -g opencode-ai/opencode

# Get npm global bin path
NPM_GLOBAL_BIN=$(npm root -g)/bin

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

# Add to PATH permanently for future sessions
if ! grep -q "$NPM_GLOBAL_BIN" ~/.bashrc 2>/dev/null; then
    echo "export PATH=\"$NPM_GLOBAL_BIN:\$PATH\"" >> ~/.bashrc
fi

# Add to PATH for current session
export PATH="$NPM_GLOBAL_BIN:$PATH"

echo "OpenCode setup complete!"
echo "Run 'opencode' to start."