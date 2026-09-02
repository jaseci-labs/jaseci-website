"""Category / tag index - ports `app/categories/page.js` and `app/tags/page.js`."""

import from "@jac/runtime" { Link }
import from ..SeoMeta { SeoMeta }
import from ...lib.site { humanize }

import from content { taxonomy }

def:pub TaxonomyListView(name: str, title: str) -> JsxElement {
    has terms: list[str] = [];

    async can with [name] entry {
        terms = await taxonomy(name);
    }

    return
        <>
            <SeoMeta title={title}/>
            <section className="section min-h-dvh">
                <div className="container text-center">
                    <h1 className="h2 mb-16">{title}</h1>
                    <ul className="space-x-4">
                        {for (i, term) in enumerate(terms) {
                            <li key={"term-" + str(i)} className="inline-block">
                                <Link
                                    to={"/" + name + "/" + term}
                                    className="rounded-lg bg-theme-light px-4 py-2 text-dark transition hover:bg-primary hover:text-white"
                                >
                                    {"• " + humanize(term)}
                                </Link>
                            </li>
                        }}
                    </ul>
                </div>
            </section>
        </>;
}
