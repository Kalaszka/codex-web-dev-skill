#!/bin/bash
# Codex Web Dev Skill - Sync Status Monitor
# Checks installation status across all Tailscale-connected machines

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}=== Codex Skill Sync Status Monitor ===${NC}"
echo ""

# Check Tailscale
if ! command -v tailscale &> /dev/null; then
    echo -e "${RED}✗ Tailscale not installed${NC}"
    exit 1
fi

# Get local status
echo -e "${BLUE}Local Machine:${NC}"
HOSTNAME=$(hostname)
echo "Hostname: $HOSTNAME"

if [[ "$OSTYPE" == "darwin"* ]]; then
    CODEX_SKILLS_DIR="$HOME/.codex/skills"
else
    CODEX_SKILLS_DIR="${XDG_CONFIG_HOME:=$HOME/.config}/codex/skills"
fi

if [ -d "$CODEX_SKILLS_DIR/codex-web-dev-skill" ]; then
    echo -e "${GREEN}✓ Skill installed${NC}"
    INSTALLED_VERSION=$(cat "$CODEX_SKILLS_DIR/codex-web-dev-skill/codex-web-dev-skill.toml" | grep '^version' | head -1)
    echo "  Version: ${INSTALLED_VERSION#*=}"
else
    echo -e "${RED}✗ Skill not installed${NC}"
fi

echo ""
echo -e "${BLUE}Tailscale Network Status:${NC}"

# Get Tailscale status
tailscale status

echo ""
echo -e "${BLUE}Checking remote machines...${NC}"

# Get list of peers
PEERS=$(tailscale status --json 2>/dev/null | python3 -c "import sys, json; data=json.load(sys.stdin); print('\n'.join([p.get('HostName', p.get('TailIP', '')) for p in data.get('Peer', [])]))" 2>/dev/null || echo "")

if [ -z "$PEERS" ]; then
    echo -e "${YELLOW}No peers found${NC}"
else
    echo "$PEERS" | while read -r peer; do
        if [ -z "$peer" ]; then
            continue
        fi
        
        echo ""
        echo -e "${BLUE}Machine: $peer${NC}"
        
        if ping -c 1 -W 2 "$peer" &> /dev/null 2>&1; then
            echo -e "${GREEN}✓ Reachable${NC}"
            
            # Check if skill installed (requires SSH access)
            ssh "$peer" "test -d ~/.codex/skills/codex-web-dev-skill && echo '✓ Skill installed' || echo '✗ Skill not installed'" 2>/dev/null || echo -e "${YELLOW}⚠ Cannot verify (SSH not available)${NC}"
        else
            echo -e "${RED}✗ Not reachable${NC}"
        fi
    done
fi

echo ""
echo -e "${GREEN}=== Status Check Complete ===${NC}"
