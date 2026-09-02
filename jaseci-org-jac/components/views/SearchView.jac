"""Search results - ports `app/search/page.js` + `layouts/partials/SearchResults.js`."""

import from "@jac/runtime" { useLocation }
import from ..Posts { Posts }
import from ..SeoMeta { SeoMeta }

import from content { Doc, list_authors, search_posts }

def:pub SearchView() -> JsxElement {
    has results: list[Doc] = [],
        authors: list[Doc] = [];

    location = useLocation();
    params: any = new(URLSearchParams, location.search);  # jac:ignore[E1053]
    raw_key = params.get("key");
    key: str = (raw_key as str) if raw_key else "";

    async can with [key] entry {
        results = await search_posts(key);
        authors = await list_authors();
    }

    return
        <>
            <SeoMeta title={"Search results for " + key}/>
            <div className="section">
                <div className="container">
                    <section className="h-[calc(100vh-23rem)]">
                        <h1 className="h2 mb-8 text-center">
                            {"Search results for "}
                            <span className="text-primary">{key}</span>
                        </h1>
                        {if len(results) > 0 {
                            <Posts key="results" posts={results} authors={authors}/>
                        } else {
                            <div
                                key="empty"
                                className="py-24 text-center text-h3 shadow"
                            >
                                No Search Found
                            </div>
                        } }
                    </section>
                </div>
            </div>
        </>;
}
