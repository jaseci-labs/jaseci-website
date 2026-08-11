"""`/authors`."""

import from ...components.views.AuthorsView { AuthorsView }

def:pub AuthorsIndexPage() -> JsxPage {
    return <AuthorsView current_page={1} />;
}
