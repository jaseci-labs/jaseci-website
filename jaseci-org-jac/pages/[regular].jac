"""`/:regular` - blog posts and standalone markdown pages."""

import from ..components.views.RegularView { RegularView }

def:pub RegularPage() -> JsxPage {
    return <RegularView />;
}
