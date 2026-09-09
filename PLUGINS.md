# Plugin & Agent Documentation

## Development Agents

### Frontend Developer
**Source:** [VoltAgent/awesome-codex-subagents](https://github.com/VoltAgent/awesome-codex-subagents)

**Specialties:**
- React, Vue.js, Angular, Svelte
- CSS, SASS, Tailwind, styled-components
- State management (Redux, Vuex, Context)
- Component design patterns
- Performance optimization
- Responsive design
- Browser compatibility

**Triggers:**
- "Create a React component..."
- "Build a Vue.js..."
- "Make this responsive..."
- "Optimize frontend performance..."
- "CSS styling for..."

**Example Output:**
```typescript
// Generates production-ready React components with:
- TypeScript types
- Error boundaries
- Accessibility (ARIA)
- Performance optimizations
- Unit tests
- Storybook documentation
```

---

### Backend Developer
**Source:** [VoltAgent/awesome-codex-subagents](https://github.com/VoltAgent/awesome-codex-subagents)

**Specialties:**
- FastAPI, Django, Flask (Python)
- Express, NestJS (Node.js)
- Database design (PostgreSQL, MongoDB)
- REST API design
- Authentication & authorization
- Microservices architecture
- Caching & performance
- Security best practices

**Triggers:**
- "Create a REST API..."
- "Design a database schema..."
- "Set up authentication..."
- "Build a FastAPI endpoint..."
- "Optimize database queries..."

**Example Output:**
```python
# Generates production-ready FastAPI code with:
- Proper request/response validation
- Database models & migrations
- Authentication (JWT/OAuth2)
- Error handling
- API documentation (Swagger)
- Unit & integration tests
```

---

### Full-Stack Developer
**Source:** [VoltAgent/awesome-codex-subagents](https://github.com/VoltAgent/awesome-codex-subagents)

**Specialties:**
- End-to-end feature development
- Frontend-backend integration
- State synchronization
- API contract definition
- Database schema with UI flows
- Full-stack testing strategies
- Deployment orchestration

**Triggers:**
- "Build a complete feature..."
- "Create user authentication flow..."
- "End-to-end project setup..."
- "Full-stack integration..."

**Example Output:**
```
Generates:
- React components with hooks
- FastAPI endpoints
- Database migrations
- API types/contracts
- Integration tests
- Deployment configs
```

---

### Code Reviewer
**Source:** [VoltAgent/awesome-codex-subagents](https://github.com/VoltAgent/awesome-codex-subagents)

**Specialties:**
- Code quality analysis
- Security vulnerability detection
- Performance profiling
- Testing coverage
- Best practices enforcement
- Refactoring suggestions
- Documentation review

**Triggers:**
- "Review this code..."
- "Check for security issues..."
- "Optimize performance..."
- "Refactor this function..."
- "Is this following best practices?..."

**Example Output:**
```
Generates:
✓ Security audit report
✓ Performance recommendations
✓ Code quality issues
✓ Test coverage analysis
✓ Refactoring suggestions
✓ Best practices violations
```

---

### DevOps Engineer
**Source:** [VoltAgent/awesome-codex-subagents](https://github.com/VoltAgent/awesome-codex-subagents)

**Specialties:**
- Docker & containerization
- Kubernetes orchestration
- CI/CD pipelines (GitHub Actions, GitLab CI)
- Infrastructure as Code (Terraform)
- Deployment strategies
- Monitoring & logging
- Environment configuration

**Triggers:**
- "Set up Docker..."
- "Configure CI/CD..."
- "Deploy to production..."
- "Create GitHub Actions workflow..."
- "Infrastructure setup..."

**Example Output:**
```yaml
Generates:
- Dockerfiles (optimized, multi-stage)
- docker-compose.yml
- GitHub Actions workflows
- Kubernetes manifests
- Environment configurations
- Deployment guides
```

---

## Design Plugins

### Apple HIG Designer
**Source:** [axiaoge2/Apple-Hig-Designer](https://github.com/axiaoge2/apple-hig-designer)

**Specialties:**
- Apple Human Interface Guidelines compliance
- iOS & macOS design patterns
- SF Pro typography & system fonts
- Apple color palettes
- Accessibility (VoiceOver, dynamic text)
- Interaction patterns (swipe, tap, gesture)
- Dark mode support
- System-level design tokens

**Triggers:**
- "Design following Apple HIG..."
- "Create an Apple-style component..."
- "Make this accessible..."
- "Follow HIG principles..."
- "Use SF Pro font..."

**Example Output:**
```jsx
// React component with:
- HIG-compliant colors
- SF Pro typography
- Proper spacing (8pt grid)
- Accessibility labels
- Dark mode support
- Touch targets (min 44x44pt)
- Haptic feedback recommendations
```

**Key Resources:**
- [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- SF Pro font guidelines
- Accessibility requirements (WCAG AAA for HIG)

---

### Platform Design Skills
**Source:** [ehmo/platform-design-skills](https://github.com/ehmo/platform-design-skills)

**Specialties:**
- 450+ design rules for multiple systems:
  - Apple Human Interface Guidelines
  - Material Design (Google)
  - WCAG 2.1 Accessibility
- Cross-platform design consistency
- Responsive design patterns
- Color contrast validation
- Keyboard navigation
- Screen reader optimization

**Triggers:**
- "Design system patterns..."
- "Ensure accessibility (WCAG)..."
- "Cross-platform design..."
- "Design tokens setup..."

**Example Output:**
```
Generates:
✓ Design system documentation
✓ Component specifications
✓ Color palette with contrast checks
✓ Typography scale
✓ Spacing system
✓ Accessibility audit
✓ Material Design or HIG mappings
```

---

## Reference & Learning Plugins

### Full-Stack Template
**Source:** [tiangolo/full-stack-fastapi-postgresql](https://github.com/tiangolo/full-stack-fastapi-postgresql)

**Includes:**
- FastAPI backend (production-ready)
- React frontend (TypeScript)
- PostgreSQL database
- Docker & docker-compose
- GitHub Actions CI/CD
- Email functionality
- User authentication & authorization
- Testing setup (pytest)
- Development and production configs

**Use When:**
- Starting a new full-stack project
- Need a boilerplate
- Want production-ready setup
- Learning best practices

**Commands:**
```bash
git clone https://github.com/tiangolo/full-stack-fastapi-postgresql
cd full-stack-fastapi-postgresql
cp -r . my-project/
# Follow setup instructions
```

---

### RealWorld Example
**Source:** [gothinkster/realworld](https://github.com/gothinkster/realworld)

**Specialties:**
- Same app built in multiple frameworks:
  - React, Vue, Angular, Svelte (frontend)
  - Node, Python, Java, Go, Rust (backend)
- Production patterns
- API contracts
- Best practices per framework
- Testing strategies

**Use When:**
- Comparing framework approaches
- Learning best practices
- Evaluating technology choices
- Understanding full-stack patterns

**Example:** Explore how authentication is implemented in:
- React + Node.js
- Vue + Python
- Angular + Java
- etc.

---

### System Design Primer
**Source:** [donnemartin/system-design-primer](https://github.com/donnemartin/system-design-primer)

**Specialties:**
- Scalable system architecture
- Database design patterns
- Caching strategies (Redis, memcached)
- Load balancing
- Microservices patterns
- Message queues
- Search engines
- Security & authentication
- Monitoring & logging

**Use When:**
- Designing backend systems
- Planning for scale
- Database schema design
- Performance optimization
- Interview preparation

**Topics Covered:**
- Vertical vs horizontal scaling
- Database sharding
- Replication
- Cache invalidation
- Concurrency
- Networking
- Availability & reliability

---

### Developer Roadmap
**Source:** [kamranahmedse/developer-roadmap](https://github.com/kamranahmedse/developer-roadmap)

**Specialties:**
- Visual learning paths
- Technology recommendations
- Skill progression
- Frontend roadmap
- Backend roadmap
- DevOps roadmap
- Database roadmap
- Free learning resources

**Use When:**
- Learning new technologies
- Planning skill development
- Understanding technology ecosystem
- Career growth planning

**Roadmaps Available:**
- Frontend Development
- Backend Development
- DevOps
- React Specialist
- Node.js Specialist
- Python
- Go
- Rust
- System Design

---

## Plugin Compatibility Matrix

| Use Case | Agents | Plugins |
|----------|--------|----------|
| New Full-Stack Project | fullstack, frontend, backend | All |
| React Component | frontend | Apple-HIG-Designer |
| API Design | backend | system-design-primer |
| Code Review | code-reviewer | N/A |
| CI/CD Setup | devops | N/A |
| Design System | frontend | platform-design-skills |
| Learning Path | N/A | developer-roadmap |
| Reference | N/A | realworld |

---

## Custom Plugin Installation

To add your own plugin:

1. **Create or find the plugin repo**
2. **Add to `codex-web-dev-skill.toml`:**
   ```toml
   [[plugins.custom]]
   name = "my-plugin"
   repo = "owner/repo"
   description = "What it does"
   trigger = ["keyword1", "keyword2"]
   ```

3. **Test activation:**
   ```bash
   codex "keyword1 my request"
   ```

---

## Performance Tuning

**Reduce Response Time:**
1. Use more specific triggers
2. Limit active agents per request
3. Cache frequently used responses
4. Pre-load common plugins

**Improve Accuracy:**
1. Provide more context
2. Specify frameworks/languages
3. Chain related requests
4. Use explicit agent calls

---

**For detailed agent documentation, visit each repository directly!**
