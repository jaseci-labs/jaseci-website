"""`/categories`."""

import from ...components.views.TaxonomyListView { TaxonomyListView }

def:pub CategoriesPage() -> JsxPage {
    return <TaxonomyListView name="categories" title="Categories" />;
}
