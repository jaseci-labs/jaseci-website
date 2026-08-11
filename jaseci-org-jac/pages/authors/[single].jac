"""`/authors/:single`."""

import from ...components.views.AuthorView { AuthorView }

def:pub AuthorPage() -> JsxPage {
    return <AuthorView />;
}
