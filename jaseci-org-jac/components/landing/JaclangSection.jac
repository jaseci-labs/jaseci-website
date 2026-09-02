"""Landing section 01 - ports `layouts/components/landing/JaclangSection.js`."""

obj Feature {
    has title: str = "",
        body: str = "";
}

glob FEATURES: list[Feature] = [
    Feature(
        title="AI as a language feature",
        body="Hand any function to an LLM with a single keyword: by llm. No prompt plumbing, no SDK ceremony."
    ),
    Feature(
        title="Object-Spatial Programming",
        body="Nodes, edges, and walkers make graphs and the computation that moves over them first-class citizens."
    ),
    Feature(
        title="The whole stack, one program",
        body="Backend, frontend, persistence, and APIs come out of one codebase. The compiler does the gluing."
    ),
    Feature(
        title="Laptop to cloud, zero rewrites",
        body="The same program runs as a script, a service, or a Kubernetes deployment. Scale is a flag, not a refactor."
    )
];

glob KW: str = "text-primary-orange";
glob TYP: str = "text-sky-300";
glob STR: str = "text-emerald-300";
glob FN: str = "text-primary-yellow";
glob DIM: str = "text-gray-500";

def:pub JaclangSection() -> JsxElement {
    return <section
        id="jaclang"
        className="relative overflow-hidden bg-dark-bg py-20 sm:py-24 lg:py-28 scroll-mt-24"
    >
        {#* Orange ambient glow *#}
        <div className="absolute inset-0 pointer-events-none">
            <div className="absolute top-1/4 -left-40 w-[500px] h-[500px] bg-primary-orange/[0.07] rounded-full blur-3xl"></div>
            <div className="absolute bottom-0 right-0 w-80 h-80 bg-primary-yellow/[0.05] rounded-full blur-3xl"></div>
        </div>

        <div className="relative z-10 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div className="grid lg:grid-cols-2 gap-12 lg:gap-16 items-center">
                {#* Copy *#}
                <div className="min-w-0">
                    <p className="font-mono text-xs tracking-[0.3em] uppercase text-primary-orange mb-5">
                        01 / jaclang.org
                    </p>
                    <h2 className="text-3xl sm:text-4xl lg:text-5xl font-semibold tracking-tight text-white text-balance leading-tight sm:leading-10 lg:leading-none">
                        One language.
                        <br />
                        One compiler.
                        <span className="block bg-gradient-to-r from-primary-orange to-primary-yellow bg-clip-text text-transparent pb-1">
                            The whole stack.
                        </span>
                    </h2>
                    <p className="mt-5 text-base sm:text-lg text-dark-text/90 leading-relaxed sm:leading-7 max-w-xl">
                        Jac builds AI, graphs, persistence, APIs, UIs, and cloud
                        deployment directly into the language, as a native superset of
                        Python with the PyPI and npm ecosystems at your fingertips.
                    </p>

                    <div className="mt-8 grid sm:grid-cols-2 gap-5">
                        {for feature in FEATURES {
                            <div key={feature.title} className="group">
                                <div className="flex items-center gap-2.5">
                                    <span className="w-1.5 h-1.5 rounded-full bg-gradient-to-r from-primary-orange to-primary-yellow shrink-0"></span>
                                    <h3 className="text-sm font-semibold text-white tracking-wide">
                                        {feature.title}
                                    </h3>
                                </div>
                                <p className="mt-1.5 pl-4 text-sm text-dark-text/70 leading-relaxed">
                                    {feature.body}
                                </p>
                            </div>
                        }}
                    </div>

                    <div className="mt-9 flex flex-wrap items-center gap-4">
                        <a
                            href="https://jaclang.org"
                            className="group inline-flex items-center gap-2 rounded-lg px-6 py-3 text-sm font-semibold text-white bg-gradient-to-r from-primary-orange to-primary-yellow shadow-md shadow-primary-orange/25 transition-all duration-300 hover:-translate-y-0.5 hover:shadow-lg hover:shadow-primary-orange/40"
                        >
                            Explore jaclang.org
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
                        <a
                            href="https://dl.acm.org/doi/10.1145/3763092"
                            target="_blank"
                            rel="noopener noreferrer"
                            className="text-sm text-dark-text/60 hover:text-primary-orange transition-colors underline decoration-dotted underline-offset-4"
                        >
                            Peer-reviewed at OOPSLA 2025
                        </a>
                    </div>
                </div>

                {#* Code window *#}
                <div className="relative min-w-0">
                    <div className="absolute -inset-4 bg-gradient-to-br from-primary-orange/10 to-primary-yellow/5 rounded-3xl blur-2xl opacity-60"></div>
                    <div className="relative rounded-2xl border border-white/10 bg-[#141414] shadow-2xl shadow-black/50 overflow-hidden">
                        <div className="flex items-center gap-2 px-4 py-3 border-b border-white/10 bg-white/[0.03]">
                            <span className="w-3 h-3 rounded-full bg-[#ff5f57]"></span>
                            <span className="w-3 h-3 rounded-full bg-[#febc2e]"></span>
                            <span className="w-3 h-3 rounded-full bg-[#28c840]"></span>
                            <span className="ml-3 font-mono text-xs text-gray-500">
                                feed.jac
                            </span>
                        </div>
                        <pre className="p-5 sm:p-6 text-[0.8rem] sm:text-sm leading-relaxed sm:leading-5 font-mono text-gray-200 overflow-x-auto">
                            <code>
                                <span className={KW}>import from</span>{" mtllm { "}<span className={TYP}>Model</span>{" }"}{"\n"}
                                <span className={KW}>glob</span>{" llm = "}<span className={TYP}>Model</span>{"(model_name="}<span className={STR}>"gpt-5"</span>{");"}{"\n"}
                                {"\n"}
                                <span className={STR + " italic"}>"Rank posts by what this user will love."</span>{"\n"}
                                <span className={KW}>def</span>{" "}<span className={FN}>rank</span>{"(posts: "}<span className={TYP}>list</span>{"["}<span className={TYP}>Post</span>{"]) "}<span className={DIM}>-&gt;</span>{" "}<span className={TYP}>list</span>{"["}<span className={TYP}>Post</span>{"] "}<span className={KW}>by</span>{" "}<span className={FN}>llm</span>{"();"}{"\n"}
                                {"\n"}
                                <span className={KW}>node</span>{" "}<span className={TYP}>Post</span>{" { "}<span className={KW}>has</span>{" text: "}<span className={TYP}>str</span>{"; }"}{"\n"}
                                {"\n"}
                                <span className={KW}>walker</span>{" "}<span className={TYP}>feed</span>{" {"}{"\n"}
                                {"    "}<span className={KW}>can</span>{" "}<span className={FN}>serve</span>{" "}<span className={KW}>with</span>{" "}<span className={DIM}>`root</span>{" "}<span className={KW}>entry</span>{" {"}{"\n"}
                                {"        "}<span className={KW}>report</span>{" "}<span className={FN}>rank</span>{"(["}<span className={DIM}>--&gt;</span>{"("}<span className={DIM}>`?</span><span className={TYP}>Post</span>{")]);"}{"\n"}
                                {"    "}{"}"}{"\n"}
                                {"}"}{"\n"}
                            </code>
                        </pre>
                        <div className="px-5 sm:px-6 pb-5 pt-1 border-t border-white/5">
                            <p className="font-mono text-xs text-gray-500">
                                <span className="text-primary-orange">$</span>{" jac start feed.jac  "}
                                <span className="text-gray-600">
                                    # API, persistence, and AI. Served.
                                </span>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>;
}
