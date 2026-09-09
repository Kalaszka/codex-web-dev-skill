# Codex Web Development Master Skill

A comprehensive Codex skill that auto-invokes all best-in-class web development plugins, agents, and design systems whenever you're creating something for web or programming.

## Features

✅ **Auto-invokes specialized agents** for frontend, backend, and full-stack development  
✅ **Apple HIG design integration** for beautiful, accessible interfaces  
✅ **Code quality & security reviews** automatically triggered  
✅ **DevOps & CI/CD assistance** for deployment workflows  
✅ **170+ pre-configured Codex agents** from awesome-codex-subagents  
✅ **Production-ready templates** (FastAPI + React + PostgreSQL)  
✅ **System design & scalability guidance** built-in  
✅ **Best practices & architecture patterns** at your fingertips  

## Quick Start

### Installation

1. **Copy the skill configuration** to your Codex workspace:
   ```bash
   cp codex-web-dev-skill.toml ~/.codex/skills/
   ```

2. **Activate the skill** in your Codex configuration:
   ```toml
   [skills]
   active = ["codex-web-dev-skill"]
   ```

3. **Restart Codex** and start building!

### Usage

Just start coding or describing your project. The skill automatically invokes relevant agents:

```
👤 "I'm starting a new React + FastAPI full-stack app for a SaaS platform"
🤖 Skill automatically activates:
   ✓ fullstack-developer agent
   ✓ Apple-HIG-Designer for UI/UX
   ✓ frontend-developer for React best practices
   ✓ backend-developer for FastAPI patterns
   ✓ system-design-primer for architecture
   ✓ Suggests fullstack-template as starter
```

## Included Agents & Plugins

### Development Agents (from awesome-codex-subagents)
- **frontend-developer** - React, Vue, Angular, CSS, performance
- **backend-developer** - APIs, databases, authentication, microservices
- **fullstack-developer** - End-to-end architecture and integration
- **code-reviewer** - Quality, security, performance audits
- **devops-engineer** - CI/CD, Docker, deployment, infrastructure

### Design Plugins
- **Apple-HIG-Designer** - Apple Human Interface Guidelines for web/mobile
- **platform-design-skills** - 450+ design rules (Apple HIG + Material Design + WCAG)

### Reference & Learning
- **fullstack-template** - FastAPI + React + PostgreSQL production starter
- **realworld-example** - Multi-framework reference implementations
- **system-design-primer** - Backend architecture & scalability patterns
- **developer-roadmap** - Visual learning paths

## Auto-Invoke Behavior

The skill intelligently activates agents based on context:

| Trigger | Agents Invoked |
|---------|----------------|
| Creating new web project | fullstack, HIG-Designer, template suggestions |
| Working on frontend/UI | frontend-developer, HIG-Designer, design-skills |
| Developing backend/APIs | backend-developer, system-design-primer |
| Writing code | code-reviewer (quality checks) |
| Setup deployment/CI-CD | devops-engineer |

## Example Workflows

### Frontend Development
```
👤 "Create a React login component with Apple HIG design"
🤖 Activates: frontend-developer + Apple-HIG-Designer
📋 Returns: Code following HIG principles, accessibility notes, design tokens
```

### Backend Architecture
```
👤 "Design a scalable authentication system for 1M users"
🤖 Activates: backend-developer + system-design-primer
📋 Returns: Architecture patterns, database design, security best practices
```

### Full-Stack Project Setup
```
👤 "I'm starting a new SaaS product"
🤖 Activates: fullstack-developer + all agents
📋 Returns: Project structure, tech stack recommendations, templates, checklists
```

## Configuration

Edit `codex-web-dev-skill.toml` to customize:

- **Trigger keywords** - Words that activate specific agents
- **Behavior rules** - When agents should auto-invoke
- **Output style** - How results are formatted
- **Plugin priorities** - Which agents take precedence

## Requirements

- Codex or GitHub Copilot (latest version)
- TOML skill format support
- Internet access for plugin references

## File Structure

```
codex-web-dev-skill/
├── codex-web-dev-skill.toml    # Main skill configuration
├── README.md                    # This file
├── USAGE.md                     # Detailed usage guide
├── PLUGINS.md                   # Plugin documentation
├── TEMPLATES/
│   ├── fullstack-setup.md       # Full-stack project setup guide
│   ├── api-design.md            # API design checklist
│   └── hig-checklist.md         # Apple HIG compliance checklist
└── EXAMPLES/
    ├── react-component.example  # React component example
    ├── fastapi-api.example      # FastAPI endpoint example
    └── system-design.example    # System design example
```

## Contributing

Contributions welcome! Areas for improvement:
- Additional framework support (Next.js, Svelte, Go, Rust, etc.)
- More design system integrations (Material Design, Tailwind, etc.)
- Additional code quality tools and security scanners
- Performance optimization guides
- Database design patterns

## License

MIT - Free to use and modify

## Support

For issues or questions:
1. Check [USAGE.md](USAGE.md) for detailed guides
2. Review [PLUGINS.md](PLUGINS.md) for plugin documentation
3. See [EXAMPLES/](EXAMPLES/) for sample code
4. Open an issue on GitHub

---

**Built with ❤️ for web developers using Codex**
