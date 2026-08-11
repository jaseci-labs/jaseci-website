"""`/blog` - page one of the blog listing."""

import from ...components.views.BlogView { BlogView }

def:pub BlogIndexPage() -> JsxPage {
    return <BlogView current_page={1} heading="Our Blog" />;
}
