# Apple HIG Compliance Checklist

Use this checklist to ensure your web/mobile app follows Apple Human Interface Guidelines.

## Visual Design

### Typography
- [ ] Using system fonts (SF Pro, San Francisco)
- [ ] Proper font hierarchy (sizes: 12, 14, 16, 18, 20, 24, 28, 32pt)
- [ ] Font weights used correctly (regular, medium, semibold)
- [ ] Line height appropriate (1.4x - 1.6x font size)
- [ ] Letter spacing matches guidelines
- [ ] Text contrast meets WCAG AAA (7:1 minimum)
- [ ] Dynamic type supported (adjustable text sizes)

### Colors
- [ ] Using system colors (not custom)
- [ ] Light and dark mode support
- [ ] Sufficient contrast ratios
- [ ] Color not sole information indicator
- [ ] Semantic colors:
  - [ ] Primary (for main actions)
  - [ ] Secondary (for secondary actions)
  - [ ] Success (green)
  - [ ] Error/Destructive (red)
  - [ ] Warning (yellow/orange)
- [ ] Consistent with Apple design system

```css
/* Example: Apple-style colors */
:root {
  --color-primary: #007AFF;      /* Blue */
  --color-success: #34C759;      /* Green */
  --color-warning: #FF9500;      /* Orange */
  --color-destructive: #FF3B30;  /* Red */
  --color-gray-1: #F5F5F7;       /* Light gray */
  --color-gray-2: #EFEFEF;       /* Medium gray */
  --color-text: #000000;          /* Black (light mode) */
}

@media (prefers-color-scheme: dark) {
  :root {
    --color-text: #FFFFFF;
  }
}
```

### Spacing & Layout
- [ ] Using 8pt grid system
- [ ] Consistent margins (8, 16, 24, 32pt)
- [ ] Consistent padding
- [ ] Safe areas respected (notch, home indicator)
- [ ] Responsive design implemented
- [ ] Minimum touch targets 44x44pt
- [ ] Proper whitespace (not cramped)
- [ ] Elements aligned to grid

```css
/* 8pt grid system */
.button {
  padding: 8px 16px;      /* 1x and 2x grid units */
  min-height: 44px;       /* Touch target */
  border-radius: 8px;     /* Consistent rounding */
  gap: 8px;               /* Spacing between elements */
}
```

### Iconography
- [ ] Using SF Symbols (Apple's icon set)
- [ ] Consistent icon weight
- [ ] Proper icon sizing (16, 24, 32pt)
- [ ] Icons are simple and recognizable
- [ ] Monochrome icons (colored when necessary)
- [ ] Icon padding consistent

## Interaction Design

### Touch & Gestures
- [ ] Touch targets minimum 44x44pt
- [ ] Gesture support appropriate for context
- [ ] Long-press menus implemented where needed
- [ ] Haptic feedback (if applicable)
- [ ] Swipe gestures intuitive
- [ ] Two-finger pinch for zoom (where applicable)
- [ ] Touch feedback visual (highlight/opacity change)

### Animations
- [ ] Animations purposeful (not decorative)
- [ ] Animation duration 300-500ms (smooth but responsive)
- [ ] Transitions between states clear
- [ ] No continuous auto-playing animations
- [ ] prefers-reduced-motion respected

```css
/* Respect user motion preferences */
@media (prefers-reduced-motion: reduce) {
  * {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
  }
}
```

### Navigation
- [ ] Tab bar for primary navigation (mobile)
- [ ] Sidebar for secondary navigation (desktop)
- [ ] Breadcrumbs for deep hierarchies
- [ ] Back button always available
- [ ] Current location always clear
- [ ] Shortcuts for common tasks
- [ ] Search accessible

## Forms & Input

### Form Design
- [ ] Single column layout (mobile)
- [ ] Clear labels above inputs
- [ ] Required fields marked (*)
- [ ] Placeholder text optional (not required)
- [ ] Input fields large enough (min 44pt height)
- [ ] Keyboard type appropriate (email, number, tel)
- [ ] Autofocus on first input
- [ ] Tab order logical

```html
<!-- Apple HIG form example -->
<form>
  <label for="email" class="form-label">
    Email Address <span class="required">*</span>
  </label>
  <input
    id="email"
    type="email"
    inputmode="email"
    placeholder="you@example.com"
    required
    class="form-input"
  />
  
  <label for="password" class="form-label">
    Password <span class="required">*</span>
  </label>
  <input
    id="password"
    type="password"
    placeholder="Enter password"
    required
    class="form-input"
  />
  
  <button type="submit" class="button button-primary">
    Sign In
  </button>
</form>
```

### Validation
- [ ] Real-time validation (not on blur)
- [ ] Clear error messages
- [ ] Error color (red) used
- [ ] Error icons shown
- [ ] Suggestions provided (if available)
- [ ] Validation not blocking (can submit)
- [ ] Success feedback provided

## Accessibility

### Screen Readers
- [ ] All interactive elements labeled
- [ ] Images have alt text
- [ ] Semantic HTML used
- [ ] ARIA labels where needed
- [ ] Heading hierarchy logical
- [ ] List structure proper
- [ ] Form labels associated
- [ ] Error messages programmatically associated

```html
<!-- Accessible component -->
<button
  aria-label="Menu"
  aria-expanded="false"
  aria-controls="menu-list"
>
  <img src="menu-icon.svg" alt="" />
</button>

<ul id="menu-list" hidden>
  <li><a href="/profile">Profile</a></li>
  <li><a href="/settings">Settings</a></li>
  <li><a href="/logout">Logout</a></li>
</ul>
```

### Keyboard Navigation
- [ ] All functions keyboard accessible
- [ ] Tab order logical
- [ ] Focus visible (outlined)
- [ ] Focus visible sufficient contrast
- [ ] Keyboard shortcuts provided
- [ ] No keyboard traps
- [ ] Escape closes modals
- [ ] Enter/Space activates buttons

```css
/* Visible focus indicator */
:focus-visible {
  outline: 2px solid var(--color-primary);
  outline-offset: 4px;
}
```

### Color & Contrast
- [ ] Text contrast 4.5:1 (normal text)
- [ ] Text contrast 3:1 (large text, UI components)
- [ ] Color not sole indicator
- [ ] Icon contrast 3:1
- [ ] Focus indicator contrast 3:1
- [ ] Light and dark modes supported

## Components

### Buttons
- [ ] Primary action clear
- [ ] Destructive actions red
- [ ] Minimum 44x44pt touch target
- [ ] Disabled state clear (greyed out)
- [ ] Loading state shown
- [ ] Hover/pressed states clear
- [ ] Accessible label

```html
<button class="button button-primary">
  <span class="button-label">Save</span>
</button>

<button class="button button-secondary">
  <span class="button-label">Cancel</span>
</button>

<button class="button button-destructive">
  <span class="button-label">Delete</span>
</button>
```

### Cards
- [ ] Clear grouping
- [ ] Consistent spacing
- [ ] Clear hierarchy
- [ ] Tap area appropriate
- [ ] Separators subtle
- [ ] Shadow or border for definition

### Alerts & Notifications
- [ ] Clear and concise message
- [ ] Appropriate icon
- [ ] Action buttons clear
- [ ] Auto-dismiss appropriate (e.g., 4 seconds)
- [ ] Sound optional (user preference)
- [ ] Not interrupting if not critical

### Modals
- [ ] Purpose clear
- [ ] Close button always available
- [ ] Escape key closes
- [ ] Background dimmed
- [ ] Focus trapped in modal
- [ ] Overlay required for focus
- [ ] Not too many layers deep

## Content

### Writing
- [ ] Clear and concise
- [ ] Active voice preferred
- [ ] Positive language (avoid "Don't")
- [ ] Error messages helpful
- [ ] Consistent terminology
- [ ] Tone matches brand
- [ ] Proper grammar
- [ ] No jargon

### Help & Documentation
- [ ] Help accessible from UI
- [ ] Search functionality
- [ ] Glossary for complex terms
- [ ] Video tutorials (if needed)
- [ ] Common problems addressed
- [ ] Links to support

## Dark Mode
- [ ] Light and dark variants designed
- [ ] Color palette adjusted per mode
- [ ] Images optimized per mode
- [ ] Text contrast maintained
- [ ] UI elements visible in both modes
- [ ] Smooth transition between modes

```css
@media (prefers-color-scheme: dark) {
  :root {
    --bg-primary: #000000;
    --text-primary: #FFFFFF;
    --border-color: #404040;
  }
}

@media (prefers-color-scheme: light) {
  :root {
    --bg-primary: #FFFFFF;
    --text-primary: #000000;
    --border-color: #E5E5E7;
  }
}
```

## Performance
- [ ] Load time <2 seconds
- [ ] Smooth 60fps animations
- [ ] Responsive to touch (no lag)
- [ ] No jank on scroll
- [ ] Images optimized
- [ ] No unnecessary animations

## Testing
- [ ] Tested on iPhone (multiple sizes)
- [ ] Tested on iPad
- [ ] Tested in Safari
- [ ] Tested with VoiceOver
- [ ] Tested with Keyboard navigation
- [ ] Tested in dark mode
- [ ] Tested with reduced motion
- [ ] Tested with larger text sizes

## Resources
- [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [SF Symbols](https://developer.apple.com/sf-symbols/)
- [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/)
- [WAVE Accessibility Tool](https://wave.webaim.org/)
- [Lighthouse (Chrome DevTools)](https://developers.google.com/web/tools/lighthouse)

---

**Verify all items before launch! ✅**
