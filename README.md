# OpenCode Development Environment

This is a GitHub Codespaces-ready environment for using OpenCode with Big Pickle.

## What's Included

- **Python 3.11** - Base development environment
- **Node.js** - Required for OpenCode
- **OpenCode** - AI-assisted coding tool
- **Big Pickle** - Configured automatically

## How It Works

1. When the Codespace starts, `postCreateCommand` runs `setup.sh`
2. The setup script:
   - Installs OpenCode via npm
   - Creates `~/.config/opencode/opencode.json` with Big Pickle model

## Using This with GitHub Codespaces

1. This repo is already set up for Codespaces
2. Go to GitHub → Codespaces → "Create new codespace"
3. The container will automatically install and configure OpenCode

## Manual Setup

```bash
# Install OpenCode
npm install -g opencode-ai/opencode

# Create config
mkdir -p ~/.config/opencode
cat > ~/.config/opencode/opencode.json << 'EOF'
{
  "$schema": "https://opencode.ai/config.json",
  "model": "opencode/big-pickle"
}
EOF
```