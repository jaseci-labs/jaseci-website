"""`/tags/:tag`."""

import from ...components.views.TaxonomyPostsView { TaxonomyPostsView }

def:pub TagPage() -> JsxPage {
    return <TaxonomyPostsView name="tags" param="tag" noun="tag" />;
}
