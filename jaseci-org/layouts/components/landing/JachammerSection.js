"use client";

const features = [
  {
    title: "Zero setup",
    body: "Open a tab and you have a full Jac workspace. Nothing to install, nothing to configure.",
  },
  {
    title: "Live preview",
    body: "Watch your app render as you type. Frontend and backend, running side by side with your code.",
  },
  {
    title: "Every version kept",
    body: "Your project history travels with the workspace. Roll back, branch, and compare without leaving the browser.",
  },
  {
    title: "From prompt to app",
    body: "Describe what you want and let the hammer swing. Then refine the generated Jac by hand.",
  },
];

const JachammerSection = () => {
  return (
    <section
      id="jachammer"
      className="relative overflow-hidden bg-dark-bg py-20 sm:py-24 lg:py-28 scroll-mt-24"
    >
      {/* Copper ambient glow */}
      <div className="absolute inset-0 pointer-events-none">
        <div className="absolute top-1/3 -right-40 w-[520px] h-[520px] bg-amber-600/[0.08] rounded-full blur-3xl"></div>
        <div className="absolute bottom-0 left-[5%] w-72 h-72 bg-orange-800/[0.07] rounded-full blur-3xl"></div>
      </div>

      <div className="relative z-10 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="grid lg:grid-cols-2 gap-12 lg:gap-16 items-center">
          {/* Copy */}
          <div className="min-w-0">
            <p className="font-mono text-xs tracking-[0.3em] uppercase text-amber-500 mb-5">
              03 / jachammer.ai
            </p>
            <h2 className="text-3xl sm:text-4xl lg:text-5xl font-semibold tracking-tight text-white text-balance leading-tight">
              Idea in.
              <span className="block bg-gradient-to-r from-amber-400 to-orange-600 bg-clip-text text-transparent pb-1">
                Running app out.
              </span>
            </h2>
            <p className="mt-5 text-base sm:text-lg text-dark-text/90 leading-relaxed max-w-xl">
              JacHammer is the web-based IDE for the Jac language. Build,
              preview, and version your projects entirely in the browser, then
              share a running app in minutes.
            </p>

            <div className="mt-8 grid sm:grid-cols-2 gap-5">
              {features.map((f) => (
                <div key={f.title}>
                  <div className="flex items-center gap-2.5">
                    <span className="w-1.5 h-1.5 rounded-full bg-gradient-to-r from-amber-400 to-orange-600 shrink-0"></span>
                    <h3 className="text-sm font-semibold text-white tracking-wide">
                      {f.title}
                    </h3>
                  </div>
                  <p className="mt-1.5 pl-4 text-sm text-dark-text/70 leading-relaxed">
                    {f.body}
                  </p>
                </div>
              ))}
            </div>

            <div className="mt-9">
              <a
                href="https://jachammer.ai"
                className="group inline-flex items-center gap-2 rounded-lg px-6 py-3 text-sm font-semibold text-white bg-gradient-to-r from-amber-500 to-orange-700 shadow-md shadow-amber-600/25 transition-all duration-300 hover:-translate-y-0.5 hover:shadow-lg hover:shadow-amber-600/40"
              >
                Launch jachammer.ai
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

          {/* Browser IDE mockup */}
          <div className="relative min-w-0">
            <div className="absolute -inset-4 bg-gradient-to-br from-amber-500/10 to-orange-800/10 rounded-3xl blur-2xl opacity-70"></div>
            <div className="relative rounded-2xl border border-white/10 bg-[#141414] shadow-2xl shadow-black/50 overflow-hidden">
              {/* Browser chrome */}
              <div className="flex items-center gap-2 px-4 py-3 border-b border-white/10 bg-white/[0.03]">
                <span className="w-3 h-3 rounded-full bg-[#ff5f57]"></span>
                <span className="w-3 h-3 rounded-full bg-[#febc2e]"></span>
                <span className="w-3 h-3 rounded-full bg-[#28c840]"></span>
                <div className="ml-3 flex-1 max-w-[240px]">
                  <div className="flex items-center gap-1.5 rounded-md bg-black/40 border border-white/10 px-2.5 py-1">
                    <svg className="w-3 h-3 text-amber-500" fill="none" stroke="currentColor" strokeWidth="2" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                    </svg>
                    <span className="font-mono text-[0.65rem] text-gray-400">
                      jachammer.ai/studio
                    </span>
                  </div>
                </div>
              </div>

              {/* IDE body */}
              <div className="grid grid-cols-12 min-h-[300px] text-[0.7rem] font-mono">
                {/* File tree */}
                <div className="col-span-3 border-r border-white/10 p-3 space-y-1.5 bg-black/20">
                  <p className="text-gray-600 uppercase tracking-widest text-[0.6rem] mb-2">
                    myapp
                  </p>
                  <p className="text-amber-400 bg-amber-500/10 rounded px-1.5 py-0.5">
                    main.jac
                  </p>
                  <p className="text-gray-500 px-1.5 py-0.5">ui.jac</p>
                  <p className="text-gray-500 px-1.5 py-0.5">agents.jac</p>
                  <p className="text-gray-600 px-1.5 py-0.5">jac.toml</p>
                </div>

                {/* Editor */}
                <div className="col-span-5 border-r border-white/10 p-3 leading-relaxed text-gray-300 overflow-hidden">
                  <p>
                    <span className="text-amber-400">walker</span>{" "}
                    <span className="text-sky-300">todo</span> {"{"}
                  </p>
                  <p className="pl-3">
                    <span className="text-amber-400">can</span> add{" "}
                    <span className="text-amber-400">with</span>{" "}
                    <span className="text-gray-500">`root</span>{" "}
                    <span className="text-amber-400">entry</span>;
                  </p>
                  <p>{"}"}</p>
                  <p className="mt-2">
                    <span className="text-amber-400">def</span>{" "}
                    <span className="text-yellow-200">app</span>() {"{"}
                  </p>
                  <p className="pl-3 text-gray-400">
                    &lt;<span className="text-sky-300">Board</span>{" "}
                    items={"{"}...{"}"} /&gt;
                  </p>
                  <p>{"}"}</p>
                  <p className="mt-3 text-gray-600"># saved · v14</p>
                </div>

                {/* Live preview */}
                <div className="col-span-4 p-3 bg-gradient-to-br from-black/30 to-transparent">
                  <p className="text-gray-600 uppercase tracking-widest text-[0.6rem] mb-2">
                    live preview
                  </p>
                  <div className="rounded-lg border border-white/10 bg-[#0d0d0d] p-2.5 space-y-2">
                    <div className="h-2 w-2/3 rounded bg-gradient-to-r from-amber-500/70 to-orange-600/70"></div>
                    <div className="h-1.5 w-full rounded bg-white/10"></div>
                    <div className="h-1.5 w-5/6 rounded bg-white/10"></div>
                    <div className="mt-2 flex gap-1.5">
                      <div className="h-4 w-12 rounded bg-amber-500/80"></div>
                      <div className="h-4 w-12 rounded border border-white/15"></div>
                    </div>
                    <div className="mt-2 grid grid-cols-2 gap-1.5">
                      <div className="h-8 rounded bg-white/[0.06] border border-white/10"></div>
                      <div className="h-8 rounded bg-white/[0.06] border border-white/10"></div>
                    </div>
                  </div>
                  <p className="mt-2 flex items-center gap-1.5 text-[0.6rem] text-gray-500">
                    <span className="w-1.5 h-1.5 rounded-full bg-emerald-400 animate-pulse"></span>
                    running
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};

export default JachammerSection;
