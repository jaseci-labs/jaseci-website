"""Landing testimonials band - ports
`layouts/components/landing/TestimonialsSection.js`.

A circular, auto-drifting carousel: three identical copies of the testimonial
list sit side by side and the scroll position silently wraps between them, so
the band never reaches an end.
"""

import from react { useEffect }
import from ...lib.dom { win }

obj Chip {
    has text: str = "",
        tone: str = "";
}

obj Testimonial {
    has quote: str = "",
        hl: list[str] = [],
        name: str = "",
        tag: str = "",
        chips: list[Chip] = [];
}

glob TESTIMONIALS: list[Testimonial] = [
    Testimonial(
        quote="Jaseci is a game changer for ProServe because it allows us to build full stack prototypes quickly and transition them to production with zero friction.",
        hl=["game changer", "zero friction"],
        name="Asim Salim",
        tag="featured",
        chips=[Chip(text="BCS Technologies", tone="org"), Chip(text="ProServe", tone="org")]
    ),
    Testimonial(
        quote="Jaseci's architecture gives our team a framework that feels intentional — it is not glue code on top of an LLM API. The emphasis on simplifying complex AI integration and prompt and model evaluation aligns with how enterprise teams actually think about building maintainable systems.",
        hl=["not glue code on top of an LLM API"],
        name="Pat Rinaldo",
        tag="featured",
        chips=[Chip(text="Ally Bank", tone="org"), Chip(text="Enterprise AI practitioner", tone="org")]
    ),
    Testimonial(
        quote="I see byLLM as a valuable innovation that could make LLM integration easier to develop, more maintainable and enterprise-ready.",
        hl=["more maintainable and enterprise-ready"],
        name="Brian Yang",
        tag="featured",
        chips=[Chip(text="Genesys", tone="org"), Chip(text="Enterprise AI practitioner", tone="org")]
    ),
    Testimonial(
        quote="Using Jaseci, our small engineering team has delivered features that would have required significantly more time and infrastructure with conventional tools. The byLLM component has enabled faster iteration, higher consistency, and measurable improvements in AI-driven user experience.",
        hl=["small engineering team has delivered features", "faster iteration, higher consistency"],
        name="Patrick McLaughlin",
        tag="featured",
        chips=[Chip(text="Founder of Tobu", tone="org")]
    ),
    Testimonial(
        quote="I particularly liked the unified full-stack experience, graph-based programming model, and the byLLM keyword for native AI integration. Together, they reduced boilerplate, accelerated development, and made it easier to focus on building intelligent applications rather than managing multiple tools and frameworks.",
        hl=["reduced boilerplate, accelerated development"],
        name="Sarath Kothapalli",
        tag="jachacks",
        chips=[Chip(text="1–2 yrs coding exp.", tone="exp"), Chip(text="Brand new to Jac", tone="new")]
    ),
    Testimonial(
        quote="The one language end to end development was great because it made it really easy to build using the language and change ideas with the AI understanding everything it was doing from the start. It was really seamless, the agent understood the language and architecture much easily and wrote better more streamlined code overall.",
        hl=["one language end to end", "really seamless"],
        name="Aditya Das",
        tag="jachacks",
        chips=[Chip(text="5–10 yrs coding exp.", tone="exp"), Chip(text="Brand new to Jac", tone="new")]
    ),
    Testimonial(
        quote="The unified programming paradigm and the graph-based model make structuring full-stack AI workflows cleaner and more intuitive.",
        hl=["cleaner and more intuitive"],
        name="Rafael Lopez",
        tag="jachacks",
        chips=[Chip(text="10+ yrs coding exp.", tone="exp"), Chip(text="Brand new to Jac", tone="new")]
    ),
    Testimonial(
        quote="I liked how I could do everything in one language and didn't have to move between frameworks.",
        hl=["everything in one language"],
        name="Vachan Bhogi",
        tag="jachacks",
        chips=[Chip(text="5–10 yrs coding exp.", tone="exp"), Chip(text="Py · JS/TS · Java · C/C++ · Rust", tone="stack")]
    ),
    Testimonial(
        quote="The graph-based part and the walkers allowed us to come up with a really unique solution for finding multi drug synergies which I found interesting.",
        hl=["a really unique solution"],
        name="Zorawar Brar",
        tag="jachacks",
        chips=[Chip(text="3–5 yrs coding exp.", tone="exp"), Chip(text="Brand new to Jac", tone="new")]
    ),
    Testimonial(
        quote="Graph-based programming also felt very natural for this problem. Since the system is inherently graph-structured, modeling it directly as nodes and edges made the logic easier to reason about.",
        hl=["easier to reason about"],
        name="Yanshengtian Dong",
        tag="jachacks",
        chips=[Chip(text="1–2 yrs coding exp.", tone="exp"), Chip(text="Brand new to Jac", tone="new")]
    ),
    Testimonial(
        quote="I just like the different approach of byLLM instead of prompt engineering. It also meant having a more clean and understandable codebase which is a huge plus.",
        hl=["byLLM instead of prompt engineering"],
        name="Yousef Al-Wahami",
        tag="jachacks",
        chips=[Chip(text="3–5 yrs coding exp.", tone="exp"), Chip(text="Brand new to Jac", tone="new")]
    ),
    Testimonial(
        quote="I really like the graph based memory and AI native design. Smooth interaction with other tech stack. Clean agent building.",
        hl=["graph based memory and AI native design"],
        name="Nitish Kumar Singh",
        tag="jachacks",
        chips=[
            Chip(text="3–5 yrs coding exp.", tone="exp"),
            Chip(text="Built with Jac before", tone="star"),
            Chip(text="10/10 would use again", tone="star")
        ]
    )
];

glob CHIP_TONES: dict[str, str] = {
    "exp": "border-amber-400/40 bg-amber-400/10 text-amber-300",
    "new": "border-emerald-400/40 bg-emerald-400/10 text-emerald-300",
    "star": "border-primary-orange/50 bg-primary-orange/10 text-primary-orange",
    "stack": "border-sky-400/40 bg-sky-400/10 text-sky-300",
    "org": "border-white/15 bg-white/[0.06] text-gray-300"
};

glob COPIES: int = 3;
glob AUTO_SPEED: float = 30.0;
glob RESUME_DELAY: float = 2500.0;

obj Segment {
    has text: str = "",
        highlight: bool = False;
}

"""Split a quote around its standout phrases.

The original built one `(a|b)` regex and split on it; splitting phrase by
phrase gives the same segmentation because the phrases never overlap.
"""
def split_quote(quote: str, hl: list[str]) -> list[Segment] {
    segments: list[Segment] = [Segment(text=quote, highlight=False)];
    for phrase in hl {
        if not phrase {
            continue;
        }
        merged: list[Segment] = [];
        for seg in segments {
            if seg.highlight {
                merged = merged + [seg];
                continue;
            }
            rest = seg.text;
            while True {
                index = rest.find(phrase);
                if index < 0 {
                    break;
                }
                if index > 0 {
                    merged = merged + [Segment(text=rest[:index], highlight=False)];
                }
                merged = merged + [Segment(text=phrase, highlight=True)];
                rest = rest[index + len(phrase):];
            }
            if rest {
                merged = merged + [Segment(text=rest, highlight=False)];
            }
        }
        segments = merged;
    }
    return segments;
}

def initials(name: str) -> str {
    letters = [word[0] for word in name.split(" ") if word];
    return "".join(letters[:2]);
}

"""Longer quotes get wider cards so every card wraps to a similar line count."""
def width_class(quote: str) -> str {
    length = len(quote);
    if length > 220 {
        return "w-[92vw] max-w-[600px] sm:w-[600px]";
    }
    if length > 120 {
        return "w-[90vw] max-w-[460px] sm:w-[460px]";
    }
    return "w-[85vw] max-w-[360px] sm:w-[360px]";
}

def:pub TestimonialsSection() -> JsxElement {
    has trackRef: Ref[HTMLDivElement] = Ref(),
        hoverRef: Ref[bool] = Ref(),
        holdUntilRef: Ref[float] = Ref(),
        carryRef: Ref[float] = Ref(),
        rafRef: Ref[int] = Ref(),
        lastRef: Ref[float] = Ref();

    """Distance from one copy of the list to the next."""
    def copy_width(el: any) -> float {
        if not el {
            return 0.0;
        }
        cols = el.querySelectorAll("[data-col]");
        if cols.length <= len(TESTIMONIALS) {
            return 0.0;
        }
        return (cols[len(TESTIMONIALS)].offsetLeft as float) - (cols[0].offsetLeft as float);
    }

    def hold() -> None {
        holdUntilRef.current = (win().performance.now() as float) + RESUME_DELAY;
    }

    # Start on the middle copy so there is always content on both sides.
    can with entry {
        start: any = trackRef.current;
        width = copy_width(start);
        if start and width {
            start.scrollLeft = width;
        }
    }

    # Slow continuous drift, paused while hovering, touching, or just after a
    # manual scroll. `entry`/`exit` compile to separate closures, so the rAF
    # handle is acquired and released inside one manual effect instead.
    useEffect(lambda {
        el: any = trackRef.current;
        reduced = win().matchMedia("(prefers-reduced-motion: reduce)").matches;
        if el and not reduced {
            tick = lambda (time: float) {
                rafRef.current = win().requestAnimationFrame(tick);
                previous = lastRef.current;
                if previous is None {
                    lastRef.current = time;
                    return None;
                }
                delta = min(time - (previous as float), 100.0);
                lastRef.current = time;
                if hoverRef.current or time < (holdUntilRef.current or 0.0) {
                    return None;
                }
                step = (AUTO_SPEED * delta) / 1000.0 + (carryRef.current or 0.0);
                target = (el.scrollLeft as float) + step;
                el.scrollLeft = target;
                # scrollLeft rounds to device pixels; carry the lost fraction
                carryRef.current = max(0.0, min(1.0, target - (el.scrollLeft as float)));
                return None;
            };
            rafRef.current = win().requestAnimationFrame(tick);
        }
        return lambda {
            if rafRef.current {
                win().cancelAnimationFrame(rafRef.current);
            }
        };
    }, []);

    # Drifting out of the middle copy jumps one copy-width back to the
    # identical position, so the band never ends.
    def handle_scroll(_e: Event) {
        el: any = trackRef.current;
        width = copy_width(el);
        if not el or not width {
            return;
        }
        if (el.scrollLeft as float) < width * 0.5 {
            el.scrollLeft = (el.scrollLeft as float) + width;
        } elif (el.scrollLeft as float) > width * 1.5 {
            el.scrollLeft = (el.scrollLeft as float) - width;
        }
    }

    def pause_auto(_e: Event) {
        hold();
    }

    def enter_track(_e: MouseEvent) {
        hoverRef.current = True;
    }

    def leave_track(_e: MouseEvent) {
        hoverRef.current = False;
    }

    def scroll_by_card(direction: int) -> None {
        el: any = trackRef.current;
        if not el {
            return;
        }
        hold();
        col = el.querySelector("[data-col]");
        step = ((col.offsetWidth as float) + 24.0) if col else 420.0;
        el.scrollBy({"left": direction * step, "behavior": "smooth"});
    }

    return <section
        id="testimonials"
        className="relative overflow-hidden bg-dark-bg py-20 sm:py-24 lg:py-28 border-t border-white/10 scroll-mt-24"
    >
        {#* Ambient glow *#}
        <div className="absolute inset-0 pointer-events-none">
            <div className="absolute top-0 left-[15%] w-[480px] h-[480px] bg-primary-orange/[0.06] rounded-full blur-3xl"></div>
            <div className="absolute bottom-0 right-[10%] w-72 h-72 bg-amber-600/[0.06] rounded-full blur-3xl"></div>
        </div>

        <div className="relative z-10">
            {#* Header *#}
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div className="flex flex-wrap items-end justify-between gap-6">
                    <div className="min-w-0">
                        <p className="font-mono text-xs tracking-[0.3em] uppercase text-primary-orange mb-5">
                            community
                        </p>
                        <h2 className="text-3xl sm:text-4xl lg:text-5xl font-semibold tracking-tight text-white text-balance leading-tight sm:leading-10 lg:leading-none">
                            Hear what builders and the
                            <span className="block bg-gradient-to-r from-primary-orange to-primary-yellow bg-clip-text text-transparent pb-1">
                                community think about Jac.
                            </span>
                        </h2>
                        <p className="mt-5 text-base sm:text-lg text-dark-text/90 leading-relaxed sm:leading-7 max-w-xl">
                            Enterprise teams shipping to production, startup founders
                            building on the stack, and first-time Jac developers at
                            JacHacks — in their own words.
                        </p>
                    </div>

                    {#* Arrows *#}
                    <div className="hidden sm:flex items-center gap-3 pb-1">
                        <button
                            type="button"
                            aria-label="Scroll testimonials left"
                            onClick={lambda (_e: MouseEvent) { scroll_by_card(-1); }}
                            className="w-10 h-10 rounded-full border border-white/15 text-white flex items-center justify-center transition-all duration-300 hover:border-primary-orange/50 hover:text-primary-orange"
                        >
                            <svg className="w-4 h-4" fill="none" stroke="currentColor" strokeWidth="2.5" viewBox="0 0 24 24">
                                <path strokeLinecap="round" strokeLinejoin="round" d="M15 19l-7-7 7-7" />
                            </svg>
                        </button>
                        <button
                            type="button"
                            aria-label="Scroll testimonials right"
                            onClick={lambda (_e: MouseEvent) { scroll_by_card(1); }}
                            className="w-10 h-10 rounded-full border border-white/15 text-white flex items-center justify-center transition-all duration-300 hover:border-primary-orange/50 hover:text-primary-orange"
                        >
                            <svg className="w-4 h-4" fill="none" stroke="currentColor" strokeWidth="2.5" viewBox="0 0 24 24">
                                <path strokeLinecap="round" strokeLinejoin="round" d="M9 5l7 7-7 7" />
                            </svg>
                        </button>
                    </div>
                </div>
            </div>

            {#* Circular swipeable band *#}
            <div className="relative mt-10 sm:mt-12">
                {#* Edge fades *#}
                <div className="absolute inset-y-0 left-0 w-8 sm:w-16 bg-gradient-to-r from-dark-bg to-transparent z-10 pointer-events-none"></div>
                <div className="absolute inset-y-0 right-0 w-8 sm:w-16 bg-gradient-to-l from-dark-bg to-transparent z-10 pointer-events-none"></div>

                <div
                    ref={trackRef}
                    onScroll={handle_scroll}
                    onMouseEnter={enter_track}
                    onMouseLeave={leave_track}
                    onWheel={pause_auto}
                    onPointerDown={pause_auto}
                    onTouchStart={pause_auto}
                    onTouchMove={pause_auto}
                    className="flex items-stretch gap-6 overflow-x-auto px-4 sm:px-8 pb-4 [scrollbar-width:none] [-ms-overflow-style:none] [&::-webkit-scrollbar]:hidden"
                >
                    {for copy in range(COPIES) {
                        for (idx, t) in enumerate(TESTIMONIALS) {
                            <figure
                                key={str(copy) + "-" + str(idx)}
                                data-col="true"
                                aria-hidden={copy != 0}
                                className={"shrink-0 " + width_class(t.quote) + " flex flex-col rounded-2xl border p-7 sm:p-8 transition-all duration-300 " + ("border-white/20 bg-white/[0.05] shadow-lg shadow-white/[0.04] hover:border-white/40 hover:bg-white/[0.08]" if t.tag == "jachacks" else "border-white/10 bg-white/[0.03] hover:border-primary-orange/40 hover:bg-white/[0.05]")}
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
                                    {if t.tag == "jachacks" {
                                        <span className="inline-flex items-center gap-1.5 font-mono text-[0.6rem] tracking-[0.15em] uppercase font-semibold rounded-full px-2.5 py-1 shrink-0 bg-gradient-to-r from-white via-gray-100 to-gray-300 text-black shadow-md shadow-white/20">
                                            <svg className="w-3 h-3" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                                <path d="M13 2L3 14h7l-1 8 10-12h-7l1-8z" />
                                            </svg>
                                            JacHacks Participant
                                        </span>
                                    } else {
                                        <span className="font-mono text-[0.6rem] tracking-[0.15em] uppercase font-semibold rounded-full px-2.5 py-1 shrink-0 bg-gradient-to-r from-primary-orange to-primary-yellow text-black shadow-md shadow-primary-orange/25">
                                            Featured
                                        </span>
                                    }}
                                </div>

                                <blockquote className="mt-4 flex-1 flex flex-col justify-center">
                                    <p className="text-base sm:text-[1.05rem] text-dark-text/90 leading-relaxed">
                                        {for (si, seg) in enumerate(split_quote(t.quote, t.hl)) {
                                            if seg.highlight {
                                                <mark
                                                    key={str(si)}
                                                    className="bg-primary-orange/15 text-white font-semibold rounded px-1 py-0.5 -mx-0.5 box-decoration-clone"
                                                >{seg.text}</mark>
                                            } else {
                                                <>{seg.text}</>
                                            }
                                        }}
                                    </p>
                                </blockquote>

                                <figcaption className="mt-5 pt-4 border-t border-white/10">
                                    <div className="flex items-center gap-3">
                                        <span
                                            className={"w-9 h-9 rounded-full flex items-center justify-center font-mono text-xs font-bold text-black shrink-0 " + ("bg-gradient-to-br from-white to-gray-400" if t.tag == "jachacks" else "bg-gradient-to-br from-primary-orange to-primary-yellow")}
                                            aria-hidden="true"
                                        >
                                            {initials(t.name)}
                                        </span>
                                        <p className="text-[0.95rem] font-semibold text-white">
                                            {t.name}
                                        </p>
                                    </div>
                                    <div className="mt-2.5 flex flex-wrap gap-1.5">
                                        {for c in t.chips {
                                            <span
                                                key={c.text}
                                                className={"font-mono text-[0.68rem] leading-none rounded-full border px-2 py-1 " + CHIP_TONES[c.tone]}
                                            >
                                                {c.text}
                                            </span>
                                        }}
                                    </div>
                                </figcaption>
                            </figure>
                        }
                    }}
                </div>
            </div>

            <p className="mt-2 text-center font-mono text-[0.65rem] tracking-[0.25em] uppercase text-dark-text/40 sm:hidden">
                swipe to explore
            </p>
        </div>
    </section>;
}
