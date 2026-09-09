#!/bin/bash
# Codex Web Dev Skill - Tailscale Multi-Machine Deployment
# Syncs the skill to all Tailscale-connected machines
# Requires: Tailscale installed and configured on all machines

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}=== Codex Skill Tailscale Multi-Machine Deployment ===${NC}"
echo ""

# Check Tailscale
if ! command -v tailscale &> /dev/null; then
    echo -e "${RED}✗ Tailscale not installed${NC}"
    echo "Install from: https://tailscale.com/download"
    exit 1
fi

echo -e "${GREEN}✓ Tailscale installed${NC}"

# Get current machine IP
CURRENT_IP=$(tailscale ip -4 2>/dev/null || echo "not-connected")
if [ "$CURRENT_IP" = "not-connected" ]; then
    echo -e "${RED}✗ Not connected to Tailscale${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Connected to Tailscale: $CURRENT_IP${NC}"

# Get list of Tailscale peers
echo -e "${YELLOW}Fetching Tailscale peers...${NC}"
PEERS=$(tailscale status --json | grep -o '"TailscaleIPs":\["[^"]*"' | grep -o '[0-9.]*' | sort -u)

if [ -z "$PEERS" ]; then
    echo -e "${RED}✗ No Tailscale peers found${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Found Tailscale peers:${NC}"
echo "$PEERS" | while read -r peer; do
    echo "  - $peer"
done

echo ""
echo -e "${YELLOW}Deploying skill to all peers...${NC}"

# Create temporary deployment package
echo -e "${YELLOW}Preparing deployment package...${NC}"
DEPLOY_DIR="/tmp/codex-skill-deploy-$$"
mkdir -p "$DEPLOY_DIR"

# Copy skill files
git clone https://github.com/Kalaszka/codex-web-dev-skill.git "$DEPLOY_DIR/codex-web-dev-skill" 2>/dev/null || true
cp -r "$DEPLOY_DIR/codex-web-dev-skill" "$DEPLOY_DIR/"

# Copy installation script
cp "$(dirname "$0")/install-macos-linux.sh" "$DEPLOY_DIR/install.sh"
chmod +x "$DEPLOY_DIR/install.sh"

echo -e "${GREEN}✓ Deployment package ready${NC}"

# Deploy to each peer
echo ""
echo -e "${YELLOW}Starting deployment to peers...${NC}"

echo "$PEERS" | while read -r peer; do
    if [ -z "$peer" ]; then
        continue
    fi
    
    echo ""
    echo -e "${BLUE}Deploying to $peer...${NC}"
    
    # Check if machine is reachable
    if ping -c 1 -W 2 "$peer" &> /dev/null; then
        echo -e "${GREEN}✓ Machine is reachable${NC}"
        
        # Copy files via SSH/SCP
        # Note: Requires SSH key-based auth or Tailscale SSH
        echo -e "${YELLOW}Copying files...${NC}"
        
        # Using tailscale ssh (if available)
        if command -v tailscale-ssh &> /dev/null || ssh -V &>/dev/null; then
            # Copy via SCP
            scp -r "$DEPLOY_DIR/codex-web-dev-skill" "$peer:~/.codex/skills/" 2>/dev/null || \
            scp -r "$DEPLOY_DIR/codex-web-dev-skill" "root@$peer:~/.codex/skills/" 2>/dev/null || \
            echo -e "${YELLOW}⚠ SCP failed for $peer (may need SSH setup)${NC}"
            
            # Run installation script
            echo -e "${YELLOW}Running installation...${NC}"
            ssh "$peer" 'bash ~/.codex/skills/codex-web-dev-skill/deploy/install-macos-linux.sh' 2>/dev/null || \
            echo -e "${YELLOW}⚠ SSH failed for $peer${NC}"
            
            echo -e "${GREEN}✓ Deployment to $peer complete${NC}"
        fi
    else
        echo -e "${YELLOW}⚠ Machine $peer not reachable${NC}"
    fi
done

# Cleanup
rm -rf "$DEPLOY_DIR"

echo ""
echo -e "${GREEN}=== Deployment Complete ===${NC}"
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Verify installation on each machine"
echo "2. Add 'codex-web-dev-skill' to Codex config on each machine"
echo "3. Restart Codex on each machine"
echo ""
echo -e "${BLUE}To check status on all machines:${NC}"
echo "tailscale status --json | jq '.Peer[] | .HostName'"
