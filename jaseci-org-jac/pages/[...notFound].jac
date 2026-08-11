"""Catch-all 404."""

import from ..components.views.NotFoundView { NotFoundView }

def:pub NotFoundPage() -> JsxPage {
    return <NotFoundView />;
}
