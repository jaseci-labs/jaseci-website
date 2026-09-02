"""`/page/:slug` - the un-headed blog listing kept from the Next.js routes."""

import from "@jac/runtime" { useParams }
import from ...components.views.BlogView { BlogView }

def:pub PagePaginationPage() -> JsxPage {
    params = useParams();
    raw = params["slug"];
    current: int = int(raw as str) if raw else 1;
    return <BlogView current_page={current} />;
}
