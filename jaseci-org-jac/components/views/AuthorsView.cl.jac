"""Paginated author listing - ports `app/authors/page/[slug]/page.js`."""

import from ..Authors { Authors }
import from ..SeoMeta { SeoMeta }
import from ...lib.site { PAGINATION }

sv import from ...server.content { Doc, authors_index, list_authors }

def:pub AuthorsView(current_page: int = 1) -> JsxElement {
    has authors: list[Doc] = [],
        title: str = "";

    async can with entry {
        authors = await list_authors();
        index = await authors_index();
        title = index.frontmatter.title;
    }

    total_pages = (len(authors) + PAGINATION - 1) // PAGINATION;
    last_index = current_page * PAGINATION;
    first_index = last_index - PAGINATION;
    current_authors = authors[first_index:last_index];

    return <>
        <SeoMeta title={title} />
        <section className="section">
            <div className="container text-center">
                <h1 className="h2 mb-16">{title}</h1>
                <Authors authors={current_authors} />
                {if total_pages > 1 {
                    <nav key="pagination" className="mb-4 flex justify-center space-x-4" aria-label="Pagination">
                        {for page in range(1, total_pages + 1) {
                            <span
                                key={"author-page-" + str(page)}
                                aria-current="page"
                                className={
                                    "rounded-lg border border-primary px-4 py-2 "
                                    + ("bg-primary text-white" if page == current_page else "text-dark")
                                }
                            >
                                {page}
                            </span>
                        }}
                    </nav>
                }}
            </div>
        </section>
    </>;
}
