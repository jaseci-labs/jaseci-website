# DESIGN.md — The Design System of the Jac/Jaseci Website

> An exhaustive analysis of the design decisions in `jaseci_website_v2` — what was decided, why it was decided, and the exact values that implement each decision. Written from a full read of the codebase (~10,900 lines of TSX/CSS across `app/`), the in-code design commentary, and the project's recorded design history.
>
> **Scope:** the single-page narrative site (`app/page.tsx` + 18 components), its token system (`app/globals.css`), and its retired experiments. Deployment is manual `vercel --prod` (git push does not deploy); production is `jaseciwebsitev2.vercel.app`.

---

## Table of contents

1. [The thesis: design as argument](#1-the-thesis-design-as-argument)
2. [The token system](#2-the-token-system)
3. [Color doctrine: one accent, and color-as-evidence](#3-color-doctrine-one-accent-and-color-as-evidence)
4. [Typography](#4-typography)
5. [Space, structure, and the hairline](#5-space-structure-and-the-hairline)
6. [Texture: the blueprint layer](#6-texture-the-blueprint-layer)
7. [Motion language](#7-motion-language)
8. [The narrative spine, section by section](#8-the-narrative-spine-section-by-section)
9. [Theming architecture (dark mode)](#9-theming-architecture-dark-mode)
10. [Rendering & performance architecture](#10-rendering--performance-architecture)
11. [Accessibility inventory](#11-accessibility-inventory)
12. [Copy as a designed system](#12-copy-as-a-designed-system)
13. [Design history: the bench, the stash, and the sediment](#13-design-history-the-bench-the-stash-and-the-sediment)
14. [The rulebook, codified](#14-the-rulebook-codified)
15. [Appendix: file map](#15-appendix-file-map)

---

## 1. The thesis: design as argument

The site is one long page making one claim: **Jac is the language built for AI, and the old stack is obsolete.** Every design decision serves that claim in one of two registers:

**The engineering-document register.** The base aesthetic is a stark, brutalist, black-on-white technical drawing: hairline `1px` rules, monospace uppercase labels, diagonal blueprint hatching, registration-mark crosshairs on the floating nav, sharp corners everywhere (the live page contains **zero** rounded corners), no shadows, no glassmorphism, no decorative gradients. The page looks like a spec sheet because the argument is "we are serious engineers; here are the receipts." The receipts are literal: a code comparison labelled `120 lines · 1 process` vs `346 lines · 2 processes + CORS`, arXiv IDs, an OOPSLA venue line, backer logos.

**The demo register.** In exactly the places where the page claims Jac produces impressive things, the austerity breaks — deliberately. Two project cards render *live* WebGL (a ray-marched black hole; a bloomed neural cortex) in full saturated color on pure black. The rule at work: **decoration must earn its color by being evidence.** A gradient in a hero would be ornament; a gravitational-lensing shader inside a card titled "Built in 4 Days" is proof.

Everything else in this document is downstream of those two registers.

---

## 2. The token system

Defined in `app/globals.css:28-60`. The tokens are locked and documented as source-of-truth; the in-file comment on the derived shades states the policy: *"every hardcoded ink in the modules maps onto one of these, so the whole page flips to dark by swapping this block."* New colors are **derived, not invented**.

### 2.1 Core tokens

| Token | Light | Dark | Role |
|---|---|---|---|
| `--background` | `#ffffff` | `#0f0f0f` | Paper |
| `--foreground` | `#000000` | `#ededed` | Ink |
| `--border` | `#000000` | `#ededed` | Every hairline |
| `--muted` | `#595959` | `#a3a3a3` | Secondary text |
| `--accent` | `#ee5a24` | `#ee5a24` (unchanged) | The one orange |
| `--accent-hover` | `#c8430f` | unchanged | Pressed/darker orange |
| `--on-accent` | `#ffffff` | unchanged | Text sitting on orange fill, both themes |

Two structural decisions here:

- **The accent does not shift between themes.** Dark mode is described in the CSS as *"the same brutalist system printed in negative — near-black paper, off-white ink, identical orange."* The orange is the brand constant; paper and ink invert around it.
- **Dark ink is `#ededed`, not `#fff`; dark paper is `#0f0f0f`, not `#000`.** Full-contrast inversions glare; the one-step-off values keep the hairline aesthetic readable in negative.

### 2.2 Derived shades

Each derived token carries a one-line job description in the source — the naming is by *function*, not by lightness:

| Token | Light | Dark | In-code job description |
|---|---|---|---|
| `--ink-soft` | `#1a1a1a` | `#d2d2d2` | "strong body copy, one step off full ink" |
| `--grey-2` | `#8f8f8f` | *(not overridden)* | "dim notes / code comments" |
| `--grey-3` | `#b3b3b3` | `#565656` | "faint furniture: line numbers, idle chips" |
| `--grey-4` | `#d4d4d4` | `#333333` | "ghost: progress-bar rest" |
| `--hairline-faint` | `rgba(0,0,0,0.15)` | `rgba(255,255,255,0.22)` | "sub-weight rules (code gutters)" |
| `--hatch` | `rgba(0,0,0,0.06)` | `rgba(255,255,255,0.08)` | "the blueprint diagonal-hatch texture" |
| `--tint` | `rgba(0,0,0,0.05)` | `rgba(255,255,255,0.08)` | "hover wash on flat surfaces" |

`--grey-2` deliberately has no dark override: `#8f8f8f` sits close enough to the midpoint of both papers that it reads as "dim" in either theme. The dark-theme faint values are slightly *stronger* than their light equivalents (0.22 vs 0.15, 0.08 vs 0.06) — an optical correction, since light lines on dark ground read weaker than the reverse.

### 2.3 Miscellaneous global decisions

- `::selection` is `--accent` with white text — even text selection is on-brand (`globals.css:126-129`).
- `body` defaults to `font-weight: 300` with antialiasing — the light weight is part of the "printed document" feel; emphasis is created by jumping to 600–800, not 400→500.
- `a { color: inherit; text-decoration: none }` — links are undecorated by default; affordance is supplied per-component (underline-on-hover, border-bottom, arrow glyphs), which is what lets whole bordered boxes act as anchors without looking like links.
- `html, body { overflow-x: clip }` — **`clip`, not `hidden`**. The comment preserves a hard-won lesson: `hidden` silently turns the root into a scroll container and breaks every `position: sticky` on the page (this cost real debugging during the removed scroll-graph era; see §13.3).
- Smooth in-page scrolling (`scroll-behavior: smooth`) is enabled **only** inside `@media (prefers-reduced-motion: no-preference)`.

---

## 3. Color doctrine: one accent, and color-as-evidence

The live page's palette is exactly: paper, ink, four grays, two alpha washes, and one orange (`#ee5a24` / hover `#c8430f`). Everything chromatic beyond that falls into one of three *sanctioned* exception classes:

### 3.1 Sanctioned: color as rendered proof (the WebGL cards)

`BlackHole.tsx` and `NeuralNetwork.tsx` are the only saturated-color surfaces on the page, and both are *product demos* — live renders of projects built in Jac, revealed on hover inside their project cards:

- **BlackHole**: accretion disc ramps `#ffd25e` (inner, yellow-gold) → `#ff4d0a` (outer, orange-red); starfield `#ffe6c0` at 0.9 opacity; pure `0x000000` background. The palette is *warm on black* — an extension of the site accent into 3D, not a foreign color scheme.
- **NeuralNetwork**: node palette `0xf59e0b, 0xf97316, 0xdc2626, 0x7f1d1d, 0xfbbf24` (ambers → oranges → deep reds) with white starfield. The porting comment is explicit about the discipline: *"One formation (the radial cortex), **one palette (warm, matching the site's accent)**."*

Both canvases sit on fixed `#000` cards in **both** themes — the black is the void of the render, not a theme surface, so it does not invert.

### 3.2 Sanctioned: third-party marks as evidence

Backer logos (NVIDIA, University of Michigan, NSF — `public/logos/*.svg`, clean Wikimedia sources) render **grayscale/black at rest** and knock out to **white on the orange hover flood**. Their real brand colors never display; the design de-brands the logos into ink. (A vestigial `brand: "#76b900"` field remains in `ProofGrid.tsx`'s data from an abandoned "pop to brand color on hover" direction — the shipped CSS uses the mask only for the knockout.) The nine abstraction-library logos in BlockTower (`public/jar/*.svg`) get the same treatment: shown as-is on white, inverted to white silhouettes on the orange hover fill.

### 3.3 Sanctioned: syntax color, collapsed to the system

The two code surfaces (CodeCompare, InteropTerminal) use a hand-rolled tokenizer whose entire "syntax theme" is mapped onto existing tokens — **no** conventional multi-hue code palette:

| Token class | Color | Weight |
|---|---|---|
| keyword `.kw` | `var(--accent)` | 500 |
| string `.str` | `var(--muted)` | — |
| comment `.com` | `var(--grey-2)` | — |
| JSX tag `.tag` | inherit (ink) | **700** |

Tags are distinguished by *weight*, not hue — the most characteristic move in the whole system: where another site would add a color, this one adds boldness.

### 3.4 Not sanctioned (and confined to dead code)

Two genuinely polychrome artifacts exist in the repo, and **neither renders on the live page**:

- `.pillar::before` in `page.module.css:352-366` — a 4px top rule with a rainbow gradient (`#ee5a24 → #ff4d9d 45% → #a855f7 70% → #22d3ee`). The `.pillars` block is orphaned CSS from a removed manifesto section (§13.5).
- `AbstractionTrendScroll` (benched component, §13.4) — its "Jaseci skyrocket" stroke is a gradient `#ee5a24 → #ff2d9b 45% → #8b3bff 75% → #19e6a0`, with a purple `#8b3bff` label and glow. This is the surviving fossil of the removed "colorful Jaseci peak" background-graph concept.

The pattern is consistent: every attempt to introduce a multi-color moment was eventually cut or benched. The shipped page holds the one-orange line absolutely.

---

## 4. Typography

### 4.1 The three-voice system

The site speaks in three typographic voices, each with a fixed job:

| Variable | Stack (first → fallback) | Job |
|---|---|---|
| `--font-mono` | JetBrains Mono → Fira Code → Menlo/Monaco/Consolas | **The machine voice.** All h2 headlines, eyebrows, labels, chips, stats furniture, CTAs, nav brand, code, the final slogan. Uppercase + letterspaced at small sizes; heavy (700–800) and tight at display sizes. |
| `--font-sans` | **Circular** → Geist (`next/font/google`) → system stack | **The display voice.** The hero headline, card titles, bento stat numerals, EvolutionBox headline, ProofGrid brand names. |
| `--font-body` | **Mr Eaves XL Sans** (Adobe kit) → Circular → Geist → system | **The reading voice.** All running paragraphs: `.body`, `.heroLede`, card descriptions, bento descriptions, accordion bodies, quotes, footer tagline. |

**The aspirational-font strategy** is a deliberate piece of engineering: Circular (Supabase's licensed brand face) has `@font-face` slots declared against `/public/fonts/circular-{book,medium,bold}.woff2` — files that are *not shipped* (`public/fonts/` contains only a README). Mr Eaves XL Sans is wired as a commented-out Adobe Typekit `<link>` in `layout.tsx`. Both use `font-display: swap` semantics so that until the licensed files/kit exist, **the site renders identically on Geist with zero code changes**; dropping in the files upgrades it silently. The comments document the exact activation steps. Today, in practice, the shipped site is Geist + JetBrains Mono.

Font history (three redesigns deep): **DM Sans → Fraunces (serif) → Geist**, now aspirationally **Circular/Mr Eaves**. The drift is from "friendly geometric" through "editorial serif" to "technical neutral," tracking the brutalist turn of the whole design.

### 4.2 Display scale (exact values)

| Element | Font | Size | Weight | Line-height | Tracking |
|---|---|---|---|---|---|
| Hero h1 (`.heroHeadline`) | sans | `clamp(40px, 5.5vw, 84px)` | 700 | **1.02** | `-0.035em` |
| Base h2 (`.h2`) | **mono** | `clamp(36px, 5vw, 64px)` | 800 | 1.05 | `-0.03em` |
| Side-column h2 (`.jarCopy .h2`, `.compareSection .h2`) | mono | `clamp(32px, 3.4vw, 46px)` | 800 | 1.05 | `-0.03em` |
| Skyline header (`.stairHeader`) | mono | `clamp(30px, 3.4vw, 50px)` | 800 | 1.04 | `-0.02em`, `white-space: nowrap` |
| "Why did you start coding?" (`.whyHeading`) | mono | `clamp(28px, 3.2vw, 46px)` | 800 | — | `nowrap` |
| Final slogan (`.finalSection h2`) | mono | `clamp(24px, 6.5vw, 92px)` | 800 | 1.05 | `-0.04em`, `nowrap` |
| ProofGrid headline | mono | `clamp(36px, 5vw, 64px)` | 800 | 1.05 | `-0.03em` |
| EvolutionBox headline | sans | `clamp(22px, 2.6vw, 34px)` | 700 | 1.18 | `-0.02em`, `pre-line`, `max-width: 30ch` |

Decisions worth noting:

- **Headlines are monospace.** This is the site's most distinctive typographic choice — h2s set in JetBrains Mono 800 read as terminal output shouting. The *hero* h1 alone uses the sans, which makes the first screen humane before the machine voice takes over.
- **Clamp caps are content-derived, not systematic.** Each cap is justified in a comment against a specific line of copy: the hero is capped at 84px because *"at 84px the longest line still clears the narrower copy column"* (it was 88 — the shaved headroom was given to the hero graph); the final slogan's `6.5vw` is derived from character count (*"mono ≈ 0.6em/char × ~18 chars"*) so "Stay with the old." never wraps down to small phones.
- **Layout-stability reservation:** `.heroHeadline { min-height: calc(1.02em * 3) }` pins the headline box at exactly three lines because the typewriter's "everything." variant drops a line — without the reservation the entire page would shift vertically mid-animation.

### 4.3 The micro-label register

The "machine voice" at small sizes is a strict formula: **mono + uppercase + positive tracking**, with tracking increasing as size decreases:

| Element | Size | Tracking | Weight |
|---|---|---|---|
| Nav links | 14px | — | — |
| CTA buttons | 14px | 0.1em | 600 |
| Eyebrow (orphaned but canonical) | 12px | 0.12em | — |
| Footer bar | 12px | 0.08em | — |
| Bento module name | 11px | 0.08em | — |
| Project-card meta | 11px | 0.12em | — |
| Footer column head | 11px | 0.14em | — |
| Case-study eyebrow | 11px | 0.16em | — |
| Editor chrome title | 10.5px | 0.1em | — |
| Stat labels (ProofGrid) | 10px | 0.04em | — |
| Bento pip (install command) | 10px | 0.04em | — |
| Terminal legend / count badges | 9.5px | 0.06–0.09em | 700 |
| Paper venue line | 9.5px | 0.05em | — |
| JacPacks marquee | 13px | **0.22em** | 600 |

Body copy: `.body` 20px/1.55 (max 720px), `.heroLede` 22px/1.45 at weight 300 in `--ink-soft`, component bodies 15–17px/1.5. Measures are capped everywhere (30ch, 620px, 680px, 720px) — long-line reading is never allowed.

---

## 5. Space, structure, and the hairline

### 5.1 Containers and rhythm

- Base section: `padding: 120px 48px; max-width: 1200px` (→ `80px 24px` under 768px).
- **Width exceptions are per-argument:** hero `1600px` (the trend chart is "the co-star, so it gets almost half the row"), ecosystem `1640px` (a full-width skyline needs bleed), projects `1440px`, final hook `160px` vertical padding (the closing shout gets the most air). ProofGrid is a `min-height: 100vh` flex-centered room of its own.
- **Optical corrections between beats** are explicit: `.compareSection { padding-top: 0 }` (*"the editors prove the frame directly above, so they hug it"*); `section:has(.askEcoLayout) { padding-bottom: 40px }` plus `.ecoSection { padding-top: 40px }` pull the lineage graph and the skyline together into one visual movement. The rhythm is narrative, not modular.

### 5.2 The hairline system

The `1px solid var(--border)` rule is the single load-bearing graphic element:

- **Border collapse by negative margin.** Adjacent boxes overlap shared edges with `margin-left: -1px` / `margin-top: -1px` (skyline columns, stacked bento boxes, InstallBox tabs at `-2px`) so double borders never thicken — the grid reads as *drawn*, one continuous line, not tiled.
- **A three-weight line hierarchy:** `1px` `--border` for structure; `1px` `--hairline-faint` for sub-structure (code gutters, card inner rules); `2px` reserved for *emphasis* — the CTA buttons, the InstallBox's accent-bordered command block, quote left-rules, active tab underlines. Nothing heavier exists.
- **Zero radius on the live page.** Every rounded corner in the CSS (`.jar` 10px, `.pillarTag` 999px pill, `.proofTagNum` circle) belongs to orphaned rulesets from removed sections. What ships is entirely square.
- **No shadows anywhere.** Depth is done with borders, fills, and (in BlockTower) actual CSS 3D — never with elevation blur.

### 5.3 Fixed heights against layout shift

A recurring structural decision: interactive components reserve their maximum footprint so animation never reflows the document. The hero headline reserves 3 lines; EvolutionBox is a fixed `340px` slab (*"so the page below never reflows"*); EvolutionCards rows are fixed `196px` with clipped overflow; the case-study card is `min-height: 492px` (*"stable height to prevent logo-column jump"*); the skyline is a fixed `460px` stage with a `--cta-h: 110px` reservation; the stack-section nudge uses `transform: translateX(60px)` precisely because *"transform = no reflow, so nothing else on the page moves."*

---

## 6. Texture: the blueprint layer

Three permitted textures, all built from the same hairline logic — patterns of 1px lines, never images, never noise:

1. **Diagonal hatch** — `repeating-linear-gradient(45deg, var(--hatch) 0, var(--hatch) 1px, transparent 1px, transparent 9px)`. A 1px line every 9px at 45°, at 5–8% alpha: the "technical/blueprint texture." Applied to the nav bar and to both editor-window titlebars (CodeCompare, InteropTerminal) — i.e., to *chrome*, marking non-content zones the way hatching marks section cuts in a technical drawing.
2. **Diamond wire mesh** — two crossed `repeating-linear-gradient`s at ±60°, 1px line per 14px period (orphaned `.jarBody`, from the retired trash-can era) — same idea at full `--border` strength for a "container" surface.
3. **Registration marks** — the floating nav's four corners carry 11px orange crosshairs built from two crossed 1px pseudo-element arms. The positioning comment is the design system in miniature: the marks are inset `-0.5px` so their centers sit **on the middle of the 1px border line** and stay snapped to the pixel grid — *"this sits the crosshair arms directly on top of the black border lines instead of running parallel just outside them."* Print-production furniture, used as brand.

---

## 7. Motion language

### 7.1 Easing families

The site uses four named curves, each with a consistent semantic:

| Curve | Used for | Where |
|---|---|---|
| `cubic-bezier(0.4, 0, 0.2, 1)` (Material standard) | **Chrome morphs** | Nav dock detach/attach (0.4s), CTA icon slide-in (0.25s) |
| `cubic-bezier(0.16, 1, 0.3, 1)` (≈ easeOutExpo) | **Accordion growth** | Skyline `flex-grow` (0.5s), trend-chart node pops (0.45s) |
| `cubic-bezier(0.22, 1, 0.36, 1)` (≈ easeOutQuint) | **Drawers & wipes** | EvolutionBox story drawer (0.5s), EvolutionCards expansion (0.42s) |
| `cubic-bezier(0.33, 1, 0.68, 1)` (easeOutCubic) | **The lineage descent** | LineageBloom's 1.5s falling line — chosen, per the comment, so the line lands *"fast out, gentle decelerate"* with no dead pause before the bloom |

Below these: plain `ease` at 0.15–0.3s for color/opacity micro-transitions, and `linear` only for the 22s marquee. Content reveals inside expanding boxes are **delayed fades** — `opacity 0.35s ease 0.12s` — so text appears after the geometry has begun moving, never during the first frame.

### 7.2 Hover is the primary verb

Nearly every interactive surface answers hover with a **full-surface fill flip** rather than an outline or shadow change. The inventory:

| Surface | Rest → Hover |
|---|---|
| Nav bar | white+hatch → **orange flood**, text white, corners melt transparent, logo inverts to white |
| Bento box (skyline) | white → **black** (`--foreground` fill), column widens to 2.6×, box grows 4×, description/pip fade in |
| Ecosystem CTA | black → **orange** (color only — shape deliberately static) |
| Project card | white → **black**, lifts `translateY(-2px)`, media/canvas fades in over a 3-stop scrim, description fades *out*, arrow shifts `(2px,-2px)` and goes orange |
| Logo card (ProofGrid) | white/grayscale → **orange flood**, logo knocked out white |
| Case-study card | white → **orange flood**, all text white |
| Paper row | indents `padding-left` +10–16px, orange flood (grid version) / key badge goes orange (page version), arrow shifts `(3px,-3px)` |
| Manifesto box | white → **orange** on hover, **black** when pinned open |
| EvolutionBox | orange drawer wipes in from the right (480px), width `0 → var(--storyW)` |
| BlockTower block | white faces → **orange**, name white, logo inverted |
| CTA buttons | white → **orange flood** + hidden brand icon slides in (width 0→18px, margin 0→10px) |
| WebGL cards | *the render itself only runs on hover* (§10.2) |

Two disciplined variations: the ecosystem CTA changes **only color, never shape** (*"hovering the CTA keeps its shape"*) so the skyline baseline stays stable; and the accordion behaviors are gated behind `@media (hover: hover) and (min-width: 901px)` so touch devices get everything expanded statically instead of unreachable hover states.

### 7.3 Scroll choreography

Scroll-driven behavior is used sparingly and always **one-way / one-shot**:

- **NavDetach** (`NavDetach.tsx`): a 33-line client component whose only job is toggling `nav-detached` on `<html>` when `scrollY > 6`. Passive listener, syncs on mount for mid-page reloads. All the visual work is CSS: the dock's sticky `top` goes 0→12px, the bar's `max-width` 100%→1400px, padding 24/48→14/28, the full border fades in, corners appear. The comment notes the trick: the vertical gap comes from the sticky `top` offset, *"not extra height, so nothing below it shifts."*
- **LineageBloom**: IntersectionObserver at threshold 0.2 adds `.play` once, then **disconnects** — the constellation never re-blooms on scroll-back.
- **InteropTerminal**: IO at threshold 0.05 pauses/resumes the rAF loop offscreen.
- Anchor jumps (`#ecosystem-grid`) use motion-safe `scroll-behavior: smooth` with `scroll-margin-top: 96px` clearing the sticky nav.
- The heavier scroll machinery (the benched `AbstractionTrendScroll`'s `--reveal` CSS-var mapping `p = clamp01((0.88·vh − rect.top) / (0.56·vh))` with a smoothstep, and the removed full-page background graph) was **cut from the live page** — the shipped design decided scroll should trigger moments, not drive continuous animation.

### 7.4 Autonomous motion

Only three things move without input, all justified as demos or signage:

- **Typewriter** (hero): types at 85ms/char, deletes at 42ms/char, holds a completed word 3700ms, pauses 450ms before the next. The caret is the word's own right border (`0.06em solid currentColor`, 1.1s `step-end` blink) so it auto-scales with the headline. The cleverest logic preserves the shared "AI " prefix across "AI Applications. → AI Agents. → AI Workflows." — only the trailing word is backspaced, so "AI" never flickers; it is deleted only when cycling to "everything."
- **InteropTerminal**: a fully time-driven `render(t)` over a compiled step timeline (type 45ms/char with 0.22s lead/0.18s tail beats, 0.9–1.05s progress bars of `█`/`░` glyphs, 3.3–3.6s segment holds, 0.53s cursor blink), looping through the PyPI → npm → C-ABI story while the matching titlebar chip lights orange.
- **JacPacks marquee**: eight identical vertical phrases translated `-12.5%` over 22s linear — the comment shows the math: *"gap 0 → −12.5% advances exactly one phrase: seamless loop."*

### 7.5 Reduced motion

`prefers-reduced-motion: reduce` is handled per-component, not with a blanket kill switch, and each fallback is a *designed final state*:

| Component | Reduced-motion behavior |
|---|---|
| Smooth scrolling | disabled (gated at the `html` level) |
| Nav morph, corners | transitions off (state still switches instantly) |
| Typewriter | first word held forever, caret hidden |
| AbstractionTrend | full chart rendered, no draw-in |
| LineageBloom | full web at final opacity, line pre-drawn, **no rAF drift loop at all** |
| InteropTerminal | one static completed frame (first segment), no loop |
| BlackHole / NeuralNetwork | canvas never starts; static gif immediately |
| JacPacks marquee | animation off |
| CTA icons | width animation dropped, opacity-only |
| Manifesto/EvolutionCards | transitions none |

One known gap: `CaseStudyCarousel`'s 0.28s `caseFade` slide transition has no reduce guard (it is a 6px translate + fade — minor, but the only unguarded animation on the page).

---

## 8. The narrative spine, section by section

The page is nine beats. Each beat pairs one copy move with one bespoke component; **no component is reused between beats** — every argument gets its own purpose-built visual.

### 8.1 Nav — the instrument panel

Flush full-width bar → floating bordered box on first scroll (§7.3). Contents: hexagon logo + mono `JAC` wordmark (18px/700), four external links (Projects / Blog / Docs / Community), and the ThemeToggle — a 26px bordered square whose sun/moon glyph is drawn in `currentColor` so it *"rides every nav state for free: ink on the flat bar, white on the orange hover fill, inverted ink in dark"* (hover: a 35° rotate). The whole bar flooding orange on hover makes the site's chrome itself the first demonstration of the accent system.

### 8.2 Hero — claim + install + chart

Grid `1.15fr : minmax(400px, 1fr)`, `min-height: 620px`, headline column deliberately sized so *"the headline lines never wrap at the 84px cap"* while the chart gets almost half the row.

- **Headline**: "Jac, the language built for `[typewriter]`" cycling *AI Applications. / AI Agents. / AI Workflows. / everything.* — the rotating word in orange, the "AI" prefix held in ink (a `.lead` override), so the accent lands only on what changes.
- **InstallBox**: explicitly *"modelled on bun.sh's install box"* — two OS tabs (Linux & macOS / Windows WSL, 2px muted borders collapsing at −2px, active tab orange) over a 2px-**accent**-bordered command block (the only accent-bordered container on the page: the install command is the single most important box) with a copy button (1600ms ✓ flash; long commands ellipsize visually but `navigator.clipboard` always receives the full string).
- **AbstractionTrend** (server component, zero JS): a 740×576 SVG staircase chart titled `HOW FAR EACH LANGUAGE ROSE ABOVE THE MACHINE`. Five tier gridlines (MACHINE / SYSTEMS / MANAGED / DYNAMIC / AI-NATIVE at y 457/375/302/229/100), dotted `1 6`, with nodes: Assembly (96,457) → C (256,375) → Java (416,302) → Python (496,229) → **Jac (656,100)**. The chart makes an *editorial* claim through visual weight: C++ (336,375) and JS/TS (576,229) sit at the same height as their predecessors, so they are demoted to small 4.5px muted dots — *"they recede… then Jac: the leap, in orange"* at 9px with a 3.5px orange stroke, a hatched area fill, and a `THE LEAP` annotation at 0.22em tracking. Draw-in is pure CSS (pathLength dash trick), 0→2.25s staggered, with the money node landing *"with a slight overshoot."*

### 8.3 The stack — "Jac is more efficient than Python and its abstractions."

**BlockTower** (server, CSS-3D): a 294×64×104px-block Jenga tower under `perspective: 1500px`, rotated `rotateX(-14°) rotateY(30°)`. Python at the base; LangChain, LangGraph, LlamaIndex, Pydantic AI, CrewAI, AutoGen, DSPy, Haystack piled above (logos reused from the retired jar era, `public/jar/*.svg`); "Your Application" — the only dark block — cantilevered 150px off the edge at the top, *"about to fall."* Instability is computed, not hand-placed: drift `−68·t^1.7`, side jitter `32·sin(2.6i)·t^1.5`, depth wander `26·sin(1.7i)·t^1.5`, plan twist `10·sin(1.45i)·t^1.5` — all super-linear in height so the tower gets visibly drunker as it rises, and fully deterministic *"so SSR/client agree."* Beside it, **ManifestoAccordion** in its `tower` variant renders the counter-argument as its own stack: claim boxes widening linearly from 68% to 96% with an 11px black extrusion (`::before` offset by `translate(11px, 11px)`) — a *stable* pyramid against the teetering tower. Single-open accordion, `grid-template-rows: 0fr→1fr` height animation, orange on hover / black when open.

### 8.4 The receipt — "The same to-do app, built twice."

**CodeCompare**: two 640px editor windows (`1fr 1fr`, 28px gap, stacking under 1020px) with a 44px `VS` stamp between them. Left: one Jac file, 120 lines. Right: the same app as React+Flask across **eight** tabbed files (App.jsx, api.js, main.jsx, server.py, index.html, vite.config.js, package.json, requirements.txt), 346 lines. The status bars state the receipt in mono: `$ jac start app.jac · 120 lines · 1 process` vs `$ python server.py & npm run dev · 346 lines · 2 processes + CORS`. Window chrome is codified as shared DNA — *"same DNA as InteropTerminal: white surfaces, hairline black chrome, the nav's diagonal hatch on the titlebars, JetBrains mono, orange accent. Sharp corners, no shadows"* — with 38px titlebars, 9px traffic lights, 34px right-aligned gutters ruled by `--hairline-faint`, 12px/1.6 code. Native scrollbars are hidden and replaced with overlay thumbs (4px vertical, 2px under the tab strip) that appear on hover or while scrolling and fade 700ms after the last scroll — the panes read as *documents* until touched.

### 8.5 Proof — "Backed by the names you already trust."

**ProofGrid** (server) is a full-viewport room (`min-height: 100vh`, flex-centered): a `minmax(168px,224px) : 1fr` top row (three stacked logo cards beside the case-study carousel) over an `auto 1fr 1fr` bottom row (a mono `Backed by research →` link to the Michigan lab + two paper cards). The design history matters: this replaced an interactive full-viewport "cursor-slit" prototype (**ProofSlits**, glow + reveal) that was built and deleted — the recorded verdict was for *"separate bordered cards on white, hairline borders, orange accent — no frame, no glow, no gradients."* Papers are cited with real identifiers (OSP `arXiv:2503.15812 · cs.PL`; MTP `OOPSLA 2025 · arXiv:2405.08965`) styled as badge+title+venue rows. **CaseStudyCarousel** (the one client island inside): Tobu is real data ($1.5M raised, 92.84% retrieval accuracy, 2.2× fewer missed memories, a pull-quote with citation); Pocketnest, Ally, and TrueSelph ship as honest "Under Development" stubs with X placeholders. Slides swap by re-mounting with `key={i}` through a 0.28s fade-up.

### 8.6 The ask — "Developers needed ~~more~~ interop."

The headline strikes through "more" with an **orange strike over black text** (`.strikeMore` — the word stays ink; only the line through it is accent) and answers in orange: *interop.* Below, **EvolutionBox**: a fixed 340px hairline slab, headline left ("So, Jac became npm, PyPI and C-ABI interoperable."), and a flush 480px right panel running **InteropTerminal** — the looping three-target compile demo (§7.4). Hovering the statement (or keyboard focus) wipes an **orange story drawer** over the terminal (width 0→480px, 0.5s easeOutQuint); a +/− button freezes it open (`data-open` flips the whole slab to black-on-white-inverted). On touch (≤900px) the drawer politely becomes a permanently-open stacked block.

### 8.7 Lineage — Jac blooms into Jaseci

**LineageBloom**: a full-bleed 1600×620 SVG constellation. A thin line descends 1.5s from "Jac" (740,64) to the "Jaseci" hub (740,310); on landing, the hub *explodes* into a triangulated web — a 27×7 jittered grid (±52% cell jitter, 10% cells skipped, a clear corridor kept above the hub for the descent), short edges ≤130 units (95% connect probability at the hub, 82% elsewhere), 22% longer struts ≤290, and a guarantee that *"every point is woven in — no loose dust."* Depth is faked spectrally: radius `1.1+2.9d`, dot opacity `0.12→0.97`, stroke `0.4→2.5px`, opacity `0.16→0.82`. The growth wave propagates by hop distance (1.5s start + 1.3s spread, per-element `--d` delays). Then the web *lives*: after a 2s+1.8s smoothstep envelope, every point samples **one shared flow field** (3 sinusoidal fields per axis, amplitudes 7–15 units, plus a 4.5%/0.12Hz radial breath) so *"neighbours move together and the whole web undulates organically."* Hydration is solved structurally: geometry comes from a **fixed-seed PRNG computed identically on server and client** (coords rounded to kill float drift); only the drift loop is client-side. 3-clique triangles carry invisible hover cells that tint orange. This component is the page's thesis rendered as figure: one language becoming an ecosystem.

### 8.8 Ecosystem — "We built Jaseci. The Ecosystem."

The skyline: 12 modules in 6 columns whose heights come from a hand-tuned config — `[(1 box, 44%), (2, 64%), (1, 52%), (4, 94%), (1, 68%), (3, 100%)]` — with the comment insisting the irregularity is the point: *"deliberately irregular — the heights jump and dip rather than climbing evenly — so it reads as a skyline, not a clean staircase."* (An earlier strictly-monotonic staircase version is preserved in the screenshot archive.) Columns sit on a shared baseline in a fixed 460px stage, hairlines collapsed via −1px margins; the mono header parks in the negative space above the short left columns. Hover runs a two-axis accordion — column `flex-grow: 2.6`, hovered box `flex-grow: 4` with a black fill — under `easeOutExpo 0.5s`; two flagship tiles (`jac-client`, `jac-scale`) ship pre-expanded at `2.6`. The bottom-right **CTA is itself a skyline block** (110px reservation) that grows with its column but answers its own hover with color only. Every tile is a live `<a>` to its GitHub source. The stat system is a designed micro-language (`0 Prompts`, `0 Middleware`, `1 Decorator`, `C-level Fast`): flags control whether the completing word shows at rest (`statWordStatic`), whether an abbreviation yields to the full word on expand (`accentExpands`), and whether the orange lands on the number or the word (`accentWord`) — *"scattered across tiles so the accent reads as random."*

### 8.9 Projects, final hook, footer

- **Projects**: intro column ("Why did you start coding?" + the Dennis Ritchie paragraph — the one place the site argues from history in prose) beside a 2×2 card grid and a 56px vertical marquee banner. The four cards escalate in evidence quality: two gif reveals (Todo, FPS), then the two **live** WebGL renders (§3.1, §10.2), each stamped with a mono cost-of-construction meta line: *Built in Jac / Built in a weekend / Built in 4 Days / Built solo.*
- **Final hook**: `Stay with the old.` / `Get left behind.` (second line orange) at up to 92px mono 800, nowrap both lines; three 2px-bordered CTAs whose brand icons (Discord/GitHub/Spotify inline SVG paths) are collapsed to width 0 and slide in on hover *and* `:focus-visible`. The podcast CTA ships as an honest `href="#"` with a swap-in comment.
- **Footer**: a full-bleed **orange flood** — the comment ties it to the system: *"mirrors the nav:hover fill — white text on --accent."* The page thus opens with chrome that *can* turn orange and closes with chrome that *is* orange. Fixed white-on-orange in both themes; the logo is knocked out via `filter: brightness(0) invert(1)`. Inside: 1.3fr/2fr brand+links grid, hairline `rgba(255,255,255,0.28)` bar, mono uppercase legal line, "Made with ♥ by the Jaseci community."

---

## 9. Theming architecture (dark mode)

Dark mode arrived late (the design was locked as light-only B&W first) and was retrofitted **entirely through the token layer** — which the token discipline made nearly free:

1. **Flip mechanism**: `html[data-theme="dark"]` swaps the token block (§2.1) and sets `color-scheme: dark`. No component ships its own dark stylesheet unless it holds non-token color.
2. **No flash of wrong theme**: a parser-blocking inline script is the *first thing in `<body>`* — saved `localStorage["jac-theme"]` wins, else `prefers-color-scheme`, applied to `document.documentElement.dataset.theme` before first paint. `<html>` carries `suppressHydrationWarning` scoped to exactly this expected mismatch.
3. **Stateless toggle**: ThemeToggle renders **both** sun and moon always (identical markup in both themes → nothing to hydrate wrong); CSS picks the visible glyph by `data-theme`, showing *the mode you'd switch to*. The click reads live DOM state rather than React state; persistence failures (private mode) are silently tolerated.
4. **Local overrides only where tokens can't reach**: the globals comment enumerates them — logo `filter`s, BlockTower's dark-block shading (`#000/#202020/#383838` light → `#ededed/#d9d9d9/#ffffff` dark), hex-tile hovers, ProofGrid's grayscale logos gaining `invert(1)`.
5. **Deliberately theme-fixed surfaces**: the WebGL cards (black is the render's void), project-card hover fills (`#000`/`#fff` — the media scrim needs true black), and the footer (orange/white is the brand close) do not invert. Fixed color here is a decision, not an omission.

---

## 10. Rendering & performance architecture

### 10.1 Server-first, islands-second

`page.tsx` is a **server component**; so are AbstractionTrend, BlockTower, and ProofGrid — three of the most visually complex elements ship as zero-JS HTML/SVG/CSS. Client islands exist only where state or rAF demands: NavDetach (33 lines), ThemeToggle, Typewriter, InstallBox, ManifestoAccordion, EvolutionBox(+InteropTerminal), CodeCompare, CaseStudyCarousel, LineageBloom, BlackHole, NeuralNetwork.

Three distinct **SSR-determinism strategies** keep server and client pixel-identical:

- LineageBloom: fixed-seed PRNG + rounded coordinates (*"no Math.cos/sin hydration mismatch"*).
- BlockTower: closed-form trig lean, *"deterministic (no random) so SSR/client agree."*
- Typewriter: the first word renders complete on the server (*"no empty flash"*), then the loop backspaces it — so the type-out is still seen every cycle.

### 10.2 The WebGL performance contract

Both three.js cards obey the same self-imposed contract:

- **Render only while hovered AND on-screen** (pointerenter/leave on the parent `<a>` + IntersectionObserver; a `:hover` check at mount catches a pointer already resting).
- **DPR capped at 2**; BlackHole's distortion pass runs at **half resolution** (`bh >> 1`); bloom tuned to 1.5/0.4/0.68.
- **Graceful degradation ladder**: no WebGL2 → the original gif; `prefers-reduced-motion` → gif immediately; unmount → full dispose of geometries/materials/render targets.
- Additive blending with `depthWrite: false`; `ColorManagement` disabled in BlackHole to match the source build's raw-sRGB pipeline.

Elsewhere: InteropTerminal repaints **only when the frame's HTML actually changes** (string diff) and clamps `dt` to 0.1s so a background tab doesn't lurch the loop; scroll listeners are passive; gif weight (blackhole 3.2MB, network 1.8MB) is deferred behind failure/hover paths, and card gifs are `loading="lazy"`.

### 10.3 CLS discipline

Enumerated in §5.3 — the general law: **anything that animates owns a fixed reservation.** The page's layout is immutable under every interaction except the accordions' internal redistribution, which redistributes *within* fixed stages.

---

## 11. Accessibility inventory

- **Decorative canvases/SVGs narrate themselves**: LineageBloom carries `role="img"` with a full-sentence description of the animation ("A line slowly descending from Jac… explodes into a wide, interconnected black web… drifting and breathing like a living constellation"); InteropTerminal, AbstractionTrend, and BlockTower (label built dynamically from the block list) do the same. Pure decoration (traffic lights, arrows, WebGL) is `aria-hidden`.
- **Real semantics on interactive patterns**: `role="tablist"/"tab"` + `aria-selected` on CodeCompare's file tabs and InstallBox's OS tabs; `aria-roledescription="carousel"` + labelled prev/next buttons on the case studies; `aria-expanded` on every accordion/freeze control; an `<ol>` for the numbered step cards.
- **Screen-reader parallel content**: Typewriter hides the animation (`aria-hidden`) and exposes all four words in an `.srOnly` span; EvolutionBox marks the visual drawer `aria-hidden` and duplicates the story for AT.
- **Keyboard parity with hover**: the EvolutionBox frame is `tabIndex={0}` and `:focus-visible` opens the drawer; CTA icons slide in on `:focus-visible`; cards expose the same expansion on focus as on hover.
- **Reduced motion** is a first-class designed state per component (§7.5), not an afterthought.
- Notable conscious trade-offs: nav/footer link affordance relies on hover styling (rest-state links are undecorated by doctrine), and hover-only reveals fall back to always-visible content on touch/mobile breakpoints rather than being lost.

---

## 12. Copy as a designed system

The copy is engineered with the same discipline as the CSS:

- **Confrontational frame**: the `<title>` is *"Jac — The solution to 50 years of developer's hell"*; the close is *"Stay with the old. / Get left behind."* The site sells urgency, not comfort.
- **A repeated syntactic formula**: every ecosystem tile's description is built on *"X. Python could not — Y did."* (twelve variations). Repetition-as-drumbeat, and it implicitly positions Python as the incumbent being succeeded — consistent with the footer's "a superset of Python."
- **Numbers as rhetoric**: the stat micro-language leads with counts of *absence* — `0 Prompts`, `0 Middleware`, `0 CSS`, `0 Auth Code`, `1 Command`, `1 Decorator` — the product's value stated as things you no longer write. The receipts section (120 vs 346 lines) is the same move at paragraph scale.
- **Meta lines as cost evidence**: *Built in a weekend / Built in 4 Days / Built solo* — effort metrics in the place a normal site would put category tags.
- **Typographic rhetoric**: the strikethrough correction (~~more~~ → **interop.**) performs editing in public; the orange strike on black text is the accent used as an *editorial mark*.
- **Honest placeholders**: stub case studies are labelled "Under Development" with X-placeholders documented for swapping; the podcast CTA's `#` href carries a swap-in comment. Nothing fakes data.

---

## 13. Design history: the bench, the stash, and the sediment

The repo is unusually legible archaeologically: rejected directions survive as unimported components ("the bench"), stashed code, orphaned CSS strata, and a screenshot archive (`../../*.png`: `stair-v1`, `tower-accordion-before/after`, `hero-jar*`, `bento-new`, `nav-corner-current`, …). The through-line of every cut: **the design repeatedly chose the calmer, stricter option.**

### 13.1 Font lineage
DM Sans → Fraunces (serif era) → Geist (shipped) → Circular + Mr Eaves XL wired as licensed upgrades (§4.1).

### 13.2 ProofSlits → ProofGrid
An interactive full-viewport cursor-slit proof section (glow + reveal, adapted from another project) was prototyped and deleted in favor of the static bordered frame. The ProofGrid source still states the verdict as doctrine: *"no frame, no glow, no gradients."*

### 13.3 The background lineage graph (removed 2026-06-18, stashed)
A fixed full-viewport scroll-driven SVG behind the whole page: a gray Assembly→C→Java→Python lineage climbing with scroll, bursting into a **colorful vibrating Jac peak** and later an exponential **Jaseci hockey-stick**. Removed at the owner's request ("delete the entire graph, but remember it"); all four files preserved verbatim in a `graph-stash/` beside the project memory, with documented re-wiring instructions. Its two lasting scars on the live code: `overflow-x: clip` in globals (the sticky-breaking `hidden` lesson) and the orphaned halo/pillar styles below. Its two ideas survived in tamer forms: the staircase chart became the hero's static `AbstractionTrend`, and the "explode into an ecosystem" beat became `LineageBloom` — black-and-white, one-shot, contained to its own section.

### 13.4 The bench (present, compiled, unrendered)
Four components remain importable but unimported — kept as a parts shelf:

| Benched component | What it was | Superseded by |
|---|---|---|
| `AbstractionTrendScroll` | Scroll-driven trend chart with the polychrome Jaseci skyrocket (gradient `#ee5a24→#ff2d9b→#8b3bff→#19e6a0`) | Static `AbstractionTrend` (server, one orange) |
| `EvolutionCards` | 01→04 horizontal accordion of story beats (fixed 196px row, `flex-grow: 3.1` expansion) | `EvolutionBox` (one slab + live terminal) |
| `FallingImages` | matter-js physics bin: logos as draggable orange flat-top hexagons (rotation locked for honeycomb packing; restitution 0.35, friction 0.45) | `BlockTower` (deterministic, server-rendered) |
| `FallingText` | matter-js word-pile (restitution 0.8) | — |

The `matter-js` dependency in `package.json` exists *only* for the bench; the live page's physics-looking pieces (tower lean, constellation drift) are all deterministic math. The `.ft-*` global classes in `globals.css` (kept global "so they survive innerHTML") and the entire `public/jar/` SVG set are jar-era survivors — the SVGs found a second life in BlockTower.

### 13.5 Orphaned CSS strata in `page.module.css`
Removed sections left their styles behind — a readable sediment column: `.jar/.jarLabel/.jarBody` (the wire-mesh "F*CK bin" trash can, 10px radius, diamond mesh), `.lead/.leadPunch/.conviction/.carry/.pillars/.pillar*` (the pinned manifesto era — including the rainbow `.pillar::before` and raw `#111`/`#1a1a1a` inks predating the token migration), `.proofTriad/.proofBlock*/.statGrid/.logoWall/.paperList/.paperRow*` (the pre-ProofGrid inline proof section), `.cardGrid/.card*`, `.eyebrow`, `.askEcoHeading`, `.why`. Notably, the orphans are where all the rule *violations* live (radii, gradient, hard-coded hex) — the live classes were migrated to tokens; the dead ones were left as-is.

### 13.6 Asset history
Backer logos began as white-on-dark PNGs (needing dark backdrops) and were replaced with clean Wikimedia SVGs rendered on white; the PNGs remain orphaned in `public/logos/`. The default create-next-app SVGs (`next.svg`, `vercel.svg`, …) were never cleaned out.

---

## 14. The rulebook, codified

The constitution the live page actually follows, with its amendments:

1. **Two colors plus one accent.** Paper, ink, derived grays, `#ee5a24`. Derive shades from the token block; never invent.
2. **Color must be evidence.** Saturation beyond the accent appears only inside live product renders and (in inverted/knocked-out form) third-party marks. Decorative gradients are banned — every one in the repo is dead code.
3. **The hairline is the only line.** 1px `--border` for structure, `--hairline-faint` for sub-structure, 2px for emphasis. Collapse shared borders with −1px margins.
4. **No shadows, no glass, no glow, no radius.** Depth = fills, borders, or true 3D.
5. **Mono is the voice of the machine**: all h2s, all labels (uppercase, +tracking), all numbers-as-furniture. The sans appears where the site speaks *to* you (hero, card titles); the body face where it *explains*.
6. **Hover floods.** Interactive surfaces answer with full fills (orange for chrome/proof, black for content tiles), gated off on touch, where the content shows expanded instead.
7. **Texture is hatched, never imaged.** 1px-line repeating gradients only, on chrome zones.
8. **Motion decelerates.** Ease-out family curves; one-shot scroll triggers; fixed-footprint animation (no CLS); every animated component defines a designed reduced-motion final state.
9. **Server unless stateful.** Deterministic SSR visuals (seeded PRNG, closed-form math); client islands only for interaction and rAF; heavy renders gated by hover × visibility with static fallbacks.
10. **Copy states receipts, not adjectives** — counts, line numbers, arXiv IDs, build-time stamps; placeholders are honest.

**Known deviations (accepted or pending):** theme-fixed surfaces (footer, project-card hover, WebGL blacks — accepted, §9.5); the carousel's unguarded 0.28s fade (minor gap); vestigial `brand` color field in ProofGrid data; orphaned CSS strata and default template SVGs (cleanup debt, not design intent).

---

## 15. Appendix: file map

```
jaseci_website_v2/
├── app/
│   ├── layout.tsx              59   fonts (Geist/JBM via next/font), metadata, pre-hydration theme script
│   ├── globals.css            169   tokens (light+dark), Circular @font-face slots, resets, .ft-* jar-era globals
│   ├── page.tsx               792   the whole narrative; ecosystem data model + hand-tuned skyline layout
│   ├── page.module.css       1827   nav morph, hero, sections, skyline accordion, projects, CTAs, footer,
│   │                                responsive (900/768/520) + orphaned strata (jar, pillars, old proof)
│   └── components/
│       ├── NavDetach.tsx                33   scroll>6px → html.nav-detached          [client]
│       ├── ThemeToggle.tsx/.css      66/49   stateless sun/moon, localStorage         [client]
│       ├── Typewriter.tsx/.css      111/53   85/42ms type/delete, 3.7s hold, AI-prefix floor [client]
│       ├── InstallBox.tsx/.css     128/128   bun.sh-style tabs + copy (1600ms flash)  [client]
│       ├── AbstractionTrend.tsx/.css 253/371 hero SVG staircase chart, CSS draw-in    [server]
│       ├── BlockTower.tsx/.css     106/199   CSS-3D leaning tower, deterministic      [server]
│       ├── ManifestoAccordion.tsx/.css 85/210 single-open claims; tower variant       [client]
│       ├── CodeCompare.tsx/.css    585/343   120- vs 346-line receipt, overlay thumbs [client]
│       ├── ProofGrid.tsx/.css      115/505   logos + carousel + papers, 100vh room    [server]
│       ├── CaseStudyCarousel.tsx       157   Tobu + 3 stubs, 0.28s caseFade           [client]
│       ├── EvolutionBox.tsx/.css    62/263   340px slab + orange drawer + terminal    [client]
│       ├── InteropTerminal.tsx/.css 486/201  time-driven 3-target compile loop        [client]
│       ├── LineageBloom.tsx/.css   578/206   seeded SSR constellation + flow-field drift [client]
│       ├── BlackHole.tsx               608   three.js lensing render, hover-gated     [client]
│       ├── NeuralNetwork.tsx           727   three.js bloomed cortex, hover-gated     [client]
│       ├── AbstractionTrendScroll.*  270/238 BENCHED — scroll-var chart, polychrome peak
│       ├── EvolutionCards.tsx/.css  59/226   BENCHED — 4-step horizontal accordion
│       ├── FallingImages.tsx/.css   321/61   BENCHED — matter-js hex/logo bin
│       └── FallingText.tsx             218   BENCHED — matter-js word pile
├── public/
│   ├── jaseci-logo.png               nav/footer hexagon mark
│   ├── logos/{nvidia,umich,nsf}.svg  active backer marks (+ orphaned .png originals)
│   ├── jar/*.svg                     9 framework logos (jar-era, reused by BlockTower)
│   ├── {todo,fps}.gif                card hover media (lazy)
│   ├── {blackhole,network}.gif       WebGL fallbacks (3.2MB / 1.8MB)
│   └── fonts/README.md               Circular drop-in instructions (no .woff2 shipped)
├── package.json                      next 16.2.9, react 19.2.4, three ^0.171, matter-js ^0.20 (bench-only)
└── AGENTS.md / CLAUDE.md             "not the Next.js you know" — check node_modules/next/dist/docs
```

*Ops note: deploys are manual (`vercel --prod`); pushing to git does not deploy.*
