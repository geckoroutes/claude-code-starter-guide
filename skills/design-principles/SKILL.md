---
name: design-principles
description: Visual design principles — hierarchy, typography, color, spacing, accessibility, animation
user-invokable: false
---

# Design Principles

Apply these when building UI components, layouts, landing pages, or any visual interface.

## Visual Hierarchy

1. **Size**: Larger elements draw attention first
2. **Color/Contrast**: High contrast = high importance
3. **Position**: Top-left (LTR) and center get seen first
4. **Whitespace**: Isolated elements feel more important
5. **Typography weight**: Bold > regular > light

**Rule**: Every screen should have exactly ONE primary focal point. If everything is bold, nothing is.

## Typography

### Scale
Use a consistent type scale. Recommended: Major Third (1.250):
- `xs`: 12px / `sm`: 14px / `base`: 16px / `lg`: 20px / `xl`: 25px / `2xl`: 31px / `3xl`: 39px

### Line Height
- Headings: 1.1–1.3 (tight)
- Body: 1.5–1.75 (readable)
- Small text: 1.6–1.8

### Max Width
- Body text: 60–75 characters per line (use `max-w-prose` or `max-w-2xl`)
- Headings: can be wider

### Font Pairing
- One sans-serif for headings + same or similar for body (safe default)
- Max 2 typefaces per project
- System font stack is always a valid choice for performance

## Color

### System
- 1 primary color (brand, CTAs, links)
- 1 secondary color (supporting actions, backgrounds)
- 1 accent color (highlights, badges, alerts)
- Neutrals: gray scale for text, borders, backgrounds (5-7 shades)

### Contrast (WCAG)
- Normal text: minimum 4.5:1 contrast ratio against background
- Large text (18px+ bold or 24px+): minimum 3:1
- Interactive elements: minimum 3:1 against adjacent colors
- Test with: Chrome DevTools → Elements → Computed → color picker shows ratio

### Dark Mode
- Don't just invert. Use dark gray (#1a1a2e) not pure black (#000)
- Reduce saturation of colors by 10-20%
- Use opacity for layering (surfaces at 4%, 8%, 12%)

## Spacing

### System (8px base)
`4 · 8 · 12 · 16 · 24 · 32 · 48 · 64 · 96 · 128`

### Rules
- Related elements: 8-16px apart
- Distinct sections: 48-96px apart
- Padding inside containers: 16-32px
- Consistent axis: if horizontal padding is 24px, keep it 24px everywhere at that level

## Layout

### Grid
- Max content width: 1200-1440px
- Gutter: 24-32px
- Mobile: single column, 16px padding
- Tablet: 2 columns
- Desktop: 3-4 columns (12-column grid for complex layouts)

### Cards
- Border radius: 8-16px (consistent across all cards)
- Shadow: `0 1px 3px rgba(0,0,0,0.1)` for subtle, `0 4px 12px rgba(0,0,0,0.15)` for elevated
- Internal padding: 16-24px

## Animation (Framer Motion)

### Principles
- **Purpose**: Animations should communicate, not decorate
- **Duration**: 150-300ms for micro-interactions, 300-500ms for transitions, 500-800ms for page-level
- **Easing**: `ease-out` for enters, `ease-in` for exits, `ease-in-out` for moves

### Common Patterns
```jsx
// Fade up (section entrance)
{ initial: { opacity: 0, y: 20 }, animate: { opacity: 1, y: 0 }, transition: { duration: 0.5 } }

// Stagger children
{ variants: { show: { transition: { staggerChildren: 0.1 } } } }

// Scale on hover (buttons/cards)
{ whileHover: { scale: 1.02 }, whileTap: { scale: 0.98 } }
```

### Don'ts
- Don't animate on scroll below the fold unless it adds meaning
- Don't delay content from being readable
- Don't animate layout properties (width, height) — use transform instead
- Respect `prefers-reduced-motion`

## Accessibility

- All images need `alt` text (decorative = `alt=""`)
- Focus states on all interactive elements (visible outline)
- Keyboard navigable: Tab, Enter, Escape, Arrow keys
- Semantic HTML: `<nav>`, `<main>`, `<section>`, `<article>`, `<button>` (not div-with-onclick)
- ARIA labels on icon-only buttons
- Color is never the only indicator (add icons, text, patterns)
- Touch targets: minimum 44x44px on mobile

## Responsive Breakpoints (Tailwind)

- `sm`: 640px (large phones)
- `md`: 768px (tablets)
- `lg`: 1024px (small laptops)
- `xl`: 1280px (desktops)
- `2xl`: 1536px (large screens)

Design mobile-first, enhance for larger screens.
