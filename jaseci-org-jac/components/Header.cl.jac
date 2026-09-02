"""Site header - ports `layouts/partials/Header.js` (top bar + floating nav)."""

import from react { useEffect }
import from "@jac/runtime" { Link, useLocation }
import from "react-icons/io5" { IoSearch }
import from "react-icons/fa6" { FaCodeFork, FaGithub, FaStar }

import from .Logo { Logo }
import from .SearchModal { SearchModal }
import from ..lib.site { MAIN_MENU }
import from ..lib.dom { query, win }

sv import from ..server.content { GithubStats, github_stats }

def:pub Header() -> JsxElement {
    has search_modal: bool = False,
        stars: str = "--",
        forks: str = "--",
        top_bar_height: int = 40;

    location = useLocation();

    async can with entry {
        stats = await github_stats();
        stars = stats.stars;
        forks = stats.forks;
    }

    useEffect(lambda {
        measure = lambda {
            bar = query(".top-bar");
            if bar {
                top_bar_height = bar.offsetHeight as int;
            }
        };
        measure();
        win().addEventListener("resize", measure);
        return lambda { win().removeEventListener("resize", measure); };
    }, []);

    def open_search(e: MouseEvent) {
        search_modal = True;
    }

    def close_search() -> None {
        search_modal = False;
    }

    return <>
        {#* Top Bar *#}
        <div className="top-bar w-full bg-dark-bg text-white text-xs sm:text-sm py-2 px-4 flex justify-center items-center fixed top-0 left-0 z-[101]">
            <div className="top-bar-content flex flex-col sm:flex-row w-full max-w-7xl items-center justify-between gap-2 sm:gap-4">
                <div className="flex items-center gap-2 text-center sm:text-left">
                    <span className="font-medium leading-tight">The Jac Programming Language and Jaseci Stack</span>
                </div>
                <div className="flex items-center gap-3">
                    <a
                        href="https://github.com/jaseci-labs/jaseci"
                        className="group flex items-center gap-2 rounded-full border border-white/15 bg-white/[0.06] py-1 pl-3 pr-1.5 transition-all duration-300 hover:border-primary-orange/50 hover:bg-white/10"
                        target="_blank"
                        rel="noopener noreferrer"
                    >
                        <FaGithub className="w-4 h-4 shrink-0" />
                        <span className="font-semibold mr-1">GitHub</span>
                        <span className="flex items-center gap-1 rounded-full bg-black/40 px-2 py-0.5 text-xs">
                            <FaStar className="w-3 h-3 text-yellow-400" />
                            <span className="font-mono">{stars}</span>
                        </span>
                        <span className="flex items-center gap-1 rounded-full bg-black/40 px-2 py-0.5 text-xs">
                            <FaCodeFork className="w-3 h-3 text-gray-300" />
                            <span className="font-mono">{forks}</span>
                        </span>
                    </a>
                </div>
            </div>
        </div>

        {#* Main Header *#}
        <header
            className="w-full z-50 fixed transition-all duration-300"
            style={{"top": str(top_bar_height) + "px"}}
        >
            <nav className="container max-w-7xl mx-auto px-3 py-3 rounded-2xl transition-all duration-300 bg-medium-bg/45 backdrop-blur-md shadow-xl border border-light-bg/30">
                <div className="flex items-center justify-between">
                    {#* Left section - Logo and Brand *#}
                    <div className="flex items-center gap-3">
                        <Logo />
                        <Link to="/" className="hidden sm:block text-lg font-semibold text-white hover:opacity-80 transition-opacity duration-200">
                            Jac & Jaseci
                        </Link>
                    </div>

                    {#* Center section - Desktop Menu *#}
                    <ul className="hidden md:flex items-center space-x-1">
                        {for (i, item) in enumerate(MAIN_MENU) {
                            <li key={"menu-" + str(i)}>
                                {if item.target {
                                    <a
                                        key="ext"
                                        href={item.url}
                                        target={item.target}
                                        rel={item.rel}
                                        className={
                                            "block px-4 py-2 transition-all duration-200 rounded-full whitespace-nowrap "
                                            + ("bg-primary-orange text-white" if location.pathname == item.url
                                               else "text-dark-text hover:text-white hover:bg-white/10")
                                        }
                                    >
                                        {item.name}
                                    </a>
                                } else {
                                    <Link
                                        key="int"
                                        to={item.url}
                                        className={
                                            "block px-4 py-2 transition-all duration-200 rounded-full whitespace-nowrap "
                                            + ("bg-primary-orange text-white" if location.pathname == item.url
                                               else "text-dark-text hover:text-white hover:bg-white/10")
                                        }
                                    >
                                        {item.name}
                                    </Link>
                                }}
                            </li>
                        }}
                    </ul>

                    {#* Right section - Search and Mobile Menu *#}
                    <div className="flex items-center gap-2">
                        <button
                            onClick={open_search}
                            className="p-2 text-dark-text hover:text-white hover:bg-white/10 rounded-full transition-all duration-200"
                            aria-label="Open search"
                        >
                            <IoSearch className="h-5 w-5" />
                        </button>

                        <div className="md:hidden">
                            <input id="nav-toggle" type="checkbox" className="hidden peer" />
                            <label
                                htmlFor="nav-toggle"
                                className="flex flex-col cursor-pointer p-2 peer-checked:hidden"
                                aria-label="Open menu"
                            >
                                <span className="w-6 h-0.5 bg-white mb-1 transition-all"></span>
                                <span className="w-6 h-0.5 bg-white mb-1 transition-all"></span>
                                <span className="w-6 h-0.5 bg-white transition-all"></span>
                            </label>
                            <label
                                htmlFor="nav-toggle"
                                className="hidden peer-checked:flex cursor-pointer p-2"
                                aria-label="Close menu"
                            >
                                <svg className="h-6 w-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                                </svg>
                            </label>

                            {#* Mobile Menu *#}
                            <div className="absolute top-full right-0 mt-2 w-64 py-4 bg-medium-bg/95 backdrop-blur-md rounded-xl border border-light-bg/50 shadow-xl opacity-0 invisible peer-checked:opacity-100 peer-checked:visible transition-all duration-200">
                                <ul className="space-y-1 px-2">
                                    {for (i, item) in enumerate(MAIN_MENU) {
                                        <li key={"mobile-menu-" + str(i)}>
                                            {if item.target {
                                                <a
                                                    key="ext"
                                                    href={item.url}
                                                    target={item.target}
                                                    rel={item.rel}
                                                    className="block px-4 py-3 text-dark-text hover:text-white hover:bg-white/10 rounded-lg transition-colors"
                                                >
                                                    {item.name}
                                                </a>
                                            } else {
                                                <Link
                                                    key="int"
                                                    to={item.url}
                                                    className="block px-4 py-3 text-dark-text hover:text-white hover:bg-white/10 rounded-lg transition-colors"
                                                >
                                                    {item.name}
                                                </Link>
                                            }}
                                        </li>
                                    }}
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </nav>
        </header>
        <SearchModal open={search_modal} onClose={close_search} />
    </>;
}
