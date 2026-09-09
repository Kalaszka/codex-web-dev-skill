#!/bin/bash
# Codex Web Dev Skill - Multi-Machine Installation Script
# Supports: macOS, Linux
# Requires: Tailscale installed and configured

set -e

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Codex Web Dev Skill Installation ===${NC}"

# Detect OS
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
else
    echo -e "${RED}Unsupported OS: $OSTYPE${NC}"
    exit 1
fi

echo -e "${YELLOW}Detected OS: $OS${NC}"

# Check if Tailscale is running
echo -e "${YELLOW}Checking Tailscale status...${NC}"
if command -v tailscale &> /dev/null; then
    TAILSCALE_IP=$(tailscale ip -4 2>/dev/null || echo "not-connected")
    if [ "$TAILSCALE_IP" != "not-connected" ]; then
        echo -e "${GREEN}✓ Tailscale is running on $TAILSCALE_IP${NC}"
    else
        echo -e "${YELLOW}⚠ Tailscale is installed but not connected${NC}"
    fi
else
    echo -e "${YELLOW}⚠ Tailscale not found. Skipping Tailscale features.${NC}"
fi

# Check if Codex is installed
echo -e "${YELLOW}Checking for Codex installation...${NC}"
if ! command -v codex &> /dev/null; then
    echo -e "${RED}✗ Codex not found. Please install Codex first.${NC}"
    echo "Visit: https://github.com/VoltAgent/codex"
    exit 1
fi

echo -e "${GREEN}✓ Codex found${NC}"

# Determine Codex skills directory
if [ "$OS" = "macos" ]; then
    CODEX_SKILLS_DIR="$HOME/.codex/skills"
elif [ "$OS" = "linux" ]; then
    CODEX_SKILLS_DIR="${XDG_CONFIG_HOME:=$HOME/.config}/codex/skills"
fi

echo -e "${YELLOW}Skills directory: $CODEX_SKILLS_DIR${NC}"

# Create skills directory if it doesn't exist
mkdir -p "$CODEX_SKILLS_DIR"

# Clone or update the skill repository
echo -e "${YELLOW}Installing codex-web-dev-skill...${NC}"

if [ -d "$CODEX_SKILLS_DIR/codex-web-dev-skill" ]; then
    echo -e "${YELLOW}Updating existing installation...${NC}"
    cd "$CODEX_SKILLS_DIR/codex-web-dev-skill"
    git pull origin main
else
    echo -e "${YELLOW}Cloning repository...${NC}"
    git clone https://github.com/Kalaszka/codex-web-dev-skill.git "$CODEX_SKILLS_DIR/codex-web-dev-skill"
fi

# Copy the skill config to skills directory
echo -e "${YELLOW}Configuring skill...${NC}"
cp "$CODEX_SKILLS_DIR/codex-web-dev-skill/codex-web-dev-skill.toml" "$CODEX_SKILLS_DIR/"

# Verify installation
echo -e "${YELLOW}Verifying installation...${NC}"
if [ -f "$CODEX_SKILLS_DIR/codex-web-dev-skill.toml" ]; then
    echo -e "${GREEN}✓ Skill configuration installed${NC}"
else
    echo -e "${RED}✗ Installation failed${NC}"
    exit 1
fi

# Check Codex config file
if [ "$OS" = "macos" ]; then
    CODEX_CONFIG="$HOME/.codex/config.toml"
elif [ "$OS" = "linux" ]; then
    CODEX_CONFIG="${XDG_CONFIG_HOME:=$HOME/.config}/codex/config.toml"
fi

echo -e "${YELLOW}Checking Codex configuration...${NC}"
if [ -f "$CODEX_CONFIG" ]; then
    if grep -q "codex-web-dev-skill" "$CODEX_CONFIG"; then
        echo -e "${GREEN}✓ Skill already in config${NC}"
    else
        echo -e "${YELLOW}Adding skill to config...${NC}"
        # Backup config
        cp "$CODEX_CONFIG" "$CODEX_CONFIG.backup"
        # Add skill to active list (requires manual TOML editing)
        echo -e "${YELLOW}⚠ Please manually add 'codex-web-dev-skill' to [skills] active list in $CODEX_CONFIG${NC}"
    fi
else
    echo -e "${YELLOW}⚠ Codex config not found at $CODEX_CONFIG${NC}"
    echo -e "${YELLOW}Please create it and add: [skills]\nactive = [\"codex-web-dev-skill\"]${NC}"
fi

echo -e "${GREEN}=== Installation Complete ===${NC}"
echo -e "${GREEN}Skill installed at: $CODEX_SKILLS_DIR/codex-web-dev-skill${NC}"
echo -e "${YELLOW}Next: Add 'codex-web-dev-skill' to your Codex config and restart Codex${NC}"

# Machine info
echo -e "${YELLOW}Machine Information:${NC}"
echo "Hostname: $(hostname)"
echo "OS: $OS"
if command -v tailscale &> /dev/null; then
    echo "Tailscale IP: ${TAILSCALE_IP:-disconnected}"
fi
