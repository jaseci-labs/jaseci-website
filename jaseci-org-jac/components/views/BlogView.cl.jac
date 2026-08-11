"""Paginated blog listing - ports `app/blog/page/[slug]/page.js` and `app/page/[slug]/page.js`."""

import from ..Pagination { Pagination }
import from ..Posts { Posts }
import from ..SeoMeta { SeoMeta }
import from ...lib.site { PAGINATION }

sv import from ...server.content { Doc, list_authors, list_posts }

def:pub BlogView(current_page: int = 1, heading: str = "") -> JsxElement {
    has posts: list[Doc] = [],
        authors: list[Doc] = [];

    async can with entry {
        posts = await list_posts();
        authors = await list_authors();
    }

    total_pages = (len(posts) + PAGINATION - 1) // PAGINATION;
    last_index = current_page * PAGINATION;
    first_index = last_index - PAGINATION;
    current_posts = posts[first_index:last_index];

    return <>
        <SeoMeta title={heading if heading else "Blogs"} />
        <section className="section">
            <div className="container">
                {if heading {
                    <h1 key="heading" className="text-4xl font-bold text-center mb-12">{heading}</h1>
                }}
                <Posts className="mb-16" posts={current_posts} authors={authors} />
                <Pagination total_pages={total_pages} current_page={current_page} />
            </div>
        </section>
    </>;
}
