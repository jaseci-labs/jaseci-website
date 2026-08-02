"use client";

const events = [
  {
    id: "EVENT://SF",
    mode: "IN-PERSON",
    place: "San Francisco, CA",
    note: "A one-day build sprint for the Bay Area's builders.",
  },
  {
    id: "EVENT://A2",
    mode: "IN-PERSON",
    place: "Ann Arbor, MI",
    note: "Where the series was born, on campus at Michigan.",
  },
  {
    id: "EVENT://ONLINE",
    mode: "REMOTE",
    place: "Anywhere on Earth",
    note: "Global online rounds. All you need is a laptop.",
  },
];

const JachacksSection = () => {
  return (
    <section
      id="jachacks"
      className="relative overflow-hidden bg-[#0a0a0a] border-y border-white/10 py-20 sm:py-24 lg:py-28 scroll-mt-24"
    >
      {/* Wireframe grid backdrop */}
      <div
        className="absolute inset-0 pointer-events-none opacity-60"
        style={{
          backgroundImage:
            "linear-gradient(rgba(255,255,255,0.05) 1px, transparent 1px), linear-gradient(90deg, rgba(255,255,255,0.05) 1px, transparent 1px)",
          backgroundSize: "40px 40px",
          maskImage:
            "radial-gradient(ellipse 80% 80% at 70% 50%, black 30%, transparent 100%)",
          WebkitMaskImage:
            "radial-gradient(ellipse 80% 80% at 70% 50%, black 30%, transparent 100%)",
        }}
      ></div>

      <div className="relative z-10 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="grid lg:grid-cols-2 gap-12 lg:gap-16 items-center">
          {/* Terminal visual, left on desktop for alternating rhythm */}
          <div className="order-last lg:order-first relative min-w-0">
            <div className="absolute -inset-4 bg-white/[0.04] rounded-3xl blur-2xl"></div>
            <div className="relative rounded-2xl border border-white/15 bg-black shadow-2xl shadow-black/60 overflow-hidden">
              <div className="flex items-center justify-between px-4 py-3 border-b border-white/10">
                <span className="font-mono text-xs tracking-[0.25em] text-gray-400">
                  SYS://JACHACKS
                </span>
                <span className="font-mono text-[0.65rem] text-gray-600">
                  v3.0
                </span>
              </div>
              <div className="p-5 sm:p-6 font-mono text-[0.8rem] sm:text-sm leading-relaxed">
                <p className="text-gray-500">
                  <span className="text-white">$</span> jachacks --list
                </p>
                <div className="mt-4 space-y-4">
                  {events.map((e) => (
                    <div
                      key={e.id}
                      className="group border border-white/10 rounded-lg p-4 transition-all duration-300 hover:border-white/40 hover:bg-white/[0.03]"
                    >
                      <div className="flex items-center justify-between gap-3">
                        <span className="text-white tracking-widest">
                          {e.id}
                        </span>
                        <span className="text-[0.65rem] tracking-[0.2em] text-gray-500 border border-white/15 rounded px-2 py-0.5 group-hover:text-gray-300 transition-colors">
                          {e.mode}
                        </span>
                      </div>
                      <p className="mt-1.5 text-gray-400">{e.place}</p>
                      <p className="mt-0.5 text-xs text-gray-600 group-hover:text-gray-500 transition-colors">
                        {e.note}
                      </p>
                    </div>
                  ))}
                </div>
                <p className="mt-5 text-gray-500">
                  <span className="text-white">&gt;</span> register at{" "}
                  <span className="text-white underline underline-offset-4 decoration-gray-600">
                    jachacks.org
                  </span>
                  <span className="inline-block w-2 h-4 ml-1 bg-gray-300 align-middle animate-blink"></span>
                </p>
              </div>
            </div>
          </div>

          {/* Copy */}
          <div className="min-w-0">
            <p className="font-mono text-xs tracking-[0.3em] uppercase text-gray-400 mb-5">
              02 / jachacks.org
            </p>
            <h2 className="text-3xl sm:text-4xl lg:text-5xl font-semibold tracking-tight text-white text-balance leading-tight">
              Where the Jac
              <br />
              community{" "}
              <span className="relative inline-block">
                ships.
                <span className="absolute -bottom-1 left-0 right-0 h-px bg-gradient-to-r from-white via-gray-500 to-transparent"></span>
              </span>
            </h2>
            <p className="mt-5 text-base sm:text-lg text-gray-400 leading-relaxed max-w-xl">
              JacHacks is the hackathon series powering the future of AI
              programming. Form a team, learn the stack in a morning, and demo
              a working AI-native app by night. In person and online, from San
              Francisco to Ann Arbor to wherever you are.
            </p>

            <ul className="mt-8 space-y-3 max-w-xl">
              {[
                "Build with Jac and the full Jaseci stack",
                "Mentors, workshops, and starter kits included",
                "Prizes, swag, and a fast track into the community",
              ].map((line) => (
                <li key={line} className="flex items-start gap-3 text-sm text-gray-300">
                  <span className="font-mono text-gray-500 mt-px select-none">
                    &gt;
                  </span>
                  {line}
                </li>
              ))}
            </ul>

            <div className="mt-9">
              <a
                href="https://jachacks.org"
                className="group inline-flex items-center gap-2 rounded-lg px-6 py-3 text-sm font-semibold text-black bg-white shadow-md shadow-white/10 transition-all duration-300 hover:-translate-y-0.5 hover:shadow-lg hover:shadow-white/25"
              >
                Enter jachacks.org
                <svg
                  className="w-4 h-4 transition-transform duration-300 group-hover:translate-x-1"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2.5"
                  viewBox="0 0 24 24"
                >
                  <path strokeLinecap="round" strokeLinejoin="round" d="M17 8l4 4m0 0l-4 4m4-4H3" />
                </svg>
              </a>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};

export default JachacksSection;
