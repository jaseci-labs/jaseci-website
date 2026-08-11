"""`/blog/page/:slug` - later pages of the blog listing."""

import from "@jac/runtime" { useParams }
import from ....components.views.BlogView { BlogView }

def:pub BlogPaginationPage() -> JsxPage {
    params = useParams();
    raw = params["slug"];
    current: int = int(raw as str) if raw else 1;
    return <BlogView current_page={current} heading="Our Blog" />;
}
