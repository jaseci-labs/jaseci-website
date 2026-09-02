"""`/blog` - page one of the blog listing.

`app/blog/page.js` re-exported `app/page/[slug]/page.js`, so this route has
no heading and the "Blogs" title - not the "Our Blog" variant.
"""

import from ...components.views.BlogView { BlogView }

def:pub BlogIndexPage() -> JsxPage {
    return <BlogView current_page={1} />;
}
