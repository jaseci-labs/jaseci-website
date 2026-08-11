"""Port of `markdownify(content, tag, className)` from `lib/utils/textConverter.js`.

The original rendered `<Tag className=... dangerouslySetInnerHTML={...} />`, so
the parsed markdown landed *directly* inside the tag. `unsafe_html()` would nest
it in an extra `<span>`, so assign `innerHTML` through a ref instead.
"""

def:pub Markdownify(html: str, as_: str = "span", className: str = "") -> JsxElement {
    has hostRef: Ref[HTMLElement] = Ref();

    can with [html] entry {
        host: any = hostRef.current;
        if host {
            host.innerHTML = html;
        }
    }

    return <@as_ ref={hostRef} className={className}></@as_>;
}
