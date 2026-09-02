"""Catch-all 404 - ports `app/not-found.js`."""

import from ..SeoMeta { SeoMeta }
import from ..layouts.NotFound { NotFound }

import from content { Doc, not_found_page }

def:pub NotFoundView() -> JsxElement {
    has page: Doc | None = None;

    async can with entry {
        page = await not_found_page();
    }

    return
        <>
            <SeoMeta/>
            {if page is not None {
                <NotFound key="notfound" data={page}/>
            }}
        </>;
}
