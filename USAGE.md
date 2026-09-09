# Detailed Usage Guide

## Installation & Setup

### Step 1: Locate Your Codex Skill Directory

```bash
# For macOS/Linux
ls ~/.codex/skills/

# For Windows
dir %APPDATA%\.codex\skills\
```

### Step 2: Install the Skill

**Option A: Manual Installation**
```bash
cd ~/.codex/skills/
git clone https://github.com/Kalaszka/codex-web-dev-skill.git
cp codex-web-dev-skill/codex-web-dev-skill.toml .
```

**Option B: Direct File Copy**
```bash
wget https://raw.githubusercontent.com/Kalaszka/codex-web-dev-skill/main/codex-web-dev-skill.toml
mv codex-web-dev-skill.toml ~/.codex/skills/
```

### Step 3: Enable in Codex Config

Edit your Codex configuration file:

```toml
# ~/.codex/config.toml or similar
[skills]
active = ["codex-web-dev-skill"]
priority = ["codex-web-dev-skill", "default"]
```

### Step 4: Verify Installation

```bash
codex --skills list
# Should show: codex-web-dev-skill (v1.0.0)
```

---

## Command Reference

### Auto-Invoke Keywords

Just mention these in your requests to trigger specific agents:

#### Frontend Development
```
"I need a React component for..."
"Build a Vue.js dashboard..."
"Create an Angular form..."
"Design a CSS layout..."
"Optimize frontend performance..."
```
→ **Activates:** frontend-developer + Apple-HIG-Designer

#### Backend Development
```
"Create a REST API endpoint..."
"Design a database schema..."
"Set up authentication..."
"Build a microservice..."
"Optimize database queries..."
```
→ **Activates:** backend-developer + system-design-primer

#### Full-Stack Projects
```
"I'm starting a new full-stack project..."
"Build a complete SaaS application..."
"Create an end-to-end feature..."
```
→ **Activates:** All agents + templates + best practices

#### Design & UX
```
"Design a component following Apple HIG..."
"Make this accessible and beautiful..."
"Check HIG compliance..."
```
→ **Activates:** Apple-HIG-Designer + platform-design-skills

#### Code Quality
```
"Review this code for quality..."
"Check for security issues..."
"Optimize performance..."
"Refactor this function..."
```
→ **Activates:** code-reviewer

#### DevOps & Deployment
```
"Set up Docker deployment..."
"Configure GitHub Actions CI/CD..."
"Deploy to production..."
```
→ **Activates:** devops-engineer

---

## Real-World Examples

### Example 1: Building a Login Component

**Input:**
```
Create a React login component with email and password fields,
following Apple design principles. Include validation and error handling.
```

**Skill Output:**
- ✅ Code following HIG design guidelines
- ✅ Apple-style color palette and typography
- ✅ Accessibility considerations (ARIA labels, keyboard nav)
- ✅ Error state designs
- ✅ Best practices for form security
- ✅ References to HIG documentation

---

### Example 2: Designing a Scalable API

**Input:**
```
Design a user management API that can scale to 1M users.
Include authentication, role-based access, and audit logging.
```

**Skill Output:**
- ✅ FastAPI/Node.js/Python best practices
- ✅ Database schema design for scalability
- ✅ Authentication patterns (JWT, OAuth2)
- ✅ Caching strategies
- ✅ Rate limiting & security
- ✅ Monitoring & logging setup
- ✅ System design diagrams

---

### Example 3: Full-Stack Project Bootstrap

**Input:**
```
I'm starting a new SaaS product for project management.
It needs a modern React frontend and a Python backend.
```

**Skill Output:**
- ✅ Full-stack architecture recommendation
- ✅ Technology stack (FastAPI, React, PostgreSQL)
- ✅ Project structure & folder organization
- ✅ Setup instructions
- ✅ Development & production configurations
- ✅ CI/CD pipeline templates (GitHub Actions)
- ✅ Docker setup
- ✅ Database migrations strategy
- ✅ Authentication flow
- ✅ Apple HIG compliance checklist for UI

---

## Customization

### Add Custom Triggers

Edit `codex-web-dev-skill.toml`:

```toml
[[plugins.agents]]
name = "my-custom-agent"
repo = "my-org/my-agent"
description = "My specialized agent"
trigger = ["my-keyword", "another-trigger"]
```

### Modify Behavior Rules

```toml
[[behaviors.rules]]
condition = "user works on mobile app"
actions = [
  "invoke:frontend-developer",
  "invoke:Apple-HIG-Designer",
  "invoke:code-reviewer"
]
```

### Change Output Style

```toml
[output_style]
format = "detailed"  # or "concise", "verbose"
include_templates = true
include_best_practices = true
include_security_notes = true
include_performance_tips = true
```

---

## Troubleshooting

### Skill Not Activating

**Problem:** Commands don't trigger agents  
**Solution:**
```bash
# 1. Verify skill is installed
codex --skills list

# 2. Check syntax
toml-lint codex-web-dev-skill.toml

# 3. Restart Codex
codex restart
```

### Wrong Agent Being Invoked

**Problem:** Wrong plugin activated for your request  
**Solution:**
- Be more specific in your request (include framework names)
- Check trigger keywords in TOML config
- Use explicit commands: "As a backend-developer, ..."

### Plugin Reference Broken

**Problem:** Link to external repo returns 404  
**Solution:**
- Verify repos still exist: Visit GitHub URL directly
- Update repo URL in config if it moved
- Check internet connection

---

## Performance Tips

1. **Be Specific** - More specific requests = faster, better responses
   ```
   ❌ "Help me build a web app"
   ✅ "Create a React component for product listing with filters and pagination"
   ```

2. **Use Context** - Provide framework/language when possible
   ```
   ❌ "Create an API"
   ✅ "Create a FastAPI endpoint for user authentication using JWT"
   ```

3. **Leverage Templates** - Ask for templates when starting projects
   ```
   "Give me the full-stack-fastapi-postgresql template setup"
   ```

---

## Advanced Usage

### Chaining Commands

```
1. "Generate the full-stack template for my project"
2. "Now create a login page following Apple HIG"
3. "Write the FastAPI authentication endpoint"
4. "Review the code for security issues"
5. "Set up Docker and GitHub Actions for CI/CD"
```

### Context Preservation

The skill remembers your project context across requests:

```
👤: "I'm building a SaaS app for team collaboration"
🤖: [Activates full-stack mode]
👤: "Now add real-time notifications"
🤖: [Remembers SaaS context, suggests WebSocket patterns]
👤: "Make the UI match Apple HIG"
🤖: [Applies HIG to existing UI context]
```

### Multi-File Generation

Request multiple files at once:

```
"Generate:
- React component with hooks
- Corresponding TypeScript types  
- Unit tests with Jest
- Apple HIG design documentation

All following best practices"
```

---

## Best Practices

✅ **DO:**
- Use specific technology names (React, FastAPI, PostgreSQL)
- Mention project requirements upfront
- Ask for templates when starting projects
- Request code reviews for security-critical code
- Include accessibility/HIG in design requests

❌ **DON'T:**
- Use vague requests ("help me code")
- Omit context about your project
- Skip security considerations
- Ignore HIG for user-facing features
- Request huge monolithic files

---

## Getting Help

1. **Documentation** → See [README.md](README.md)
2. **Plugins** → See [PLUGINS.md](PLUGINS.md)
3. **Examples** → See [EXAMPLES/](EXAMPLES/)
4. **Templates** → See [TEMPLATES/](TEMPLATES/)
5. **Issues** → GitHub Issues on this repo

---

**Happy coding! 🚀**
