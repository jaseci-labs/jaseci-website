"""Markdown body - ports `layouts/partials/MDXContent.js`.

The server pre-renders markdown to HTML (`Doc.html`); this component injects
it and runs highlight.js over the code blocks, which is what `rehype-highlight`
did at build time on the Next.js site.
"""

import from "highlight.js" { HighlightJS }

def:pub MDXContent(html: str) -> JsxElement {
    has hostRef: Ref[HTMLDivElement] = Ref();

    can with [html] entry {
        host: any = hostRef.current;
        if host {
            blocks = host.querySelectorAll("pre code");
            blocks.forEach(lambda (block: any) { HighlightJS.highlightElement(block); });
        }
    }

    return <div ref={hostRef}>{unsafe_html(html)}</div>;
}
