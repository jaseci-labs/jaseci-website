"""Posts filtered by category or tag - ports `app/categories/[category]/page.js`
and `app/tags/[tag]/page.js`."""

import from "@jac/runtime" { useParams }
import from ..Posts { Posts }
import from ..SeoMeta { SeoMeta }

import from content { Doc, list_authors, posts_by_taxonomy }

def:pub TaxonomyPostsView(name: str, param: str, noun: str) -> JsxElement {
    has posts: list[Doc] = [],
        authors: list[Doc] = [];

    params = useParams();
    raw_term = params[param];
    term: str = (raw_term as str) if raw_term else "";

    async can with [term] entry {
        if term {
            posts = await posts_by_taxonomy(name, term);
        }
        authors = await list_authors();
    }

    return
        <>
            <SeoMeta title={term}/>
            <div className="section">
                <div className="container">
                    <h1 className="h2 mb-8 text-center">
                        {"Showing posts from "}
                        <span className="text-primary">{term}</span>
                        {" " + noun}
                    </h1>
                    <Posts posts={posts} authors={authors}/>
                </div>
            </div>
        </>;
}
