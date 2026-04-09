# OpenCode Development Environment

This is a GitHub Codespaces-ready environment for using OpenCode with the Big Pickle model.

## What's Included

- **Python 3.11** - Base development environment
- **Node.js** - Required for OpenCode
- **OpenCode** - AI-assisted coding tool
- **VS Code Python Extension** - For Python development

## How It Works

1. When the Codespace starts, `postCreateCommand` runs `setup.sh`
2. The setup script:
   - Installs Node.js (if needed)
   - Installs OpenCode via npm (if not already installed)
   - Creates `~/.opencode/config.yaml` with Big Pickle model configuration

## Using This with GitHub Codespaces

1. Push this folder to a GitHub repository
2. Go to GitHub → Codespaces → "Create new codespace"
3. Select this repository
4. The container will automatically:
   - Install Python extension
   - Install Node.js
   - Install OpenCode
   - Configure Big Pickle model

## Manual Setup (if not using Codespaces)

```bash
# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt-get install -y nodejs

# Install OpenCode
npm install -g opencode-ai/opencode

# Create config
mkdir -p ~/.opencode
cat > ~/.opencode/config.yaml << 'EOF'
model: big-pickle
provider: openrouter
temperature: 0.7
max_tokens: 4000
EOF
```

## Notes

- The setup is idempotent — it checks if things are already installed before re-running
- You need an OpenRouter API key for Big Pickle to work (set via environment variable `OPENROUTER_API_KEY`)