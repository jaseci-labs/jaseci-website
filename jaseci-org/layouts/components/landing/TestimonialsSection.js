"use client";

import { useRef, useEffect, useCallback } from "react";

const testimonials = [
  {
    quote:
      "Jaseci is a game changer for ProServe because it allows us to build full stack prototypes quickly and transition them to production with zero friction.",
    hl: ["game changer", "zero friction"],
    name: "Asim Salim",
    tag: "featured",
    chips: [
      { text: "BCS Technologies", tone: "org" },
      { text: "ProServe", tone: "org" },
    ],
  },
  {
    quote:
      "Jaseci's architecture gives our team a framework that feels intentional — it is not glue code on top of an LLM API. The emphasis on simplifying complex AI integration and prompt and model evaluation aligns with how enterprise teams actually think about building maintainable systems.",
    hl: ["not glue code on top of an LLM API"],
    name: "Pat Rinaldo",
    tag: "featured",
    chips: [
      { text: "Ally Bank", tone: "org" },
      { text: "Enterprise AI practitioner", tone: "org" },
    ],
  },
  {
    quote:
      "I see byLLM as a valuable innovation that could make LLM integration easier to develop, more maintainable and enterprise-ready.",
    hl: ["more maintainable and enterprise-ready"],
    name: "Brian Yang",
    tag: "featured",
    chips: [
      { text: "Genesys", tone: "org" },
      { text: "Enterprise AI practitioner", tone: "org" },
    ],
  },
  {
    quote:
      "Using Jaseci, our small engineering team has delivered features that would have required significantly more time and infrastructure with conventional tools. The byLLM component has enabled faster iteration, higher consistency, and measurable improvements in AI-driven user experience.",
    hl: [
      "small engineering team has delivered features",
      "faster iteration, higher consistency",
    ],
    name: "Patrick McLaughlin",
    tag: "featured",
    chips: [{ text: "Founder of Tobu", tone: "org" }],
  },
  {
    quote:
      "I particularly liked the unified full-stack experience, graph-based programming model, and the byLLM keyword for native AI integration. Together, they reduced boilerplate, accelerated development, and made it easier to focus on building intelligent applications rather than managing multiple tools and frameworks.",
    hl: ["reduced boilerplate, accelerated development"],
    name: "Sarath Kothapalli",
    tag: "jachacks",
    chips: [
      { text: "1–2 yrs coding exp.", tone: "exp" },
      { text: "Brand new to Jac", tone: "new" },
    ],
  },
  {
    quote:
      "The one language end to end development was great because it made it really easy to build using the language and change ideas with the AI understanding everything it was doing from the start. It was really seamless, the agent understood the language and architecture much easily and wrote better more streamlined code overall.",
    hl: ["one language end to end", "really seamless"],
    name: "Aditya Das",
    tag: "jachacks",
    chips: [
      { text: "5–10 yrs coding exp.", tone: "exp" },
      { text: "Brand new to Jac", tone: "new" },
    ],
  },
  {
    quote:
      "The unified programming paradigm and the graph-based model make structuring full-stack AI workflows cleaner and more intuitive.",
    hl: ["cleaner and more intuitive"],
    name: "Rafael Lopez",
    tag: "jachacks",
    chips: [
      { text: "10+ yrs coding exp.", tone: "exp" },
      { text: "Brand new to Jac", tone: "new" },
    ],
  },
  {
    quote:
      "I liked how I could do everything in one language and didn't have to move between frameworks.",
    hl: ["everything in one language"],
    name: "Vachan Bhogi",
    tag: "jachacks",
    chips: [
      { text: "5–10 yrs coding exp.", tone: "exp" },
      { text: "Py · JS/TS · Java · C/C++ · Rust", tone: "stack" },
    ],
  },
  {
    quote:
      "The graph-based part and the walkers allowed us to come up with a really unique solution for finding multi drug synergies which I found interesting.",
    hl: ["a really unique solution"],
    name: "Zorawar Brar",
    tag: "jachacks",
    chips: [
      { text: "3–5 yrs coding exp.", tone: "exp" },
      { text: "Brand new to Jac", tone: "new" },
    ],
  },
  {
    quote:
      "Graph-based programming also felt very natural for this problem. Since the system is inherently graph-structured, modeling it directly as nodes and edges made the logic easier to reason about.",
    hl: ["easier to reason about"],
    name: "Yanshengtian Dong",
    tag: "jachacks",
    chips: [
      { text: "1–2 yrs coding exp.", tone: "exp" },
      { text: "Brand new to Jac", tone: "new" },
    ],
  },
  {
    quote:
      "I just like the different approach of byLLM instead of prompt engineering. It also meant having a more clean and understandable codebase which is a huge plus.",
    hl: ["byLLM instead of prompt engineering"],
    name: "Yousef Al-Wahami",
    tag: "jachacks",
    chips: [
      { text: "3–5 yrs coding exp.", tone: "exp" },
      { text: "Brand new to Jac", tone: "new" },
    ],
  },
  {
    quote:
      "I really like the graph based memory and AI native design. Smooth interaction with other tech stack. Clean agent building.",
    hl: ["graph based memory and AI native design"],
    name: "Nitish Kumar Singh",
    tag: "jachacks",
    chips: [
      { text: "3–5 yrs coding exp.", tone: "exp" },
      { text: "Built with Jac before", tone: "star" },
      { text: "10/10 would use again", tone: "star" },
    ],
  },
];

const chipTones = {
  exp: "border-amber-400/40 bg-amber-400/10 text-amber-300",
  new: "border-emerald-400/40 bg-emerald-400/10 text-emerald-300",
  star: "border-primary-orange/50 bg-primary-orange/10 text-primary-orange",
  stack: "border-sky-400/40 bg-sky-400/10 text-sky-300",
  org: "border-white/15 bg-white/[0.06] text-gray-300",
};

const escapeRe = (s) => s.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");

// Wrap each card's standout phrase in a glowing highlight so a visitor
// scanning the band catches the strongest claims first.
const renderQuote = (quote, hl) => {
  if (!hl || hl.length === 0) return quote;
  const pattern = new RegExp(`(${hl.map(escapeRe).join("|")})`, "g");
  return quote.split(pattern).map((part, i) =>
    hl.includes(part) ? (
      <mark
        key={i}
        className="bg-primary-orange/15 text-white font-semibold rounded px-1 py-0.5 -mx-0.5 box-decoration-clone"
      >
        {part}
      </mark>
    ) : (
      part
    ),
  );
};

const initials = (name) =>
  name
    .split(" ")
    .map((w) => w[0])
    .slice(0, 2)
    .join("");

// Longer quotes get wider cards so every card wraps to a similar number
// of lines — the row then stretches all cards to one uniform height and
// only trivial leftover space remains, centered around the quote.
const widthClass = (t) => {
  const len = t.quote.length;
  if (len > 220) return "w-[92vw] max-w-[600px] sm:w-[600px]";
  if (len > 120) return "w-[90vw] max-w-[460px] sm:w-[460px]";
  return "w-[85vw] max-w-[360px] sm:w-[360px]";
};

const COPIES = 3;
const AUTO_SPEED = 30; // px per second
const RESUME_DELAY = 2500; // ms after the last manual interaction

const TestimonialsSection = () => {
  const trackRef = useRef(null);
  const hoverRef = useRef(false);
  const holdUntilRef = useRef(0);
  const carryRef = useRef(0);

  const getCopyWidth = useCallback(() => {
    const el = trackRef.current;
    if (!el) return 0;
    const cols = el.querySelectorAll("[data-col]");
    if (cols.length <= testimonials.length) return 0;
    return cols[testimonials.length].offsetLeft - cols[0].offsetLeft;
  }, []);

  // Start on the middle copy so there is always content on both sides.
  useEffect(() => {
    const el = trackRef.current;
    const copyW = getCopyWidth();
    if (el && copyW) el.scrollLeft = copyW;
  }, [getCopyWidth]);

  // Auto-scroll: a slow continuous drift, paused while the user hovers,
  // touches, or has scrolled by hand within the last RESUME_DELAY ms.
  useEffect(() => {
    const el = trackRef.current;
    if (!el) return;
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) return;

    let rafId;
    let lastTime = null;

    const tick = (time) => {
      rafId = requestAnimationFrame(tick);
      if (lastTime === null) {
        lastTime = time;
        return;
      }
      const dt = Math.min(time - lastTime, 100);
      lastTime = time;
      if (hoverRef.current || time < holdUntilRef.current) return;

      const step = (AUTO_SPEED * dt) / 1000 + carryRef.current;
      const target = el.scrollLeft + step;
      el.scrollLeft = target;
      // scrollLeft rounds to device pixels; carry the lost fraction forward
      carryRef.current = Math.max(0, Math.min(1, target - el.scrollLeft));
    };

    rafId = requestAnimationFrame(tick);
    return () => cancelAnimationFrame(rafId);
  }, []);

  const pauseAuto = () => {
    holdUntilRef.current = performance.now() + RESUME_DELAY;
  };

  // Circular scroll: drifting out of the middle copy silently jumps one
  // copy-width back to the identical position, so the band never ends.
  const handleScroll = () => {
    const el = trackRef.current;
    const copyW = getCopyWidth();
    if (!el || !copyW) return;
    if (el.scrollLeft < copyW * 0.5) {
      el.scrollLeft += copyW;
    } else if (el.scrollLeft > copyW * 1.5) {
      el.scrollLeft -= copyW;
    }
  };

  const scrollByCard = (dir) => {
    const el = trackRef.current;
    if (!el) return;
    pauseAuto();
    const col = el.querySelector("[data-col]");
    const step = col ? col.offsetWidth + 24 : 420;
    el.scrollBy({ left: dir * step, behavior: "smooth" });
  };

  return (
    <section
      id="testimonials"
      className="relative overflow-hidden bg-dark-bg py-20 sm:py-24 lg:py-28 border-t border-white/10 scroll-mt-24"
    >
      {/* Ambient glow */}
      <div className="absolute inset-0 pointer-events-none">
        <div className="absolute top-0 left-[15%] w-[480px] h-[480px] bg-primary-orange/[0.06] rounded-full blur-3xl"></div>
        <div className="absolute bottom-0 right-[10%] w-72 h-72 bg-amber-600/[0.06] rounded-full blur-3xl"></div>
      </div>

      <div className="relative z-10">
        {/* Header */}
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex flex-wrap items-end justify-between gap-6">
            <div className="min-w-0">
              <p className="font-mono text-xs tracking-[0.3em] uppercase text-primary-orange mb-5">
                community
              </p>
              <h2 className="text-3xl sm:text-4xl lg:text-5xl font-semibold tracking-tight text-white text-balance leading-tight">
                Hear what builders and the
                <span className="block bg-gradient-to-r from-primary-orange to-primary-yellow bg-clip-text text-transparent pb-1">
                  community think about Jac.
                </span>
              </h2>
              <p className="mt-5 text-base sm:text-lg text-dark-text/90 leading-relaxed max-w-xl">
                Enterprise teams shipping to production, startup founders
                building on the stack, and first-time Jac developers at
                JacHacks — in their own words.
              </p>
            </div>

            {/* Arrows */}
            <div className="hidden sm:flex items-center gap-3 pb-1">
              <button
                type="button"
                aria-label="Scroll testimonials left"
                onClick={() => scrollByCard(-1)}
                className="w-10 h-10 rounded-full border border-white/15 text-white flex items-center justify-center transition-all duration-300 hover:border-primary-orange/50 hover:text-primary-orange"
              >
                <svg className="w-4 h-4" fill="none" stroke="currentColor" strokeWidth="2.5" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" d="M15 19l-7-7 7-7" />
                </svg>
              </button>
              <button
                type="button"
                aria-label="Scroll testimonials right"
                onClick={() => scrollByCard(1)}
                className="w-10 h-10 rounded-full border border-white/15 text-white flex items-center justify-center transition-all duration-300 hover:border-primary-orange/50 hover:text-primary-orange"
              >
                <svg className="w-4 h-4" fill="none" stroke="currentColor" strokeWidth="2.5" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" d="M9 5l7 7-7 7" />
                </svg>
              </button>
            </div>
          </div>
        </div>

        {/* Circular swipeable band */}
        <div className="relative mt-10 sm:mt-12">
          {/* Edge fades */}
          <div className="absolute inset-y-0 left-0 w-8 sm:w-16 bg-gradient-to-r from-dark-bg to-transparent z-10 pointer-events-none"></div>
          <div className="absolute inset-y-0 right-0 w-8 sm:w-16 bg-gradient-to-l from-dark-bg to-transparent z-10 pointer-events-none"></div>

          <div
            ref={trackRef}
            onScroll={handleScroll}
            onMouseEnter={() => {
              hoverRef.current = true;
            }}
            onMouseLeave={() => {
              hoverRef.current = false;
            }}
            onWheel={pauseAuto}
            onPointerDown={pauseAuto}
            onTouchStart={pauseAuto}
            onTouchMove={pauseAuto}
            className="flex items-stretch gap-6 overflow-x-auto px-4 sm:px-8 pb-4 [scrollbar-width:none] [-ms-overflow-style:none] [&::-webkit-scrollbar]:hidden"
          >
            {Array.from({ length: COPIES }).map((_, copy) =>
              testimonials.map((t, idx) => (
                <figure
                  key={`${copy}-${idx}`}
                  data-col
                  aria-hidden={copy !== 0}
                  className={`shrink-0 ${widthClass(t)} flex flex-col rounded-2xl border p-7 sm:p-8 transition-all duration-300 ${
                    t.tag === "jachacks"
                      ? "border-white/20 bg-white/[0.05] shadow-lg shadow-white/[0.04] hover:border-white/40 hover:bg-white/[0.08]"
                      : "border-white/10 bg-white/[0.03] hover:border-primary-orange/40 hover:bg-white/[0.05]"
                  }`}
                >
                  <div className="flex items-center justify-between gap-3">
                    <svg
                      className="w-6 h-6 text-primary-orange/70 shrink-0"
                      fill="currentColor"
                      viewBox="0 0 24 24"
                      aria-hidden="true"
                    >
                      <path d="M9.983 3v7.391c0 5.704-3.731 9.57-8.983 10.609l-.995-2.151c2.432-.917 3.995-3.638 3.995-5.849h-4v-10h9.983zm14.017 0v7.391c0 5.704-3.748 9.571-9 10.609l-.996-2.151c2.433-.917 3.996-3.638 3.996-5.849h-3.983v-10h9.983z" />
                    </svg>
                    {t.tag === "jachacks" ? (
                      <span className="inline-flex items-center gap-1.5 font-mono text-[0.6rem] tracking-[0.15em] uppercase font-semibold rounded-full px-2.5 py-1 shrink-0 bg-gradient-to-r from-white via-gray-100 to-gray-300 text-black shadow-md shadow-white/20">
                        <svg className="w-3 h-3" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                          <path d="M13 2L3 14h7l-1 8 10-12h-7l1-8z" />
                        </svg>
                        JacHacks Participant
                      </span>
                    ) : (
                      <span className="font-mono text-[0.6rem] tracking-[0.15em] uppercase font-semibold rounded-full px-2.5 py-1 shrink-0 bg-gradient-to-r from-primary-orange to-primary-yellow text-black shadow-md shadow-primary-orange/25">
                        Featured
                      </span>
                    )}
                  </div>

                  <blockquote className="mt-4 flex-1 flex flex-col justify-center">
                    <p className="text-base sm:text-[1.05rem] text-dark-text/90 leading-relaxed">
                      {renderQuote(t.quote, t.hl)}
                    </p>
                  </blockquote>

                  <figcaption className="mt-5 pt-4 border-t border-white/10">
                    <div className="flex items-center gap-3">
                      <span
                        className={`w-9 h-9 rounded-full flex items-center justify-center font-mono text-xs font-bold text-black shrink-0 ${
                          t.tag === "jachacks"
                            ? "bg-gradient-to-br from-white to-gray-400"
                            : "bg-gradient-to-br from-primary-orange to-primary-yellow"
                        }`}
                        aria-hidden="true"
                      >
                        {initials(t.name)}
                      </span>
                      <p className="text-[0.95rem] font-semibold text-white">
                        {t.name}
                      </p>
                    </div>
                    <div className="mt-2.5 flex flex-wrap gap-1.5">
                      {t.chips.map((c) => (
                        <span
                          key={c.text}
                          className={`font-mono text-[0.68rem] leading-none rounded-full border px-2 py-1 ${chipTones[c.tone]}`}
                        >
                          {c.text}
                        </span>
                      ))}
                    </div>
                  </figcaption>
                </figure>
              )),
            )}
          </div>
        </div>

        <p className="mt-2 text-center font-mono text-[0.65rem] tracking-[0.25em] uppercase text-dark-text/40 sm:hidden">
          swipe to explore
        </p>
      </div>
    </section>
  );
};

export default TestimonialsSection;
