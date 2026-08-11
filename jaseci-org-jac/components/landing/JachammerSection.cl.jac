"""Landing section 03 - ports `layouts/components/landing/JachammerSection.js`."""

obj Feature {
    has title: str = "",
        body: str = "";
}

obj HostedProject {
    has name: str = "",
        status: str = "",
        dot: str = "",
        url: str = "",
        version: str = "",
        scale: str = "";
}

glob FEATURES: list[Feature] = [
    Feature(
        title="Deploy with a click",
        body="Go from working code to a live, hosted app in seconds. Every project gets its own shareable URL."
    ),
    Feature(
        title="Scale built in",
        body="Hosted on the Jaseci stack, your app grows from weekend demo to production traffic without a rewrite."
    ),
    Feature(
        title="Build in your browser",
        body="A full web IDE is included. Edit, live-preview, and iterate on your projects without installing a thing."
    ),
    Feature(
        title="Every version kept",
        body="Project history lives with the project. Roll back, branch, and compare releases without leaving the page."
    )
];

glob PROJECTS: list[HostedProject] = [
    HostedProject(
        name="tweetsphere",
        status="LIVE",
        dot="bg-emerald-400",
        url="tweetsphere.jachammer.app",
        version="v23",
        scale="3 replicas / auto"
    ),
    HostedProject(
        name="study-buddy",
        status="LIVE",
        dot="bg-emerald-400",
        url="study-buddy.jachammer.app",
        version="v8",
        scale="1 replica"
    ),
    HostedProject(
        name="feed-ranker",
        status="DEPLOYING",
        dot="bg-amber-400 animate-pulse",
        url="feed-ranker.jachammer.app",
        version="v2",
        scale="rolling out"
    )
];

def:pub JachammerSection() -> JsxElement {
    return <section
        id="jachammer"
        className="relative overflow-hidden bg-dark-bg py-20 sm:py-24 lg:py-28 scroll-mt-24"
    >
        {#* Copper ambient glow *#}
        <div className="absolute inset-0 pointer-events-none">
            <div className="absolute top-1/3 -right-40 w-[520px] h-[520px] bg-amber-600/[0.08] rounded-full blur-3xl"></div>
            <div className="absolute bottom-0 left-[5%] w-72 h-72 bg-orange-800/[0.07] rounded-full blur-3xl"></div>
        </div>

        <div className="relative z-10 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div className="grid lg:grid-cols-2 gap-12 lg:gap-16 items-center">
                {#* Copy *#}
                <div className="min-w-0">
                    <p className="font-mono text-xs tracking-[0.3em] uppercase text-amber-500 mb-5">
                        03 / jachammer.ai
                    </p>
                    <h2 className="text-3xl sm:text-4xl lg:text-5xl font-semibold tracking-tight text-white text-balance leading-tight">
                        A home for your
                        <span className="block bg-gradient-to-r from-amber-400 to-orange-600 bg-clip-text text-transparent pb-1">
                            Jac creations.
                        </span>
                    </h2>
                    <p className="mt-5 text-base sm:text-lg text-dark-text/90 leading-relaxed max-w-xl">
                        JacHammer is where your Jac projects live. Host and deploy your
                        creations at scale, share them with a link, and take an idea
                        from prototype to production without ever moving it.
                    </p>

                    <div className="mt-8 grid sm:grid-cols-2 gap-5">
                        {for feature in FEATURES {
                            <div key={feature.title}>
                                <div className="flex items-center gap-2.5">
                                    <span className="w-1.5 h-1.5 rounded-full bg-gradient-to-r from-amber-400 to-orange-600 shrink-0"></span>
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

                    <div className="mt-9">
                        <a
                            href="https://jachammer.ai"
                            className="group inline-flex items-center gap-2 rounded-lg px-6 py-3 text-sm font-semibold text-white bg-gradient-to-r from-amber-500 to-orange-700 shadow-md shadow-amber-600/25 transition-all duration-300 hover:-translate-y-0.5 hover:shadow-lg hover:shadow-amber-600/40"
                        >
                            Move in at jachammer.ai
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

                {#* Projects dashboard mockup *#}
                <div className="relative min-w-0">
                    <div className="absolute -inset-4 bg-gradient-to-br from-amber-500/10 to-orange-800/10 rounded-3xl blur-2xl opacity-70"></div>
                    <div className="relative rounded-2xl border border-white/10 bg-[#141414] shadow-2xl shadow-black/50 overflow-hidden">
                        {#* Browser chrome *#}
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
                                        jachammer.ai/projects
                                    </span>
                                </div>
                            </div>
                        </div>

                        {#* Dashboard body *#}
                        <div className="p-4 sm:p-5 font-mono text-[0.7rem]">
                            <div className="flex items-center justify-between mb-3">
                                <p className="text-gray-500 uppercase tracking-[0.25em] text-[0.6rem]">
                                    my projects
                                </p>
                                <span className="inline-flex items-center gap-1 rounded border border-amber-500/40 text-amber-400 px-2 py-0.5 text-[0.6rem] tracking-widest uppercase">
                                    + new
                                </span>
                            </div>

                            <div className="space-y-2.5">
                                {for project in PROJECTS {
                                    <div
                                        key={project.name}
                                        className="group rounded-lg border border-white/10 bg-black/25 p-3.5 transition-all duration-300 hover:border-amber-500/40 hover:bg-black/40"
                                    >
                                        <div className="flex items-center justify-between gap-3">
                                            <div className="flex items-center gap-2 min-w-0">
                                                <span className={"w-1.5 h-1.5 rounded-full shrink-0 " + project.dot}></span>
                                                <span className="text-white truncate">{project.name}</span>
                                                <span className="text-gray-600">{project.version}</span>
                                            </div>
                                            <span className="text-[0.6rem] tracking-[0.2em] text-gray-500 border border-white/15 rounded px-1.5 py-0.5 shrink-0">
                                                {project.status}
                                            </span>
                                        </div>
                                        <div className="mt-2 flex items-center justify-between gap-3 text-[0.65rem]">
                                            <span className="text-amber-400/80 truncate">
                                                {project.url}
                                            </span>
                                            <span className="text-gray-600 shrink-0 hidden sm:inline">
                                                {project.scale}
                                            </span>
                                        </div>
                                        <div className="mt-2.5 flex items-center gap-3 text-[0.6rem] uppercase tracking-widest text-gray-600">
                                            <span className="group-hover:text-gray-400 transition-colors">
                                                open in ide
                                            </span>
                                            <span className="text-gray-700">·</span>
                                            <span className="group-hover:text-gray-400 transition-colors">
                                                versions
                                            </span>
                                            <span className="text-gray-700">·</span>
                                            <span className="group-hover:text-amber-400 transition-colors">
                                                deploy
                                            </span>
                                        </div>
                                    </div>
                                }}
                            </div>

                            <p className="mt-4 flex items-center gap-2 text-[0.65rem] text-gray-600">
                                <span className="w-1.5 h-1.5 rounded-full bg-emerald-400"></span>
                                all systems live · scaling on demand
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>;
}
