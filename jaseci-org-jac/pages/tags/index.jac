"""`/tags`."""

import from ...components.views.TaxonomyListView { TaxonomyListView }

def:pub TagsPage() -> JsxPage {
    return <TaxonomyListView name="tags" title="Tags" />;
}
