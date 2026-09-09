# Codex Web Dev Skill - Claude Code TUI Harness

This document provides prompts and commands for integrating the Codex Web Dev Skill with your Claude Code TUI harness.

## Installation Prompt for Claude Code TUI

### Universal Multi-Machine Installation

```prompt
@install-codex-skill

Install the Codex Web Development Master Skill on all 3 of my machines (macOS, Linux, Windows) using Tailscale for sync.

Repositories to integrate:
- https://github.com/Kalaszka/codex-web-dev-skill (main skill)
- https://github.com/VoltAgent/awesome-codex-subagents (170+ agents)
- https://github.com/axiaoge2/apple-hig-designer (Apple HIG)
- https://github.com/ehmo/platform-design-skills (design rules)
- https://github.com/tiangolo/full-stack-fastapi-postgresql (fullstack template)
- https://github.com/gothinkster/realworld (reference examples)
- https://github.com/donnemartin/system-design-primer (system design)
- https://github.com/kamranahmedse/developer-roadmap (learning paths)

Instructions:
1. Run the platform-specific installation scripts
2. Configure Tailscale sync between machines
3. Activate the skill in Codex config on all machines
4. Verify installation across all 3 machines
5. Report status and any issues
```

## CLI Commands for Claude Code TUI

### Deploy to All Machines

```bash
# Copy this command into your Claude Code TUI harness
codex-deploy() {
  local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  
  echo "🚀 Starting Codex Web Dev Skill deployment..."
  
  # Detect OS and run appropriate script
  case "$(uname -s)" in
    Linux|Darwin)
      bash "$script_dir/deploy/install-macos-linux.sh"
      ;;
    MINGW*|MSYS*|CYGWIN*)
      cmd /c "$script_dir/deploy/install-windows.bat"
      ;;
    *)
      echo "Unsupported OS"
      return 1
      ;;
  esac
  
  # If Tailscale is available, attempt multi-machine sync
  if command -v tailscale &> /dev/null; then
    echo "📡 Syncing to Tailscale peers..."
    bash "$script_dir/deploy/tailscale-deploy.sh"
  fi
}

# Run it
codex-deploy
```

### Quick Verify Status

```bash
codex-status() {
  local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  bash "$script_dir/deploy/sync-status.sh"
}

codex-status
```

## Claude Code TUI Configuration

### Add to Your TUI Config

If your Claude Code TUI uses a configuration file (e.g., `.codex-tui.yaml`):

```yaml
harness:
  name: "codex-web-dev-skill"
  version: "1.0.0"
  
  installation:
    local: "bash deploy/install-macos-linux.sh"  # For macOS/Linux
    windows: "cmd /c deploy/install-windows.bat"  # For Windows
    sync: "bash deploy/tailscale-deploy.sh"       # Tailscale sync
    verify: "bash deploy/sync-status.sh"          # Status check
  
  repositories:
    - name: "codex-web-dev-skill"
      url: "https://github.com/Kalaszka/codex-web-dev-skill"
      type: "skill"
      critical: true
    
    - name: "awesome-codex-subagents"
      url: "https://github.com/VoltAgent/awesome-codex-subagents"
      type: "agents"
      count: 170
    
    - name: "apple-hig-designer"
      url: "https://github.com/axiaoge2/apple-hig-designer"
      type: "design"
    
    - name: "platform-design-skills"
      url: "https://github.com/ehmo/platform-design-skills"
      type: "design"
    
    - name: "full-stack-fastapi-postgresql"
      url: "https://github.com/tiangolo/full-stack-fastapi-postgresql"
      type: "template"
    
    - name: "realworld"
      url: "https://github.com/gothinkster/realworld"
      type: "reference"
    
    - name: "system-design-primer"
      url: "https://github.com/donnemartin/system-design-primer"
      type: "reference"
    
    - name: "developer-roadmap"
      url: "https://github.com/kamranahmedse/developer-roadmap"
      type: "reference"
  
  tailscale:
    enabled: true
    networks: 3
    machines:
      - name: "machine-1"
        os: "macos"
        role: "primary"
      - name: "machine-2"
        os: "linux"
        role: "secondary"
      - name: "machine-3"
        os: "windows"
        role: "secondary"
  
  activation:
    auto: false
    manual: true
    prompt: "Add 'codex-web-dev-skill' to [skills] active list in your Codex config"
```

## Python Integration for Claude Code TUI

```python
#!/usr/bin/env python3
# codex_harness.py - Integration script for Claude Code TUI

import subprocess
import os
import json
import platform
from pathlib import Path

class CodexHarness:
    def __init__(self):
        self.script_dir = Path(__file__).parent
        self.os_type = platform.system()
    
    def get_codex_skills_dir(self):
        if self.os_type == "Darwin":  # macOS
            return Path.home() / ".codex" / "skills"
        elif self.os_type == "Linux":
            return Path.home() / ".config" / "codex" / "skills"
        elif self.os_type == "Windows":
            return Path.home() / "AppData" / "Roaming" / ".codex" / "skills"
    
    def install_skill(self):
        """Install the Codex Web Dev Skill"""
        print(f"🚀 Installing Codex Web Dev Skill on {self.os_type}...")
        
        if self.os_type in ["Darwin", "Linux"]:
            script = self.script_dir / "deploy" / "install-macos-linux.sh"
            subprocess.run(["bash", str(script)], check=True)
        elif self.os_type == "Windows":
            script = self.script_dir / "deploy" / "install-windows.bat"
            subprocess.run(["cmd", "/c", str(script)], check=True)
    
    def sync_tailscale(self):
        """Sync skill to Tailscale peers"""
        print("📡 Syncing to Tailscale network...")
        script = self.script_dir / "deploy" / "tailscale-deploy.sh"
        subprocess.run(["bash", str(script)], check=True)
    
    def check_status(self):
        """Check installation status"""
        print("📊 Checking status...")
        script = self.script_dir / "deploy" / "sync-status.sh"
        subprocess.run(["bash", str(script)], check=True)
    
    def get_skill_info(self):
        """Get skill information"""
        skill_dir = self.get_codex_skills_dir() / "codex-web-dev-skill"
        toml_file = skill_dir / "codex-web-dev-skill.toml"
        
        info = {
            "installed": skill_dir.exists(),
            "path": str(skill_dir),
            "config_file": str(toml_file) if toml_file.exists() else None
        }
        
        if toml_file.exists():
            with open(toml_file, 'r') as f:
                content = f.read()
                for line in content.split('\n'):
                    if line.startswith('version'):
                        info['version'] = line.split('=')[1].strip().strip('"')
                    elif line.startswith('name'):
                        info['name'] = line.split('=')[1].strip().strip('"')
        
        return info

if __name__ == "__main__":
    import sys
    
    harness = CodexHarness()
    
    if len(sys.argv) < 2:
        print("Usage: codex_harness.py [install|sync|status|info]")
        sys.exit(1)
    
    command = sys.argv[1]
    
    if command == "install":
        harness.install_skill()
    elif command == "sync":
        harness.sync_tailscale()
    elif command == "status":
        harness.check_status()
    elif command == "info":
        print(json.dumps(harness.get_skill_info(), indent=2))
    else:
        print(f"Unknown command: {command}")
        sys.exit(1)
```

## Usage in Claude Code TUI

### Option 1: Direct CLI Command
```bash
python3 codex_harness.py install
python3 codex_harness.py sync
python3 codex_harness.py status
```

### Option 2: Bash Function
```bash
codex-deploy() {
  python3 "$(dirname "$0")/codex_harness.py" install && \
  python3 "$(dirname "$0")/codex_harness.py" sync && \
  python3 "$(dirname "$0")/codex_harness.py" status
}

codex-deploy
```

## Full Setup Command

**Copy this entire prompt into your Claude Code TUI:**

```
@setup-codex-fleet

Setup and deploy the Codex Web Development Master Skill to my 3-machine fleet:

1. CLONE REPOSITORY
   git clone https://github.com/Kalaszka/codex-web-dev-skill.git ~/codex-web-dev-skill
   cd ~/codex-web-dev-skill

2. INSTALL LOCALLY
   # Run the appropriate script for your OS
   bash deploy/install-macos-linux.sh   # For macOS/Linux
   # or
   cmd /c deploy/install-windows.bat    # For Windows

3. DEPLOY ACROSS NETWORK
   bash deploy/tailscale-deploy.sh

4. VERIFY INSTALLATION
   bash deploy/sync-status.sh

5. CONFIGURE CODEX
   # Edit your ~/.codex/config.toml (or equivalent)
   [skills]
   active = ["codex-web-dev-skill"]

6. RESTART CODEX
   codex restart

Done! The skill is now active across all 3 machines.
```

---

## Troubleshooting

### Tailscale Not Syncing
```bash
# Check Tailscale status
tailscale status

# Check if peers are online
tailscale status --json | jq '.Peer[] | .HostName, .Online'

# Test connectivity
ping <peer-tailscale-ip>
```

### Skill Not Activating
```bash
# Check if skill is in correct directory
ls -la ~/.codex/skills/codex-web-dev-skill.toml

# Verify Codex config
cat ~/.codex/config.toml | grep -A 5 "\[skills\]"

# Restart Codex
codex restart
codex --skills list
```

### Windows Installation Issues
```bat
REM Check if scripts have execute permission
dir deploy\install-windows.bat

REM Run with elevated privileges if needed
runas /user:Administrator "cmd /c deploy\install-windows.bat"
```

---

**Happy deploying! 🚀**
