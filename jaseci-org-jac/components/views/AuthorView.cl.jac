"""Single author - ports `app/authors/[single]/page.js`."""

import from "@jac/runtime" { useParams }
import from ..layouts.AuthorSingle { AuthorSingle }

sv import from ...server.content { Doc, get_author }

def:pub AuthorView() -> JsxElement {
    has author: Doc | None = None,
        loaded: bool = False;

    params = useParams();
    raw_slug = params["single"];
    slug: str = (raw_slug as str) if raw_slug else "";

    async can with [slug] entry {
        if slug {
            author = await get_author(slug);
        }
        loaded = True;
    }

    return <>
        {if author is not None {
            <AuthorSingle key="author" author={author} />
        } elif loaded {
            <section key="missing" className="section">
                <div className="container text-center">
                    <h1 className="h2">Author not found</h1>
                </div>
            </section>
        }}
    </>;
}
