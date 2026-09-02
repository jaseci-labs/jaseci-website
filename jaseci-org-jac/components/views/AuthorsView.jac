"""Paginated author listing - ports `app/authors/page/[slug]/page.js`."""

import from ..Authors { Authors }
import from ..Pagination { Pagination }
import from ..SeoMeta { SeoMeta }
import from ...lib.site { PAGINATION }

import from content { Doc, authors_index, list_authors }

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

    return
        <>
            <SeoMeta title={title}/>
            <section className="section">
                <div className="container text-center">
                    <h1 className="h2 mb-16">{title}</h1>
                    <Authors authors={current_authors}/>
                    <Pagination total_pages={total_pages} current_page={current_page}/>
                </div>
            </section>
        </>;
}
