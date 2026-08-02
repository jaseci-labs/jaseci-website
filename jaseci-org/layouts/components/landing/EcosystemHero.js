"use client";

const pillars = [
  {
    number: "01",
    name: "Jac",
    kind: "The Programming Language",
    tagline: "One language, one compiler, the whole stack. No glue.",
    domain: "jaclang.org",
    anchor: "#jaclang",
    accent: "text-primary-orange",
    ring: "hover:border-primary-orange/60 hover:shadow-[0_0_40px_-12px_rgba(255,107,53,0.45)]",
    bar: "from-primary-orange to-primary-yellow",
  },
  {
    number: "02",
    name: "JacHacks",
    kind: "The Hackathon Series",
    tagline: "Powering the future of AI programming, in person and online.",
    domain: "jachacks.org",
    anchor: "#jachacks",
    accent: "text-white",
    ring: "hover:border-white/60 hover:shadow-[0_0_40px_-12px_rgba(255,255,255,0.35)]",
    bar: "from-white to-gray-400",
  },
  {
    number: "03",
    name: "JacHammer",
    kind: "The Browser IDE",
    tagline: "Build Jac apps in your browser. No install needed.",
    domain: "jachammer.ai",
    anchor: "#jachammer",
    accent: "text-amber-500",
    ring: "hover:border-amber-500/60 hover:shadow-[0_0_40px_-12px_rgba(245,158,11,0.45)]",
    bar: "from-amber-500 to-orange-700",
  },
];

const EcosystemHero = () => {
  return (
    <section className="relative overflow-hidden bg-dark-bg pt-[150px] pb-16 sm:pb-20 lg:pt-[170px] lg:pb-24">
      {/* Faint grid backdrop */}
      <div
        className="absolute inset-0 pointer-events-none"
        style={{
          backgroundImage:
            "linear-gradient(rgba(255,255,255,0.035) 1px, transparent 1px), linear-gradient(90deg, rgba(255,255,255,0.035) 1px, transparent 1px)",
          backgroundSize: "56px 56px",
          maskImage:
            "radial-gradient(ellipse 90% 70% at 50% 0%, black 40%, transparent 100%)",
          WebkitMaskImage:
            "radial-gradient(ellipse 90% 70% at 50% 0%, black 40%, transparent 100%)",
        }}
      ></div>

      {/* Ambient glows */}
      <div className="absolute inset-0 pointer-events-none opacity-30">
        <div className="absolute -top-24 left-1/2 -translate-x-1/2 w-[700px] h-[380px] bg-gradient-to-br from-primary-orange/25 via-primary-yellow/10 to-transparent rounded-full blur-3xl"></div>
        <div className="absolute bottom-0 right-[10%] w-72 h-72 bg-amber-600/10 rounded-full blur-3xl"></div>
      </div>

      <div className="relative z-10 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center max-w-4xl mx-auto">
          <p
            className="font-mono text-[0.7rem] sm:text-xs tracking-[0.35em] uppercase text-dark-text/60 mb-6"
            style={{ animation: "heroFadeUp 0.6s ease-out 0s both" }}
          >
            SYS://JASECI
          </p>

          <h1
            className="text-4xl sm:text-5xl lg:text-6xl xl:text-7xl font-semibold tracking-tight text-white text-balance leading-[1.05]"
            style={{ animation: "heroFadeUp 0.6s ease-out 0.1s both" }}
          >
            One ecosystem for
            <span className="block bg-gradient-to-r from-primary-orange via-primary-yellow to-primary-orange bg-clip-text text-transparent pb-2">
              AI-native software.
            </span>
          </h1>

          <p
            className="mt-6 text-base sm:text-lg lg:text-xl text-dark-text/90 leading-relaxed max-w-2xl mx-auto"
            style={{ animation: "heroFadeUp 0.6s ease-out 0.2s both" }}
          >
            Jaseci is the home of Jac: a full-stack programming language with AI
            built in, a hackathon series where its community ships, and a
            browser IDE that turns ideas into running apps.
          </p>
        </div>

        {/* Pillar cards */}
        <div
          className="mt-14 sm:mt-16 grid gap-4 sm:gap-5 md:grid-cols-3 max-w-5xl mx-auto"
          style={{ animation: "heroFadeUp 0.6s ease-out 0.35s both" }}
        >
          {pillars.map((p) => (
            <a
              key={p.name}
              href={p.anchor}
              className={`group relative flex flex-col rounded-2xl border border-white/10 bg-white/[0.03] backdrop-blur-sm p-6 sm:p-7 transition-all duration-300 hover:-translate-y-1 ${p.ring}`}
            >
              <div className="flex items-baseline justify-between">
                <span className={`font-mono text-xs tracking-[0.25em] ${p.accent}`}>
                  {p.number}
                </span>
                <span className="font-mono text-[0.65rem] tracking-widest uppercase text-dark-text/50 group-hover:text-dark-text/80 transition-colors">
                  {p.kind}
                </span>
              </div>

              <h2 className="mt-4 text-2xl font-semibold text-white tracking-tight">
                {p.name}
              </h2>
              <p className="mt-2 text-sm text-dark-text/80 leading-relaxed flex-1">
                {p.tagline}
              </p>

              <div className="mt-6 flex items-center justify-between">
                <span className="font-mono text-xs text-dark-text/60 group-hover:text-white transition-colors">
                  {p.domain}
                </span>
                <svg
                  className={`w-4 h-4 ${p.accent} transition-transform duration-300 group-hover:translate-y-1`}
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2"
                  viewBox="0 0 24 24"
                >
                  <path strokeLinecap="round" strokeLinejoin="round" d="M19 14l-7 7m0 0l-7-7m7 7V3" />
                </svg>
              </div>

              <div
                className={`absolute bottom-0 left-6 right-6 h-px bg-gradient-to-r ${p.bar} opacity-0 group-hover:opacity-70 transition-opacity duration-300`}
              ></div>
            </a>
          ))}
        </div>
      </div>

      <style jsx global>{`
        html {
          scroll-behavior: smooth;
        }
        @keyframes heroFadeUp {
          from {
            opacity: 0;
            transform: translateY(24px);
          }
          to {
            opacity: 1;
            transform: translateY(0);
          }
        }
      `}</style>
    </section>
  );
};

export default EcosystemHero;
