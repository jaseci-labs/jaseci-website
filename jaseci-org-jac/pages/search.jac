"""`/search?key=...`."""

import from ..components.views.SearchView { SearchView }

def:pub SearchPage() -> JsxPage {
    return <SearchView />;
}
