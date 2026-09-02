"""Markdown body - ports `layouts/partials/MDXContent.js`.

The server pre-renders markdown to HTML (`Doc.html`); this component injects
it and runs highlight.js over the code blocks, which is what `rehype-highlight`
did at build time on the Next.js site.

The HTML is assigned to the container's `innerHTML` rather than rendered
through `unsafe_html()`, because the latter nests everything inside a `<span>`.
MDX left the markdown elements as *direct* children of `.content`, and `prose`
styles several things with direct-child selectors, so the nesting matters.
"""

import from "highlight.js" { HighlightJS }

def:pub MDXContent(html: str, className: str = "") -> JsxElement {
    has hostRef: Ref[HTMLDivElement] = Ref();

    can with [html] entry {
        host: any = hostRef.current;
        if host {
            host.innerHTML = html;
            blocks = host.querySelectorAll("pre code");
            blocks.forEach(lambda (block: any) { HighlightJS.highlightElement(block); });
        }
    }

    return <div ref={hostRef} className={className}></div>;
}
