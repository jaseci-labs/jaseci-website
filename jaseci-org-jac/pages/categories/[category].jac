"""`/categories/:category`."""

import from ...components.views.TaxonomyPostsView { TaxonomyPostsView }

def:pub CategoryPage() -> JsxPage {
    return <TaxonomyPostsView name="categories" param="category" noun="category" />;
}
