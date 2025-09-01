# Design System Documentation

## School ERP System - Unified Design Language

This document defines the complete design system for the School ERP System, ensuring consistency across all interfaces and providing guidelines for designers and developers.

## Table of Contents

1. [Design Principles](#design-principles)
2. [Color System](#color-system)
3. [Typography](#typography)
4. [Spacing & Layout](#spacing--layout)
5. [Icons & Imagery](#icons--imagery)
6. [Components](#components)
7. [Patterns](#patterns)
8. [Accessibility](#accessibility)
9. [Implementation Guide](#implementation-guide)

## Design Principles

### 1. Clarity
- **Clear Visual Hierarchy**: Information is organized logically with proper emphasis
- **Intuitive Navigation**: Users can easily find what they're looking for
- **Consistent Labeling**: Similar actions use the same terminology

### 2. Efficiency
- **Minimal Cognitive Load**: Interfaces are simple and focused
- **Quick Task Completion**: Common actions are easily accessible
- **Smart Defaults**: System anticipates user needs

### 3. Accessibility
- **Inclusive Design**: Works for users with diverse abilities
- **Multiple Input Methods**: Touch, keyboard, and assistive technology support
- **Clear Feedback**: System state is always apparent

### 4. Trust
- **Data Security**: User information is protected and secure
- **Reliable Performance**: System works consistently
- **Transparent Communication**: Clear error messages and system status

## Color System

### Primary Palette

#### Mint Green Family
```
Primary Mint (#9EEFE1)
├── Mint Light (#E8FCF8)    - Backgrounds, subtle accents
├── Mint Soft (#D1F7EF)     - Hover states, secondary backgrounds
├── Primary Mint (#9EEFE1)  - Primary actions, active states
└── Mint Dark (#7AE4D1)     - Pressed states, emphasis
```

#### Navy Blue Family
```
Primary Navy (#1B4664)
├── Navy Light (#4A6B85)    - Secondary text, icons
├── Primary Navy (#1B4664)  - Primary text, headers
└── Navy Dark (#0F2A3D)     - Emphasis, strong contrast
```

### Semantic Colors

```css
/* Success */
--color-success: #10B981;
--color-success-light: #D1FAE5;
--color-success-dark: #047857;

/* Warning */
--color-warning: #F59E0B;
--color-warning-light: #FEF3C7;
--color-warning-dark: #D97706;

/* Error */
--color-error: #EF4444;
--color-error-light: #FEE2E2;
--color-error-dark: #DC2626;

/* Info */
--color-info: #3B82F6;
--color-info-light: #DBEAFE;
--color-info-dark: #1D4ED8;
```

### Neutral Palette

```css
/* Neutrals */
--color-white: #FFFFFF;
--color-off-white: #FAFBFC;
--color-light-gray: #F5F6F8;
--color-medium-gray: #E1E5E9;
--color-dark-gray: #6B7280;
--color-charcoal: #374151;
--color-black: #000000;
```

### Role-Based Colors

```css
/* User Roles */
--color-admin: #FF6B6B;     /* Red */
--color-teacher: #4ECDC4;   /* Teal */
--color-student: #45B7D1;   /* Blue */
--color-parent: #FF9F43;    /* Orange */
```

### Usage Guidelines

#### Do's
- Use primary mint for call-to-action buttons
- Use navy for important text and headers
- Use semantic colors for appropriate states
- Maintain sufficient contrast ratios (4.5:1 minimum)

#### Don'ts
- Don't use red for positive actions
- Don't use more than 3 colors in a single interface
- Don't use color as the only way to convey information

## Typography

### Font Families

```css
/* Primary Font - Inter */
font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;

/* Heading Font - Plus Jakarta Sans */
font-family: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;

/* Monospace Font - Roboto Mono */
font-family: 'Roboto Mono', 'SF Mono', Monaco, 'Cascadia Code', monospace;
```

### Type Scale

#### Display Styles
```css
/* Display Large */
font-size: 64px;
font-weight: 800;
line-height: 1.1;
letter-spacing: -0.5px;

/* Display Medium */
font-size: 48px;
font-weight: 700;
line-height: 1.2;
letter-spacing: -0.25px;

/* Display Small */
font-size: 36px;
font-weight: 700;
line-height: 1.2;
```

#### Heading Styles
```css
/* Heading Large (H1) */
font-size: 32px;
font-weight: 700;
line-height: 1.25;
font-family: 'Plus Jakarta Sans';

/* Heading Medium (H2) */
font-size: 24px;
font-weight: 600;
line-height: 1.3;
font-family: 'Plus Jakarta Sans';

/* Heading Small (H3) */
font-size: 20px;
font-weight: 600;
line-height: 1.4;
font-family: 'Plus Jakarta Sans';
```

#### Body Styles
```css
/* Body Large */
font-size: 16px;
font-weight: 400;
line-height: 1.5;
font-family: 'Inter';

/* Body Medium */
font-size: 14px;
font-weight: 400;
line-height: 1.5;
font-family: 'Inter';

/* Body Small */
font-size: 12px;
font-weight: 400;
line-height: 1.5;
font-family: 'Inter';
```

#### Label & Button Styles
```css
/* Label Large */
font-size: 14px;
font-weight: 500;
letter-spacing: 0.1px;
font-family: 'Inter';

/* Button Large */
font-size: 16px;
font-weight: 600;
letter-spacing: 0.1px;
font-family: 'Inter';

/* Caption */
font-size: 12px;
font-weight: 400;
letter-spacing: 0.4px;
color: var(--color-dark-gray);
```

### Typography Guidelines

#### Hierarchy
1. **Page Title**: Display Large or Heading Large
2. **Section Headers**: Heading Medium
3. **Subsection Headers**: Heading Small
4. **Body Content**: Body Medium
5. **Captions/Labels**: Label styles

#### Line Length
- **Optimal**: 45-75 characters per line
- **Minimum**: 25 characters
- **Maximum**: 90 characters

## Spacing & Layout

### Spacing Scale (8pt Grid System)

```css
/* Base Unit: 8px */
--spacing-xs: 4px;    /* 0.5 × base */
--spacing-sm: 8px;    /* 1 × base */
--spacing-md: 16px;   /* 2 × base */
--spacing-lg: 24px;   /* 3 × base */
--spacing-xl: 32px;   /* 4 × base */
--spacing-xxl: 48px;  /* 6 × base */
--spacing-xxxl: 64px; /* 8 × base */
```

### Layout Grid

#### Breakpoints
```css
/* Mobile */
@media (max-width: 599px) { /* Mobile styles */ }

/* Tablet */
@media (min-width: 600px) and (max-width: 899px) { /* Tablet styles */ }

/* Desktop */
@media (min-width: 900px) and (max-width: 1199px) { /* Desktop styles */ }

/* Large Desktop */
@media (min-width: 1200px) { /* Large desktop styles */ }
```

#### Grid Columns
- **Mobile**: 4 columns
- **Tablet**: 8 columns
- **Desktop**: 12 columns
- **Large Desktop**: 12 columns

#### Container Widths
```css
/* Content Containers */
--container-mobile: 100%;
--container-tablet: 768px;
--container-desktop: 1024px;
--container-large: 1200px;
```

### Border Radius Scale

```css
--radius-xs: 2px;
--radius-sm: 4px;
--radius-md: 8px;
--radius-lg: 12px;
--radius-xl: 16px;
--radius-xxl: 24px;
--radius-round: 100px;
```

### Elevation System

```css
/* Shadows */
--shadow-none: none;
--shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);
--shadow-md: 0 4px 6px rgba(0, 0, 0, 0.07);
--shadow-lg: 0 10px 15px rgba(0, 0, 0, 0.1);
--shadow-xl: 0 20px 25px rgba(0, 0, 0, 0.1);
--shadow-2xl: 0 25px 50px rgba(0, 0, 0, 0.25);
```

## Icons & Imagery

### Icon System

#### Icon Sizes
```css
--icon-xs: 12px;
--icon-sm: 16px;
--icon-md: 24px;
--icon-lg: 32px;
--icon-xl: 48px;
--icon-xxl: 64px;
```

#### Icon Guidelines
- Use Material Design Icons as primary icon set
- Maintain consistent stroke width (1.5px for outlined icons)
- Use filled icons for active/selected states
- Use outlined icons for inactive/default states

#### Icon Usage
- **Navigation**: 24px icons
- **Buttons**: 16px or 20px icons
- **Headers**: 24px or 32px icons
- **List items**: 20px or 24px icons

### Avatar System

```css
--avatar-xs: 24px;
--avatar-sm: 32px;
--avatar-md: 48px;
--avatar-lg: 64px;
--avatar-xl: 96px;
--avatar-xxl: 128px;
```

### Image Guidelines

#### Aspect Ratios
- **Profile Images**: 1:1 (square)
- **Banners**: 16:9 or 3:1
- **Thumbnails**: 4:3 or 16:9
- **Cards**: 16:9 or 4:3

#### Image Quality
- Use high-DPI images (2x) for retina displays
- Optimize file sizes without compromising quality
- Use WebP format when supported
- Provide fallbacks for unsupported formats

## Components

### Button System

#### Primary Button
```css
.btn-primary {
  background: var(--color-primary-mint);
  color: var(--color-primary-navy);
  border: none;
  border-radius: var(--radius-md);
  padding: 12px 24px;
  font-size: 14px;
  font-weight: 600;
  min-height: 40px;
}

.btn-primary:hover {
  background: var(--color-mint-soft);
  transform: translateY(-1px);
  box-shadow: var(--shadow-md);
}
```

#### Secondary Button
```css
.btn-secondary {
  background: transparent;
  color: var(--color-primary-navy);
  border: 2px solid var(--color-primary-mint);
  border-radius: var(--radius-md);
  padding: 10px 22px; /* Account for border */
  font-size: 14px;
  font-weight: 600;
  min-height: 40px;
}
```

#### Button States
- **Default**: Normal appearance
- **Hover**: Slight elevation and color change
- **Active**: Pressed appearance
- **Disabled**: Reduced opacity (0.6) and no interaction
- **Loading**: Show spinner, disable interaction

### Form Components

#### Text Input
```css
.input-field {
  background: var(--color-off-white);
  border: 1px solid var(--color-medium-gray);
  border-radius: var(--radius-md);
  padding: 12px 16px;
  font-size: 14px;
  line-height: 1.5;
  transition: all 0.2s ease;
}

.input-field:focus {
  outline: none;
  border-color: var(--color-primary-mint);
  box-shadow: 0 0 0 3px rgba(158, 239, 225, 0.1);
}

.input-field.error {
  border-color: var(--color-error);
  box-shadow: 0 0 0 3px rgba(239, 68, 68, 0.1);
}
```

#### Form Labels
```css
.form-label {
  font-size: 14px;
  font-weight: 500;
  color: var(--color-charcoal);
  margin-bottom: 6px;
  display: block;
}

.form-label.required::after {
  content: \" *\";
  color: var(--color-error);
}
```

### Card System

#### Basic Card
```css
.card {
  background: var(--color-white);
  border-radius: var(--radius-lg);
  box-shadow: var(--shadow-sm);
  padding: var(--spacing-lg);
  transition: all 0.2s ease;
}

.card:hover {
  box-shadow: var(--shadow-md);
  transform: translateY(-2px);
}
```

#### Interactive Card
```css
.card-interactive {
  cursor: pointer;
  user-select: none;
}

.card-interactive:active {
  transform: translateY(0);
  box-shadow: var(--shadow-sm);
}
```

### Navigation Components

#### Top Navigation
```css
.top-nav {
  background: var(--color-white);
  border-bottom: 1px solid var(--color-medium-gray);
  height: 64px;
  padding: 0 var(--spacing-lg);
  display: flex;
  align-items: center;
  justify-content: space-between;
}
```

#### Sidebar Navigation
```css
.sidebar {
  background: var(--color-white);
  width: 280px;
  height: 100vh;
  border-right: 1px solid var(--color-medium-gray);
  padding: var(--spacing-lg);
}

.sidebar-item {
  display: flex;
  align-items: center;
  padding: 12px 16px;
  border-radius: var(--radius-md);
  transition: all 0.2s ease;
  margin-bottom: 4px;
}

.sidebar-item:hover {
  background: var(--color-light-gray);
}

.sidebar-item.active {
  background: var(--color-mint-light);
  color: var(--color-primary-navy);
  font-weight: 600;
}
```

## Patterns

### Loading States

#### Skeleton Loading
```css
.skeleton {
  background: linear-gradient(
    90deg,
    var(--color-light-gray) 25%,
    var(--color-medium-gray) 50%,
    var(--color-light-gray) 75%
  );
  background-size: 200% 100%;
  animation: skeleton-loading 2s infinite;
}

@keyframes skeleton-loading {
  0% { background-position: 200% 0; }
  100% { background-position: -200% 0; }
}
```

#### Progress Indicators
```css
.progress-bar {
  background: var(--color-light-gray);
  border-radius: var(--radius-round);
  height: 8px;
  overflow: hidden;
}

.progress-fill {
  background: linear-gradient(
    90deg,
    var(--color-primary-mint),
    var(--color-mint-soft)
  );
  height: 100%;
  border-radius: var(--radius-round);
  transition: width 0.3s ease;
}
```

### Empty States

```css
.empty-state {
  text-align: center;
  padding: var(--spacing-xxxl) var(--spacing-lg);
}

.empty-state-icon {
  width: 64px;
  height: 64px;
  margin: 0 auto var(--spacing-lg);
  opacity: 0.5;
}

.empty-state-title {
  font-size: 18px;
  font-weight: 600;
  color: var(--color-charcoal);
  margin-bottom: var(--spacing-sm);
}

.empty-state-description {
  color: var(--color-dark-gray);
  margin-bottom: var(--spacing-lg);
}
```

### Error States

```css
.error-state {
  background: var(--color-error-light);
  border: 1px solid var(--color-error);
  border-radius: var(--radius-md);
  padding: var(--spacing-md);
  display: flex;
  align-items: flex-start;
  gap: var(--spacing-sm);
}

.error-icon {
  color: var(--color-error);
  flex-shrink: 0;
}

.error-content {
  flex: 1;
}

.error-title {
  font-weight: 600;
  color: var(--color-error-dark);
  margin-bottom: 4px;
}

.error-description {
  color: var(--color-error-dark);
  font-size: 14px;
}
```

## Accessibility

### Color Accessibility

#### Contrast Ratios
- **Normal Text**: 4.5:1 minimum
- **Large Text**: 3:1 minimum
- **Non-text Elements**: 3:1 minimum

#### Color Independence
- Never use color alone to convey information
- Provide text labels or icons alongside color coding
- Use patterns or shapes for additional differentiation

### Keyboard Navigation

#### Focus Indicators
```css
.focusable:focus {
  outline: 2px solid var(--color-primary-mint);
  outline-offset: 2px;
}

.focusable:focus:not(:focus-visible) {
  outline: none;
}

.focusable:focus-visible {
  outline: 2px solid var(--color-primary-mint);
  outline-offset: 2px;
}
```

#### Tab Order
- Logical flow from top to bottom, left to right
- Skip links for long content
- Modal focus trapping

### Screen Reader Support

#### Semantic HTML
```html
<!-- Use proper heading hierarchy -->
<h1>Page Title</h1>
<h2>Section Title</h2>
<h3>Subsection Title</h3>

<!-- Use semantic elements -->
<nav aria-label=\"Main navigation\">
<main role=\"main\">
<aside aria-label=\"Sidebar\">

<!-- Provide alternative text -->
<img src=\"chart.png\" alt=\"Student enrollment increased 15% this year\">

<!-- Use proper form labels -->
<label for=\"email\">Email Address</label>
<input type=\"email\" id=\"email\" required>
```

#### ARIA Labels
```html
<!-- Button with icon only -->
<button aria-label=\"Close dialog\">
  <icon name=\"close\" aria-hidden=\"true\" />
</button>

<!-- Loading state -->
<div aria-live=\"polite\" aria-label=\"Loading content\">...</div>

<!-- Error message -->
<div role=\"alert\" aria-live=\"assertive\">Error: Please correct the form</div>
```

### Touch Targets

#### Minimum Sizes
- **Mobile**: 44px × 44px minimum
- **Desktop**: 32px × 32px minimum
- **Spacing**: 8px minimum between targets

## Implementation Guide

### CSS Custom Properties

```css
:root {
  /* Colors */
  --color-primary-mint: #9EEFE1;
  --color-primary-navy: #1B4664;
  --color-white: #FFFFFF;
  --color-success: #10B981;
  --color-warning: #F59E0B;
  --color-error: #EF4444;
  
  /* Spacing */
  --spacing-xs: 4px;
  --spacing-sm: 8px;
  --spacing-md: 16px;
  --spacing-lg: 24px;
  --spacing-xl: 32px;
  
  /* Typography */
  --font-family-primary: 'Inter', sans-serif;
  --font-family-heading: 'Plus Jakarta Sans', sans-serif;
  
  /* Borders */
  --radius-sm: 4px;
  --radius-md: 8px;
  --radius-lg: 12px;
  
  /* Shadows */
  --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);
  --shadow-md: 0 4px 6px rgba(0, 0, 0, 0.07);
  --shadow-lg: 0 10px 15px rgba(0, 0, 0, 0.1);
  
  /* Transitions */
  --transition-fast: 150ms ease;
  --transition-normal: 300ms ease;
  --transition-slow: 500ms ease;
}
```

### Dark Mode Support

```css
:root {
  color-scheme: light;
}

:root[data-theme=\"dark\"] {
  color-scheme: dark;
  
  /* Override colors for dark mode */
  --color-white: #1a1a1a;
  --color-off-white: #252525;
  --color-light-gray: #2a2a2a;
  --color-medium-gray: #3a3a3a;
  --color-charcoal: #e5e5e5;
}
```

### Responsive Design

```css
/* Mobile-first approach */
.component {
  /* Mobile styles (default) */
  padding: var(--spacing-md);
  font-size: 14px;
}

@media (min-width: 768px) {
  .component {
    /* Tablet styles */
    padding: var(--spacing-lg);
    font-size: 16px;
  }
}

@media (min-width: 1024px) {
  .component {
    /* Desktop styles */
    padding: var(--spacing-xl);
  }
}
```

### Animation Guidelines

```css
/* Respect user preferences */
@media (prefers-reduced-motion: reduce) {
  *,
  *::before,
  *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
}

/* Standard transitions */
.interactive {
  transition: all var(--transition-fast);
}

.interactive:hover {
  transform: translateY(-2px);
}

.interactive:active {
  transform: translateY(0);
  transition-duration: 75ms;
}
```

---

## Quick Reference

### Color Variables
- `--color-primary-mint` - Primary actions
- `--color-primary-navy` - Text, headers
- `--color-success` - Success states
- `--color-warning` - Warning states
- `--color-error` - Error states

### Spacing Variables
- `--spacing-xs` (4px) - Tight spacing
- `--spacing-sm` (8px) - Small spacing
- `--spacing-md` (16px) - Default spacing
- `--spacing-lg` (24px) - Large spacing
- `--spacing-xl` (32px) - Extra large spacing

### Common Patterns
- Use `var(--spacing-md)` for default padding
- Use `var(--radius-md)` for default border radius
- Use `var(--shadow-sm)` for subtle elevation
- Use `var(--transition-fast)` for hover effects

---

**Remember**: This design system is living documentation. Update it as the system evolves and always maintain consistency across the entire application."