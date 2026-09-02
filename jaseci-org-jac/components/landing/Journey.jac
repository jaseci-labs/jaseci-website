"""Journey timeline - ports `layouts/components/landing/Journey.js`."""

obj Milestone {
    has description: str = "",
        link: str = "",
        link_text: str = "";
}

obj TimelineItem {
    has description: str = "",
        link: str = "",
        link_text: str = "",
        number: str = "",
        year: str = "",
        title: str = "";
}

glob MILESTONES: list[Milestone] = [
    Milestone(
        description="In 2020, the concept of a new way of developing software in the AI era is conceived and later described in a Forbes blog article.",
        link="https://www.forbes.com/sites/forbesbooksauthors/2021/05/18/whats-in-store-for-the-next-generation-of-ai-the-jaseci-perspective/",
        link_text="Forbes Article"
    ),
    Milestone(
        description="In 2022, the idea has evolved and the first intellectual step in the journey of Jaseci and Jac is described.",
        link="https://arxiv.org/abs/2206.08434",
        link_text="The Philosophy of Jaseci and Jac"
    ),
    Milestone(
        description="Then in 2023, the idea survives peer-review at Computer Architecture Letters.",
        link="https://arxiv.org/abs/2305.09864",
        link_text="The Jaseci Programming Paradigm and Runtime Stack"
    ),
    Milestone(
        description="In 2024, the idea that AI should be a conventional code construct in the language is conjured and elucidated.",
        link="https://arxiv.org/abs/2405.08965v1",
        link_text="MTP: A Meaning-Typed Language Abstraction for AI"
    ),
    Milestone(
        description="Then in 2025, the idea survives peer-review. (pending)",
        link="https://arxiv.org/abs/2405.08965v4",
        link_text="Meaning-Typed Programming: Language Abstraction and Runtime"
    ),
    Milestone(
        description="That same year (2025), \"data-spatial programming\" described in earlier works becomes \"object-spatial programming\" and is rigorously defined.",
        link="https://arxiv.org/abs/2503.15812",
        link_text="Object-Spatial Programming"
    ),
    Milestone(
        description="In 2025, the notion of \"scale-native programming\" through language abstraction is rigorously defined though it was first described in the original 2022 paper.",
        link="https://arxiv.org/abs/2504.03109",
        link_text="Scale Native Programming"
    )
];

def is_word_char(ch: str) -> bool {
    return ch.isalnum() or ch == "_";
}

"""First standalone `20xx` / `25xx` in the text - the `\\b(20\\d{2}|25\\d{2})\\b` port."""
def extract_year(text: str) -> str {
    limit = len(text) - 3;
    for i in range(0, limit) {
        head = text[i:i + 2];
        if head != "20" and head != "25" {
            continue;
        }
        if not text[i + 2].isdigit() or not text[i + 3].isdigit() {
            continue;
        }
        if i > 0 and is_word_char(text[i - 1]) {
            continue;
        }
        if i + 4 < len(text) and is_word_char(text[i + 4]) {
            continue;
        }
        return text[i:i + 4];
    }
    return "";
}

def pad2(value: int) -> str {
    text = str(value);
    return text if len(text) >= 2 else "0" + text;
}

def build_items() -> list[TimelineItem] {
    items: list[TimelineItem] = [];
    for (i, milestone) in enumerate(MILESTONES) {
        head = milestone.description.split(":")[0];
        items.append(TimelineItem(
            description=milestone.description,
            link=milestone.link,
            link_text=milestone.link_text,
            number=pad2(i + 1),
            year=extract_year(milestone.description),
            title=head if len(head) < 40 else ""
        ));
    }
    return items;
}

glob ITEMS: list[TimelineItem] = build_items();

glob GRID_BACKDROP: str = "bg-[url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCA0MCA0MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0iTTAgMUg0MFYwSDBWMVoiIGZpbGw9InVybCgjZ3JpZCkiLz4KPHA+PC9wYXRoPgo8cGF0aCBkPSJNMSAwVjQwSDBWMEgxWiIgZmlsbD0idXJsKCNncmlkKSIvPgo8ZGVmcz4KPGxpbmVhckdyYWRpZW50IGlkPSJncmlkIiB4MT0iMCIgeTE9IjAiIHgyPSIxIiB5Mj0iMCI+CjxzdG9wIHN0b3AtY29sb3I9IiNmZjk1MDAiIHN0b3Atb3BhY2l0eT0iMC4wNSIvPgo8L2xpbmVhckdyYWRpZW50Pgo8L2RlZnM+Cjwvc3ZnPgo=')]";

def:pub Journey() -> JsxElement {
    return <section className="relative py-6 sm:py-8 md:py-10 lg:py-12 xl:py-16 overflow-hidden">
        <div className="absolute inset-0">
            <div className={"absolute inset-0 opacity-10 sm:opacity-20 " + GRID_BACKDROP}></div>
            <div className="absolute top-1/4 left-1/6 sm:left-1/4 w-32 h-32 sm:w-64 sm:h-64 lg:w-96 lg:h-96 bg-gradient-to-r from-orange-500/10 to-orange-400/10 rounded-full blur-2xl sm:blur-3xl animate-pulse"></div>
            <div className="absolute bottom-1/4 right-1/6 sm:right-1/4 w-24 h-24 sm:w-48 sm:h-48 lg:w-80 lg:h-80 bg-gradient-to-r from-orange-400/10 to-orange-300/10 rounded-full blur-xl sm:blur-3xl animate-pulse delay-1000"></div>
        </div>

        <div className="relative z-10 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div className="text-center mb-8 sm:mb-12 lg:mb-16">
                <div className="w-full max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
                    <div className="text-center mb-6 sm:mb-8">
                        <div className="inline-block">
                            <h2 className="text-2xl sm:text-3xl lg:text-4xl font-bold text-white mb-2 bg-gradient-to-r from-white via-primary-orange to-primary-yellow bg-clip-text text-transparent">
                                Journey of Jaseci
                            </h2>
                            <div className="h-1 bg-gradient-to-r from-transparent via-primary-orange to-transparent mx-auto w-32"></div>
                        </div>
                        <p className="text-primary-orange italic mt-3 text-sm sm:text-base font-medium">
                            ~ The story of an idea realized ~
                        </p>
                    </div>
                </div>
            </div>

            <div className="relative">
                {#* Mobile Timeline - Single Column *#}
                <div className="block md:hidden">
                    <div className="absolute left-6 top-0 bottom-0 w-px bg-gradient-to-b from-primary-orange via-primary-yellow to-primary-orange/20 shadow-[0_0_10px_rgba(255,149,0,0.3)]"></div>

                    <div className="space-y-4">
                        {for (i, item) in enumerate(ITEMS) {
                            <div
                                key={"m-" + str(i)}
                                className="relative flex items-start"
                                style={{"animation": "slideInLeft 0.8s ease-out " + str(i * 0.2) + "s both"}}
                            >
                                <div className="absolute left-3 w-5 h-5 bg-gradient-to-br from-primary-orange to-primary-yellow rounded-full flex items-center justify-center z-10 shadow-lg shadow-primary-orange/25">
                                    <span className="text-[10px] font-bold text-white drop-shadow-sm">
                                        {item.number}
                                    </span>
                                </div>

                                <div className="ml-12 flex-1">
                                    <div className="bg-gradient-to-br from-dark-bg/90 via-dark-bg/80 to-dark-bg/90 backdrop-blur-sm border border-light-bg/20 rounded-xl p-3 hover:border-primary-orange/40 transition-all duration-300 hover:shadow-lg hover:shadow-primary-orange/10 hover:transform hover:scale-[1.02]">
                                        <div className="flex flex-col gap-3 mb-3">
                                            <div className="flex items-center justify-between">
                                                <span className="inline-flex items-center px-2 py-1 text-xs font-bold text-primary-orange bg-primary-orange/10 border border-primary-orange/30 rounded-md">
                                                    <div className="w-1.5 h-1.5 bg-primary-orange rounded-full mr-2 animate-pulse"></div>
                                                    {item.year}
                                                </span>
                                                <a
                                                    href={item.link}
                                                    target="_blank"
                                                    rel="noopener noreferrer"
                                                    className="inline-flex items-center gap-2 px-3 py-1.5 text-xs font-medium text-primary-orange hover:text-white bg-primary-orange/10 hover:bg-primary-orange rounded-full transition-all duration-300"
                                                >
                                                    <span>Read</span>
                                                    <svg className="w-3 h-3" fill="currentColor" viewBox="0 0 20 20">
                                                        <path fillRule="evenodd" d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z" clipRule="evenodd" />
                                                    </svg>
                                                </a>
                                            </div>
                                            {if item.title {
                                                <h3 key="title" className="text-sm font-bold text-primary-orange">
                                                    {item.title}
                                                </h3>
                                            }}
                                        </div>
                                        <p className="text-sm text-dark-text leading-relaxed">
                                            {item.description}
                                        </p>
                                    </div>
                                </div>
                            </div>
                        }}
                    </div>
                </div>

                {#* Desktop/Tablet Timeline - Alternating *#}
                <div className="hidden md:block">
                    <div className="absolute left-1/2 transform -translate-x-1/2 top-0 bottom-0 w-px bg-gradient-to-b from-primary-orange via-primary-yellow to-primary-orange/20 shadow-[0_0_10px_rgba(255,149,0,0.3)]"></div>
                    <div className="absolute left-1/2 transform -translate-x-1/2 top-0 bottom-0 w-px bg-gradient-to-b from-primary-orange/50 via-transparent to-transparent animate-pulse"></div>

                    <div className="space-y-5 lg:space-y-6 xl:space-y-8">
                        {for (i, item) in enumerate(ITEMS) {
                            <div
                                key={"d-" + str(i)}
                                className={"relative flex items-center " + ("justify-start" if i % 2 == 0 else "justify-end")}
                                style={{
                                    "animation": ("slideInLeft" if i % 2 == 0 else "slideInRight")
                                        + " 0.8s ease-out " + str(i * 0.2) + "s both"
                                }}
                            >
                                <div className="absolute left-1/2 transform -translate-x-1/2 z-20">
                                    <div className="relative w-8 h-8 lg:w-10 lg:h-10 bg-gradient-to-br from-primary-orange to-primary-yellow rounded-full flex items-center justify-center hover:scale-110 transition-all duration-500 shadow-lg shadow-primary-orange/25">
                                        <div className="absolute inset-0 rounded-full bg-gradient-to-br from-primary-orange to-primary-yellow opacity-30 blur-sm animate-pulse"></div>
                                        <span className="relative text-[10px] lg:text-xs font-bold text-white z-10 drop-shadow-sm">
                                            {item.number}
                                        </span>
                                        <div className="absolute inset-0 rounded-full border-2 border-primary-orange/50 animate-ping"></div>
                                    </div>
                                </div>

                                {#* Content Card *#}
                                <div className={
                                    "relative w-full max-w-sm lg:max-w-md xl:max-w-lg "
                                    + ("mr-auto pr-6 lg:pr-8" if i % 2 == 0 else "ml-auto pl-6 lg:pl-8")
                                }>
                                    <div className="relative group">
                                        <div className={
                                            "absolute top-6 lg:top-8 w-6 lg:w-8 h-px bg-gradient-to-r "
                                            + ("from-primary-orange to-transparent right-0" if i % 2 == 0
                                               else "from-transparent to-primary-orange left-0")
                                        }></div>

                                        <div className="relative bg-gradient-to-br from-dark-bg/90 via-dark-bg/80 to-dark-bg/90 backdrop-blur-sm border border-light-bg/20 rounded-xl p-3 lg:p-4 hover:border-primary-orange/40 transition-all duration-300 hover:shadow-xl hover:shadow-primary-orange/10 hover:transform hover:scale-[1.02]">
                                            <div className="absolute inset-0 rounded-xl bg-gradient-to-br from-primary-orange/5 via-transparent to-primary-yellow/5 opacity-0 group-hover:opacity-100 transition-opacity duration-500"></div>

                                            <div className="flex items-center justify-between mb-2 lg:mb-3">
                                                <div className="relative">
                                                    <span className="relative inline-flex items-center px-2 py-1 text-xs sm:text-sm font-bold text-primary-orange bg-primary-orange/10 border border-primary-orange/30 rounded-md hover:bg-primary-orange/20 hover:border-primary-orange/50 transition-all duration-300">
                                                        <div className="w-1.5 h-1.5 bg-primary-orange rounded-full mr-2 animate-pulse"></div>
                                                        {item.year}
                                                    </span>
                                                </div>

                                                <a
                                                    href={item.link}
                                                    target="_blank"
                                                    rel="noopener noreferrer"
                                                    className="group/link relative inline-flex items-center gap-2 px-3 py-1.5 text-xs sm:text-sm font-medium text-primary-orange hover:text-white bg-primary-orange/10 hover:bg-primary-orange rounded-full transition-all duration-300 hover:transform hover:scale-105"
                                                >
                                                    <span className="relative z-10 hidden sm:inline">{item.link_text}</span>
                                                    <span className="relative z-10 sm:hidden">Read</span>
                                                    <svg className="w-3 h-3 lg:w-4 lg:h-4 transition-transform duration-300 group-hover/link:translate-x-1" fill="currentColor" viewBox="0 0 20 20">
                                                        <path fillRule="evenodd" d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z" clipRule="evenodd" />
                                                    </svg>
                                                </a>
                                            </div>

                                            {if item.title {
                                                <h3 key="title" className="text-sm sm:text-base font-semibold text-primary-orange mb-2 group-hover:text-primary-yellow transition-colors duration-300">
                                                    {item.title}
                                                </h3>
                                            }}

                                            <p className="text-sm text-dark-text leading-relaxed group-hover:text-white/90 transition-colors duration-300">
                                                {item.description}
                                            </p>
                                            <div className="absolute bottom-0 left-3 lg:left-4 right-3 lg:right-4 h-px bg-gradient-to-r from-transparent via-primary-orange/30 to-transparent"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        }}
                    </div>
                </div>
            </div>

            {#* Journey continues message *#}
            <div className="text-center mt-12 pt-8 border-t border-light-bg/10">
                <p className="text-lg sm:text-xl text-primary-orange font-medium italic opacity-80 hover:opacity-100 transition-opacity duration-300">
                    And the journey continues...
                </p>
            </div>
        </div>
    </section>;
}
