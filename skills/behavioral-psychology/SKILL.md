---
name: behavioral-psychology
description: Behavioral psychology frameworks for product design, habit formation, and user motivation
user-invokable: false
---

# Behavioral Psychology

Apply these frameworks when designing features, onboarding flows, notifications, or anything that involves user behavior.

## Core Models

### Fogg Behavior Model (B = MAP)
Behavior happens when Motivation, Ability, and Prompt converge simultaneously.
- **Motivation**: Pleasure/pain, hope/fear, social acceptance/rejection
- **Ability**: Make the target behavior as easy as possible (reduce steps, time, cost, effort)
- **Prompt**: A trigger at the right moment (notification, visual cue, habit stack)
- **Design implication**: If users aren't doing X, diagnose which factor is missing. Usually it's ability or prompt, not motivation.

### Hook Model (Nir Eyal)
Trigger → Action → Variable Reward → Investment → (repeat)
- **External triggers**: emails, notifications, CTAs
- **Internal triggers**: emotions (boredom, anxiety, FOMO)
- **Variable reward**: social (likes), hunt (search results), self (mastery/completion)
- **Investment**: user puts something in (data, content, preferences) that makes the product better next time
- **Design implication**: Each feature should have a clear hook loop. What triggers re-engagement?

### Self-Determination Theory (Deci & Ryan)
Three innate needs that drive intrinsic motivation:
- **Autonomy**: feeling in control of choices
- **Competence**: feeling effective and capable
- **Relatedness**: feeling connected to others
- **Design implication**: Dashboards should show progress (competence), let users customize (autonomy), and enable sharing/collaboration (relatedness).

### Loss Aversion (Kahneman & Tversky)
People feel losses ~2x more strongly than equivalent gains.
- **Design implication**: Frame features around what users lose by not acting. "Your listing is missing 3 photos that competitors have" > "Add photos to improve your listing."
- **Endowment effect**: Once users invest time/data, they value the product more.

## Habit Formation

### Habit Loop (Charles Duhigg)
Cue → Routine → Reward
- **Design implication**: Identify the cue (time of day, location, emotional state), design the routine (make it frictionless), deliver a clear reward.

### Tiny Habits (BJ Fogg)
Start absurdly small, attach to existing behavior, celebrate immediately.
- **Design implication**: First-time user experience should ask for the smallest possible commitment. Expand gradually.

### Implementation Intentions
"When X happens, I will do Y" — pre-committing to a specific time/place/trigger doubles follow-through.
- **Design implication**: Onboarding should ask "When will you first use this?" and set a reminder.

## Persuasion Principles (Cialdini)

1. **Reciprocity**: Give value first (free tier, useful content) before asking
2. **Commitment/Consistency**: Start with small asks, escalate gradually
3. **Social Proof**: Show what others are doing ("1,200 guides created this week")
4. **Authority**: Expert endorsements, certifications, data-backed claims
5. **Liking**: Friendly tone, personalization, shared identity
6. **Scarcity**: Limited-time offers, beta access, exclusive features

## Cognitive Biases in Product Design

- **Anchoring**: First number seen sets expectations (show premium plan first)
- **Default effect**: Most users keep defaults (set smart defaults)
- **Choice overload**: Too many options → decision paralysis (limit to 3-4 options)
- **Peak-end rule**: Users judge experiences by the peak moment and the end (nail onboarding and final confirmation)
- **Zeigarnik effect**: Incomplete tasks create mental tension (progress bars, checklists)
- **IKEA effect**: Users value things they helped create (customization, user-generated content)

## When to Apply

- **Onboarding flows**: Tiny Habits + Fogg Model + Implementation Intentions
- **Notification design**: Hook Model triggers + Loss Aversion framing
- **Pricing pages**: Anchoring + Social Proof + Scarcity
- **Dashboards**: Self-Determination Theory (progress, autonomy, social)
- **Retention features**: Hook Model investment + Endowment Effect
- **CTAs and copy**: Cialdini's principles + Loss Aversion framing
