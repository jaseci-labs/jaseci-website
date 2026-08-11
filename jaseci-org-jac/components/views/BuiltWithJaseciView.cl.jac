"""`/built-with-jaseci` - ports `app/built-with-jaseci/page.js`."""

import from react { useEffect }
import from "react-icons/fa" {
    FaArrowRight, FaExternalLinkAlt, FaGithub, FaGlobe, FaPlay, FaTimes, FaTrophy
}
import from ..SeoMeta { SeoMeta }
import from ...lib.dom { body, win }

obj Company {
    has name: str = "",
        logo: str = "",
        href: str = "",
        blurb: str = "",
        case_study_url: str = "";
}

obj Project {
    has name: str = "",
        description: str = "",
        thumbnail: str = "",
        video_url: str = "",
        live_url: str = "",
        github_url: str = "",
        award: str = "",
        accent: str = "from-primary-orange via-rose-400 to-primary-yellow";
}

glob COMPANIES: list[Company] = [
    Company(
        name="Ally",
        logo="/assets/images/assets/partners/Ally_Financial.png",
        href="https://www.ally.com/",
        blurb="Digital banking & financial services"
    ),
    Company(
        name="Tobu",
        logo="/assets/images/assets/partners/tobu.png",
        href="https://tobu.life/",
        blurb="AI-powered creative tools",
        case_study_url="https://blogs.jaseci.org/blog/posts/tobu-memory-graph-case-study"
    ),
    Company(
        name="Pocketnest",
        logo="/assets/images/assets/partners/pocketnest.png",
        href="https://pocketnest.com/",
        blurb="Personal finance platform"
    )
];

glob PROJECTS: list[Project] = [
    Project(
        name="Skooch",
        description="An AI-powered dynamic scheduler that optimizes your schedule to your capabilities. Automatically plans tasks, homework, social events, and more, catered to your energy level and work style preferences.",
        video_url="https://dsmbbmpkcxdbqlhrmuva.supabase.co/storage/v1/object/public/assets/skooch_landing_demo.mp4",
        live_url="https://www.skooch.ai/"
    ),
    Project(
        name="GraphClaw",
        description="A multi-agent AI platform where memory lives in a property graph, agents are graph walkers, and skills can be installed from the internet at runtime. Specialist agents collaborate across Telegram, Discord, Slack, and email.",
        video_url="https://www.youtube.com/embed/6xdpZwHekME",
        live_url="https://graphclaw.vercel.app",
        github_url="https://github.com/zero-abd/graphclaw"
    ),
    Project(
        name="EdgeCast",
        description="A clean MVP that helps users discover active Kalshi prediction markets, inspect price action, and ask an AI analyst for a YES/NO lean with confidence score and rationale.",
        video_url="https://www.youtube.com/embed/TyPN8ViaIOI?start=1",
        live_url="https://www.edgecastapp.com/"
    ),
    Project(
        name="GhostWatch",
        description="Autonomous code defense with graph-native clarity. GhostWatch builds a living graph of your codebase to flag risky dependencies and pull requests, runs sandboxed tests for evidence, and can ship auto-fix PRs and Discord alerts to cut alert fatigue.",
        video_url="https://www.youtube.com/embed/ZN0UVnNUpRs?start=3",
        github_url="https://github.com/ayushmk7/GhostWatch"
    ),
    Project(
        name="MaizeMind",
        description="A visual reasoning tool that creates a graph of an argument complete with claims, evidence, and reasoning. Build off different nodes and connect information to explore complex ideas visually.",
        video_url="https://drive.google.com/file/d/1pM3xXK0HfE4KdOHwB7ozztQUWIxW6NC-/preview",
        live_url="https://www.maizemind.com/",
        github_url="https://github.com/kelmegan/maizemind-juncture"
    ),
    Project(
        name="AI4Careers",
        description="An AI-powered assistant that helps students navigate job applications and career fairs by optimizing resumes, matching roles to individual profiles, and generating tailored recruiter talking points in real time.",
        video_url="https://drive.google.com/file/d/1Pom22VWcbC5nhvKJJZkEfNFAfF76nR6z/preview",
        github_url="https://github.com/YuzhangMei/AI4Careers"
    ),
    Project(
        name="ChainViz",
        description="An interactive 3D supply-chain risk analyzer that maps npm's most dangerous dependencies as a force-directed graph. Autonomous Jac agents investigate any package's blast radius in real time, combining risk heatmaps, attack replays, and vulnerability scanning.",
        video_url="https://www.youtube.com/embed/R1tjGuE_HS8",
        live_url="https://supply-chain-frontend-nu.vercel.app/",
        github_url="https://github.com/drPod/chainviz"
    ),
    Project(
        name="Hijac",
        description="A mobile-first AI agent that reads phone sensors in real time and performs automated actions based on learned patterns or user-defined rules. It detects episodes like picking up your phone or leaving a location, then suggests or executes relevant actions.",
        video_url="https://www.youtube.com/embed/SeP5gTAS4j0",
        github_url="https://github.com/chess10kp/jachacks"
    ),
    Project(
        name="SybilScope",
        description="Detects fake wallet clusters in crypto airdrops by analyzing on-chain transaction history and wallet relationships. Combines Jac's native graph walker with GPT-4o reasoning to surface coordinated Sybils, like shared funding sources and identical transfer amounts, as visual clusters with evidence trails.",
        video_url="https://www.youtube.com/embed/6xC28FnsD9Y",
        github_url="https://github.com/shrimannmyneni/sybilscope"
    ),
    Project(
        name="Jac in the Block",
        description="An accessible learning toolkit for Jac that combines block-based visual programming, real-time graph visualization, and VS Code dev tools. Drag-and-drop blocks generate live Jac code while showing the running graph, with linting and debugging for the leap to professional development.",
        video_url="https://www.youtube.com/embed/nxqcHtGdQfo",
        live_url="https://jac-in-the-block.vercel.app/",
        github_url="https://github.com/krishdeshmukhhh/jac-dev-tools"
    ),
    Project(
        name="CivicMesh",
        description="A multi-agent AI navigator that helps people in crisis access social services. Users describe their situation in any language, and the system evaluates eligibility across 40+ federal and state programs, then returns a ranked action plan with required documents and transparent reasoning.",
        video_url="https://www.youtube.com/embed/lvuGwVVP2ic",
        live_url="https://huggingface.co/spaces/Anbu-00001/CivicMesh",
        github_url="https://github.com/Anbu-00001/CivicMesh"
    ),
    Project(
        name="Nourish",
        description="A real-time platform that connects surplus food with shelters and volunteer drivers. Autonomous Jac agents coordinate donations, match them to shelters based on capacity, and dispatch drivers for last-mile delivery.",
        video_url="https://www.youtube.com/embed/vnfOB2DHppQ",
        live_url="https://jac-sbx-27e89a9a-2e87-44a7-b-prj-177892-b9ebc024.jaseci.org",
        github_url="https://github.com/Viktor-Nedev/Nourish"
    ),
    Project(
        name="MediGraph",
        description="A medication safety checker that models the body as a graph of drugs, enzymes, and organs. AI agents reason through your body's own chemistry to surface dangerous interactions structurally, then propose safer alternatives.",
        video_url="https://www.youtube.com/embed/8B1SQwvSf9w",
        live_url="https://medigraph.onrender.com",
        github_url="https://github.com/SoujanyaChatti/MediGraph"
    ),
    Project(
        name="Orion & Diana",
        description="An autonomous OSINT platform that detects marine oil spills by continuously scraping maritime news, extracting coordinates, and analyzing Sentinel-1 SAR and Sentinel-2 optical imagery. Dual-sensor ML consensus classifies slicks and surfaces them on a real-time dashboard.",
        video_url="https://www.youtube.com/embed/nFKW_On0u9A",
        github_url="https://github.com/Luxaris/Orion-and-Diana-JacHacks"
    ),
    Project(
        name="Ori",
        description="A full-stack Jac starter template for building agentic applications, demonstrated with a vehicle-to-vehicle communication system aimed at reducing fuel consumption and improving safety. Ships with auth, protected routes, backend function demos, and a clean dark-themed UI.",
        video_url="https://www.youtube.com/embed/wUXlJ0tSvNA",
        github_url="https://github.com/orbitronsystems/ori-Jac-Demo"
    ),
    Project(
        name="FutureOS",
        description="A multi-agent AI life OS that turns long-term goals into actionable plans through six autonomous agents handling planning, execution, memory, analytics, coaching, and research. Built on a graph-based runtime in Jac with per-user isolation and a web-crawling research agent.",
        video_url="https://www.youtube.com/embed/v_5TzI9crGo",
        github_url="https://github.com/kshitijkumrawat20/JacHacks2026"
    ),
    Project(
        name="Killbill",
        description="An AI agent that analyzes bank statements to surface forgotten recurring subscriptions and automatically drafts cancellation emails. Clusters recurring charges, evaluates which subscriptions you actually need, and generates ready-to-send correspondence with merchant contact details.",
        video_url="https://www.youtube.com/embed/Q5hGeKgeuJk",
        github_url="https://github.com/fozagtx/killBill"
    ),
    Project(
        name="PolyWatch",
        description="An autonomous AI investigator for Polymarket that detects informed trading using a Tree-of-Thought reasoning engine across 26 specialized tools: market data, statistical analysis, news correlation, wallet profiling, and network analysis.",
        github_url="https://devpost.com/software/polywatch"
    )
];

glob PAGE_WASH: dict[str, object] = {
    "background": "radial-gradient(ellipse 80% 50% at 50% 0%, rgba(249,115,22,0.05), transparent 60%), radial-gradient(ellipse 60% 50% at 50% 100%, rgba(247,147,30,0.04), transparent 65%)"
};

glob PAGE_GRID: dict[str, object] = {
    "backgroundImage": "linear-gradient(rgba(255,255,255,1) 1px, transparent 1px), linear-gradient(90deg, rgba(255,255,255,1) 1px, transparent 1px)",
    "backgroundSize": "56px 56px",
    "maskImage": "radial-gradient(ellipse 70% 60% at 50% 30%, black, transparent 80%)",
    "WebkitMaskImage": "radial-gradient(ellipse 70% 60% at 50% 30%, black, transparent 80%)"
};

glob COMPANIES_WASH: dict[str, object] = {
    "background": "radial-gradient(ellipse 60% 50% at 50% 50%, rgba(249,115,22,0.08), transparent 70%)"
};

glob PROJECTS_WASH: dict[str, object] = {
    "background": "radial-gradient(ellipse 70% 50% at 30% 0%, rgba(247,147,30,0.08), transparent 70%), radial-gradient(ellipse 70% 50% at 70% 100%, rgba(249,115,22,0.07), transparent 70%)"
};

# --- video url helpers (string-based ports of the original regexes) ---------

def after(url: str, marker: str) -> str {
    if marker not in url {
        return "";
    }
    rest = url.split(marker)[1];
    return rest.split("?")[0].split("&")[0].split("/")[0];
}

def:pub youtube_id(url: str) -> str {
    if not url {
        return "";
    }
    for marker in ["youtube.com/embed/", "youtube.com/watch?v=", "youtu.be/"] {
        found = after(url, marker);
        if found {
            return found;
        }
    }
    return "";
}

def:pub drive_id(url: str) -> str {
    if not url {
        return "";
    }
    return after(url, "drive.google.com/file/d/");
}

def:pub is_video_file(url: str) -> bool {
    lowered = url.split("?")[0].lower();
    return lowered.endswith(".mp4") or lowered.endswith(".webm") or lowered.endswith(".ogg");
}

"""Turn an embeddable URL into the public watch page for the pop-out link."""
def:pub external_video_url(url: str) -> str {
    if not url {
        return url;
    }
    yt = after(url, "youtube.com/embed/");
    if yt {
        start = "";
        if "start=" in url {
            start = "&t=" + after(url, "start=") + "s";
        }
        return "https://www.youtube.com/watch?v=" + yt + start;
    }
    drive = drive_id(url);
    if drive {
        return "https://drive.google.com/file/d/" + drive + "/view";
    }
    return url;
}

# --- sections ---------------------------------------------------------------

def SectionHeader(eyebrow: str, title: str, description: str) -> JsxElement {
    return <div className="text-center max-w-3xl mx-auto">
        <div className="inline-flex items-center gap-2 mb-4">
            <span className="h-px w-8 bg-gradient-to-r from-transparent to-primary-orange/70"></span>
            <span
                className="text-[11px] font-bold tracking-[0.28em] uppercase text-primary-orange"
                style={{"filter": "drop-shadow(0 0 12px rgba(249,115,22,0.5))"}}
            >
                {eyebrow}
            </span>
            <span className="h-px w-8 bg-gradient-to-l from-transparent to-primary-orange/70"></span>
        </div>
        <h2 className="text-3xl md:text-4xl lg:text-5xl font-extrabold mb-4 tracking-tight leading-[1.15] md:leading-10 lg:leading-none pb-2 bg-clip-text text-transparent drop-shadow-[0_2px_24px_rgba(0,0,0,0.4)] bg-gradient-to-b from-white via-orange-50 to-amber-200/90">
            {title}
        </h2>
        <div className="h-0.5 mx-auto w-32 mb-5 bg-gradient-to-r from-transparent via-primary-orange to-transparent"></div>
        <p className="text-base md:text-lg text-orange-50/80 leading-relaxed">
            {description}
        </p>
    </div>;
}

def CompanyTile(company: Company, index: int) -> JsxElement {
    return <div
        className="group relative"
        style={{"animation": "fadeInUp 0.5s ease-out " + str(index * 0.05) + "s both"}}
    >
        {#* Animated gradient border *#}
        <div className="absolute -inset-px rounded-2xl bg-gradient-to-br from-primary-orange/0 via-primary-yellow/0 to-primary-orange/0 group-hover:from-primary-orange/60 group-hover:via-primary-yellow/40 group-hover:to-primary-orange/60 transition-all duration-500 opacity-70 blur-sm pointer-events-none"></div>

        <div className="relative h-full flex flex-col bg-gradient-to-br from-[#4a3622]/95 via-[#352618]/95 to-[#3d2c1c]/95 backdrop-blur-xl rounded-2xl border border-primary-yellow/45 transition-all duration-300 group-hover:border-primary-yellow/75 group-hover:-translate-y-1 group-hover:shadow-2xl group-hover:shadow-primary-yellow/40 shadow-[inset_0_1px_0_0_rgba(247,147,30,0.5),0_0_0_1px_rgba(247,147,30,0.08),0_10px_36px_-8px_rgba(0,0,0,0.6),0_0_24px_-8px_rgba(247,147,30,0.25)]">
            <a
                href={company.href}
                target="_blank"
                rel="noopener noreferrer"
                aria-label={company.name}
                className="flex-1 flex flex-col p-6"
            >
                <div className="relative flex items-center justify-center h-20 mb-4">
                    <div className="absolute inset-x-6 inset-y-1 rounded-2xl bg-white/[0.92] shadow-[0_8px_30px_-6px_rgba(255,255,255,0.15)] transition-all duration-300 group-hover:bg-white group-hover:shadow-[0_10px_40px_-6px_rgba(249,115,22,0.35)]"></div>
                    <img
                        src={company.logo}
                        alt={company.name + " logo"}
                        width={160}
                        height={64}
                        className="relative max-h-12 w-auto object-contain transition-transform duration-300 group-hover:scale-105"
                    />
                </div>
                <div className="text-center">
                    <h3 className="text-sm font-bold text-orange-50 tracking-wide">
                        {company.name}
                    </h3>
                    <p className="text-xs text-amber-200/55 mt-1">{company.blurb}</p>
                </div>
            </a>

            {if company.case_study_url {
                <div key="case-study" className="px-5 pb-5 -mt-1">
                    <a
                        href={company.case_study_url}
                        target="_blank"
                        rel="noopener noreferrer"
                        aria-label={"Read the " + company.name + " case study"}
                        className="relative inline-flex items-center justify-center gap-1.5 w-full px-3 py-2 rounded-lg text-[10.5px] font-bold tracking-[0.18em] uppercase text-primary-yellow border border-primary-yellow/45 bg-gradient-to-r from-primary-orange/20 via-primary-yellow/15 to-primary-orange/20 hover:from-primary-orange/35 hover:via-primary-yellow/25 hover:to-primary-orange/35 hover:border-primary-yellow/85 hover:text-orange-50 transition-all duration-300 shadow-[0_0_22px_-6px_rgba(247,147,30,0.55)] hover:shadow-[0_0_30px_-4px_rgba(247,147,30,0.75)] overflow-hidden"
                    >
                        <span className="pointer-events-none absolute inset-y-0 -left-1/3 w-1/3 bg-gradient-to-r from-transparent via-white/15 to-transparent skew-x-12 translate-x-0 group-hover:translate-x-[450%] transition-transform duration-700 ease-out"></span>
                        <span className="relative">Read the case study</span>
                        <FaArrowRight
                            size={9}
                            className="relative transition-transform duration-300 group-hover:translate-x-1"
                        />
                    </a>
                </div>
            }}

            {#* Corner shine *#}
            <div className="absolute top-0 right-0 w-16 h-16 bg-gradient-to-bl from-primary-orange/20 to-transparent rounded-tr-2xl opacity-0 group-hover:opacity-100 transition-opacity duration-500 pointer-events-none"></div>
        </div>
    </div>;
}

def:pub ProjectCard(project: Project, index: int, onPlay: Callable[[], None]) -> JsxElement {
    has thumb_errored: bool = False;

    has_video = bool(project.video_url);
    yt = youtube_id(project.video_url);
    drive = drive_id(project.video_url);
    is_file_video = is_video_file(project.video_url);

    raw_thumbnail = project.thumbnail;
    if not raw_thumbnail and yt {
        raw_thumbnail = "https://img.youtube.com/vi/" + yt + "/hqdefault.jpg";
    }
    if not raw_thumbnail and drive {
        raw_thumbnail = "https://drive.google.com/thumbnail?id=" + drive + "&sz=w640";
    }
    thumbnail = "" if thumb_errored else raw_thumbnail;
    mp4_preview = (project.video_url + "#t=0.5") if (not thumbnail and is_file_video) else "";

    def handle_error(e: Event) {
        thumb_errored = True;
    }

    def handle_play(e: MouseEvent) {
        if has_video {
            onPlay();
        }
    }

    return <article
        className="group relative h-full"
        style={{"animation": "fadeInUp 0.5s ease-out " + str(index * 0.07) + "s both"}}
    >
        {#* Gradient halo *#}
        <div className={"absolute -inset-0.5 rounded-2xl bg-gradient-to-br opacity-0 group-hover:opacity-60 blur-md transition duration-500 " + project.accent}></div>

        <div className="relative h-full flex flex-col bg-gradient-to-br from-[#5a4633] via-[#473628] to-[#52402e] rounded-2xl border border-orange-300/25 overflow-hidden transition-all duration-300 group-hover:border-primary-orange/55 group-hover:-translate-y-1 group-hover:shadow-2xl group-hover:shadow-primary-orange/25 shadow-[inset_0_1px_0_0_rgba(247,147,30,0.25),0_10px_36px_-8px_rgba(0,0,0,0.55),0_0_22px_-8px_rgba(247,147,30,0.2)]">
            {#* Top accent stripe *#}
            <div className={"h-1.5 w-full bg-gradient-to-r " + project.accent}></div>

            {#* Body *#}
            <div className="flex-1 px-6 pt-5 pb-4">
                <h3 className="text-2xl font-extrabold mb-2 tracking-tight pb-1 leading-tight bg-gradient-to-r from-primary-orange via-rose-300 to-primary-yellow bg-clip-text text-transparent drop-shadow-[0_0_18px_rgba(249,115,22,0.25)]">
                    {project.name}
                </h3>
                <p className="text-sm text-orange-50/85 leading-relaxed">
                    {project.description}
                </p>

                {if project.award {
                    <div key="award" className="mt-4 inline-flex items-center gap-2 px-2.5 py-1 rounded-full border border-primary-yellow/30 bg-primary-yellow/10 text-[11px] font-semibold text-primary-yellow tracking-wide">
                        <FaTrophy size={10} />
                        {project.award}
                    </div>
                }}
            </div>

            {#* Media / thumbnail with play overlay *#}
            <button
                type="button"
                onClick={handle_play}
                disabled={not has_video}
                aria-label={("Play " + project.name + " demo") if has_video else project.name}
                className={"relative block w-full aspect-video overflow-hidden " + ("cursor-pointer" if has_video else "cursor-default")}
            >
                <div className="absolute inset-0 bg-gradient-to-br from-[#3d3024] via-[#322619] to-[#251c14]">
                    <div className="absolute inset-0 bg-[radial-gradient(circle_at_50%_40%,rgba(247,147,30,0.15),transparent_60%)]"></div>
                </div>

                {if thumbnail {
                    <img
                        key="thumb"
                        src={thumbnail}
                        alt=""
                        loading="lazy"
                        referrerPolicy="no-referrer"
                        onError={handle_error}
                        className="absolute inset-0 w-full h-full object-cover transition-transform duration-500 group-hover:scale-[1.03]"
                    />
                } elif mp4_preview {
                    <video
                        key="thumb"
                        src={mp4_preview}
                        preload="metadata"
                        muted
                        playsInline
                        aria-label={project.name + " preview"}
                        className="absolute inset-0 w-full h-full object-cover transition-transform duration-500 group-hover:scale-[1.03] pointer-events-none"
                    />
                }}

                {if thumbnail or mp4_preview {
                    <div key="scrim" className="absolute inset-0 bg-gradient-to-t from-black/40 via-black/10 to-transparent"></div>
                }}

                {if not has_video {
                    <div key="overlay" className="absolute inset-0 flex flex-col items-center justify-center gap-3">
                        <div className="w-16 h-16 rounded-full bg-white/5 border border-white/15 flex items-center justify-center backdrop-blur-sm">
                            <FaPlay className="text-white/25 ml-1" size={20} />
                        </div>
                        <div className="text-[11px] font-bold tracking-[0.25em] uppercase text-orange-50/60">
                            Demo coming soon
                        </div>
                    </div>
                } else {
                    <div key="overlay" className="absolute inset-0 flex items-center justify-center">
                        <div className="w-16 h-16 rounded-full bg-white/15 backdrop-blur-md border border-white/30 flex items-center justify-center transition-all duration-300 group-hover:scale-110 group-hover:bg-white/25 shadow-2xl">
                            <FaPlay className="text-white ml-1 drop-shadow" size={20} />
                        </div>
                    </div>
                }}
            </button>

            {#* Footer actions *#}
            <div className="px-5 py-4 flex items-center gap-2 border-t border-orange-300/15 bg-[#3a2d22]/60">
                {if project.live_url {
                    <a
                        key="live"
                        href={project.live_url}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="inline-flex items-center gap-2 px-4 py-2 rounded-lg font-semibold text-sm text-white bg-gradient-to-r from-primary-orange to-primary-yellow shadow-md shadow-primary-orange/25 hover:-translate-y-0.5 hover:shadow-lg hover:shadow-primary-orange/35 transition-all duration-300"
                    >
                        <FaGlobe size={12} />
                        Live App
                    </a>
                }}
                {if project.github_url {
                    <a
                        key="github"
                        href={project.github_url}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="inline-flex items-center gap-2 px-4 py-2 rounded-lg font-semibold text-sm text-white bg-white/10 border border-white/15 hover:bg-white/15 hover:border-white/25 transition"
                    >
                        <FaGithub size={14} />
                        GitHub
                    </a>
                }}
            </div>
        </div>
    </article>;
}

def:pub VideoModal(project: Project, onClose: Callable[[], None]) -> JsxElement {
    url = project.video_url;
    is_file = is_video_file(url);
    watch_url = external_video_url(url);

    def close_backdrop(e: MouseEvent) {
        onClose();
    }

    def stop(e: MouseEvent) {
        e.stopPropagation();
    }

    def close_button(e: MouseEvent) {
        onClose();
    }

    return <div
        className="fixed inset-0 z-[100] overflow-y-auto bg-black/70 backdrop-blur-md"
        onClick={close_backdrop}
        role="dialog"
        aria-modal="true"
        aria-label={project.name + " demo"}
    >
        <div className="min-h-full flex items-center justify-center px-4 pt-28 pb-8 sm:pt-32 sm:pb-12">
            <div className="relative w-full max-w-3xl" onClick={stop}>
                <div className="absolute -top-12 right-0 flex items-center gap-2">
                    {if watch_url {
                        <a
                            key="watch"
                            href={watch_url}
                            target="_blank"
                            rel="noopener noreferrer"
                            aria-label="Watch on YouTube"
                            title="Watch on YouTube"
                            className="w-10 h-10 rounded-lg bg-white/10 hover:bg-white/20 backdrop-blur border border-white/20 flex items-center justify-center text-white transition"
                        >
                            <FaExternalLinkAlt size={14} />
                        </a>
                    }}
                    <button
                        type="button"
                        onClick={close_button}
                        aria-label="Close"
                        className="w-10 h-10 rounded-lg bg-white/10 hover:bg-white/20 backdrop-blur border border-white/20 flex items-center justify-center text-white transition"
                    >
                        <FaTimes size={16} />
                    </button>
                </div>

                <div className="relative aspect-video bg-black rounded-2xl overflow-hidden shadow-2xl ring-1 ring-white/10">
                    {if url and is_file {
                        <video
                            key="player"
                            src={url}
                            controls
                            autoPlay
                            className="w-full h-full object-contain bg-black"
                        />
                    } elif url {
                        <iframe
                            key="player"
                            src={url}
                            title={project.name + " demo"}
                            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                            allowFullScreen
                            className="w-full h-full"
                        />
                    } else {
                        <div key="player" className="w-full h-full flex items-center justify-center text-dark-text/70 text-sm">
                            No demo video available yet.
                        </div>
                    }}
                </div>
            </div>
        </div>
    </div>;
}

def:pub BuiltWithJaseciView() -> JsxElement {
    has active: Project | None = None;

    useEffect(lambda {
        if active is None {
            return lambda { };
        }
        on_key = lambda (e: KeyboardEvent) {
            if e.key == "Escape" {
                active = None;
            }
        };
        body().style.overflow = "hidden";
        win().addEventListener("keydown", on_key);
        return lambda {
            body().style.overflow = "";
            win().removeEventListener("keydown", on_key);
        };
    }, [active]);

    def close_modal() -> None {
        active = None;
    }

    return <div className="bg-dark-bg text-white relative overflow-hidden">
        <SeoMeta
            title="Built with Jaseci"
            meta_title="Built with Jaseci: Companies & Projects in Production"
            description="Companies and projects shipping AI-native applications with Jac and the Jaseci stack."
            image="/assets/images/logo.png"
        />

        {#* Warm radial wash *#}
        <div className="absolute inset-0 pointer-events-none" style={PAGE_WASH}></div>

        {#* Subtle grid texture for depth *#}
        <div className="absolute inset-0 pointer-events-none opacity-[0.05]" style={PAGE_GRID}></div>

        {#* Ambient colour blobs *#}
        <div className="absolute inset-0 pointer-events-none overflow-hidden">
            <div className="absolute -top-20 left-[5%] w-[34rem] h-[34rem] bg-primary-orange/12 rounded-full blur-[160px] animate-blob-pulse"></div>
            <div className="absolute top-[20%] right-[-8%] w-[36rem] h-[36rem] bg-primary-yellow/10 rounded-full blur-[180px] animate-blob-pulse animation-delay-2000"></div>
            <div className="absolute top-[45%] left-[-6%] w-[32rem] h-[32rem] bg-rose-400/10 rounded-full blur-[180px] animate-blob-pulse"></div>
            <div className="absolute top-[55%] right-[5%] w-[30rem] h-[30rem] bg-teal-400/8 rounded-full blur-[180px] animate-blob-pulse animation-delay-2000"></div>
            <div className="absolute bottom-[-10%] left-[25%] w-[38rem] h-[38rem] bg-fuchsia-500/9 rounded-full blur-[200px] animate-blob-pulse"></div>
            <div className="absolute bottom-[5%] right-[-5%] w-[28rem] h-[28rem] bg-violet-500/8 rounded-full blur-[180px] animate-blob-pulse animation-delay-2000"></div>
        </div>

        <main className="relative pt-16 md:pt-20">
            {#* Hero *#}
            <section className="relative pt-20 pb-16 text-center overflow-hidden">
                <div className="absolute inset-x-0 top-10 h-[26rem] pointer-events-none flex items-start justify-center">
                    <div className="relative w-[44rem] h-[44rem] -mt-40">
                        <div className="absolute inset-0 rounded-full bg-[radial-gradient(circle_at_center,rgba(249,115,22,0.10),transparent_60%)]"></div>
                        <div className="absolute inset-12 rounded-full bg-[radial-gradient(circle_at_center,rgba(247,147,30,0.07),transparent_65%)]"></div>
                    </div>
                </div>

                <div className="container max-w-5xl mx-auto px-5 relative z-10">
                    <div className="inline-flex items-center gap-2 mb-7 px-3 py-1.5 rounded-full border border-primary-orange/40 bg-gradient-to-r from-primary-orange/20 to-primary-yellow/15 backdrop-blur-sm text-xs font-bold tracking-[0.2em] uppercase text-primary-orange shadow-[0_0_24px_-4px_rgba(249,115,22,0.55)]">
                        ✦ Showcase
                    </div>

                    <h1 className="text-5xl sm:text-6xl md:text-7xl font-extrabold leading-[1.05] sm:leading-none tracking-tight mb-6">
                        <span className="block bg-gradient-to-b from-white via-orange-50 to-amber-100/90 bg-clip-text text-transparent drop-shadow-[0_2px_30px_rgba(0,0,0,0.5)]">
                            Built with
                        </span>
                        <span className="block bg-gradient-to-r from-primary-orange via-primary-yellow to-primary-orange bg-clip-text text-transparent drop-shadow-[0_0_45px_rgba(249,115,22,0.45)] animate-gradient-x">
                            Jaseci
                        </span>
                    </h1>

                    <p className="text-lg md:text-xl text-orange-50/85 leading-relaxed max-w-2xl mx-auto">
                        From idea to production, all in Jac. Meet the companies and projects
                        shipping AI-native applications with Jac and the Jaseci stack.
                    </p>
                </div>
            </section>

            {#* Companies *#}
            <section className="relative py-20">
                <div className="absolute inset-0 pointer-events-none" style={COMPANIES_WASH}></div>

                <div className="container max-w-7xl mx-auto px-5 relative">
                    <SectionHeader
                        eyebrow="Companies & organizations"
                        title="Building solutions with Jaseci"
                        description="Industry teams using Jaseci to ship AI-native experiences in production."
                    />

                    <div className="mt-14 grid grid-cols-1 sm:grid-cols-3 gap-6 max-w-4xl mx-auto">
                        {for (i, company) in enumerate(COMPANIES) {
                            <CompanyTile key={company.name} company={company} index={i} />
                        }}
                    </div>
                </div>
            </section>

            {#* Projects *#}
            <section className="relative py-20">
                <div className="absolute inset-x-0 top-0 h-px bg-gradient-to-r from-transparent via-primary-orange/40 to-transparent"></div>
                <div className="absolute inset-0 pointer-events-none" style={PROJECTS_WASH}></div>

                <div className="container max-w-7xl mx-auto px-5 relative">
                    <SectionHeader
                        eyebrow="Featured projects"
                        title="What developers are building"
                        description="A curated set of products, platforms, and research projects built with Jac and the Jaseci stack."
                    />

                    <div className="mt-14 grid gap-7 grid-cols-1 md:grid-cols-2 lg:grid-cols-3">
                        {for (i, project) in enumerate(PROJECTS) {
                            <ProjectCard
                                key={project.name}
                                project={project}
                                index={i}
                                onPlay={lambda { active = project; }}
                            />
                        }}
                    </div>
                </div>
            </section>
        </main>

        {if active is not None {
            <VideoModal key="modal" project={active} onClose={close_modal} />
        }}
    </div>;
}
