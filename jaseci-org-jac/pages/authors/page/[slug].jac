"""`/authors/page/:slug`."""

import from "@jac/runtime" { useParams }
import from ....components.views.AuthorsView { AuthorsView }

def:pub AuthorsPaginationPage() -> JsxPage {
    params = useParams();
    raw = params["slug"];
    current: int = int(raw as str) if raw else 1;
    return <AuthorsView current_page={current} />;
}
