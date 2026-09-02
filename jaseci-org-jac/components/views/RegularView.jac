"""`/[regular]` - ports `app/[regular]/page.js`.

Resolves a slug to a blog post or a standalone page and picks the layout
named in the page's front matter.
"""

import from "@jac/runtime" { useParams }
import from ..SeoMeta { SeoMeta }
import from ..layouts.About { About }
import from ..layouts.Contact { Contact }
import from ..layouts.Default { Default }
import from ..layouts.NotFound { NotFound }
import from ..layouts.PostSingle { PostSingle }

import from content {
    Doc,
    Frontmatter,
    get_regular_page,
    list_authors,
    similar_posts
}

def:pub RegularView() -> JsxElement {
    has page: Doc | None = None,
        is_post: bool = False,
        authors: list[Doc] = [],
        similar: list[Doc] = [];

    params = useParams();
    raw_slug = params["regular"];
    slug: str = (raw_slug as str) if raw_slug else "";

    async can with [slug] entry {
        if slug {
            resolved = await get_regular_page(slug);
            page = resolved.doc;
            is_post = resolved.is_post;
            authors = await list_authors();
            similar = await similar_posts(slug);
        }
    }

    return
        <>
            {if page is None {
                skip;
            }}
            {if page is not None {
                <SeoMeta
                    key="seo"
                    title={page.frontmatter.title}
                    description={page.frontmatter.description
                        if page.frontmatter.description
                        else page.content[:120]}
                    meta_title={page.frontmatter.meta_title}
                    image={page.frontmatter.image}
                    noindex={page.frontmatter.noindex}
                    canonical={page.frontmatter.canonical}
                />
            }}
            {if page is not None and is_post {
                <PostSingle key="body" post={page} authors={authors} similar={similar}/>
            } elif page is not None and page.frontmatter.layout == "404" {
                <NotFound key="body" data={page}/>
            } elif page is not None and page.frontmatter.layout == "about" {
                <About key="body" data={page}/>
            } elif page is not None and page.frontmatter.layout == "contact" {
                <Contact key="body" data={page}/>
            } elif page is not None {
                <Default key="body" data={page}/>
            }    }
        </>;
}
