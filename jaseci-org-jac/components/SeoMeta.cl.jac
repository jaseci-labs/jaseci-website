"""Per-page document head - ports `layouts/partials/SeoMeta.js`."""

import from "@jac/runtime" { useLocation }
import from ..lib.site { META_AUTHOR, META_DESCRIPTION, META_IMAGE, SITE_BASE_URL, SITE_TITLE }
import from ..lib.dom { create, doc, head, query }

"""Inline emphasis markers `marked.parseInline` turns into tags, which the
original `plainify()` then strips - so they disappear either way."""
glob INLINE_MARKERS: list[str] = ["***", "___", "**", "__", "~~", "*", "_", "`"];

glob HTML_ENTITIES: list[list[str]] = [
    ["&nbsp;", " "], ["&lt;", "<"], ["&gt;", ">"],
    ["&amp;", "&"], ["&quot;", '"'], ["&#39;", "'"]
];

def strip_markers(content: str) -> str {
    out = content;
    for marker in INLINE_MARKERS {
        out = "".join(out.split(marker));
    }
    return out;
}

def strip_tags(content: str) -> str {
    out = "";
    inside_tag = False;
    for ch in content {
        if ch == "<" {
            inside_tag = True;
            continue;
        }
        if ch == ">" {
            inside_tag = False;
            continue;
        }
        if not inside_tag {
            out = out + ch;
        }
    }
    return out;
}

"""Drop `[\\r\\n]\\s*[\\r\\n]` runs, the way the original regex did."""
def collapse_blank_lines(content: str) -> str {
    out = "";
    index = 0;
    length = len(content);
    while index < length {
        ch = content[index];
        if ch == "\n" or ch == "\r" {
            scan = index + 1;
            while scan < length and content[scan].isspace() and content[scan] != "\n" and content[scan] != "\r" {
                scan = scan + 1;
            }
            if scan < length and (content[scan] == "\n" or content[scan] == "\r") {
                index = scan + 1;
                continue;
            }
        }
        out = out + ch;
        index = index + 1;
    }
    return out;
}

"""Port of `plainify()` - inline-render, strip tags, collapse blank lines,
decode entities."""
def plainify(content: str) -> str {
    out = collapse_blank_lines(strip_tags(strip_markers(content)));
    for pair in HTML_ENTITIES {
        out = pair[1].join(out.split(pair[0]));
    }
    return out;
}

def upsert_meta(attribute: str, key: str, value: str) -> None {
    selector = "meta[" + attribute + '="' + key + '"]';
    element = query(selector);
    if not element {
        element = create("meta");
        element.setAttribute(attribute, key);
        head().appendChild(element);
    }
    element.setAttribute("content", value);
}

"""Set a meta tag when `present`, otherwise remove it."""
def upsert_meta_when(present: bool, attribute: str, key: str, value: str) -> None {
    if present {
        upsert_meta(attribute, key, value);
        return;
    }
    element = query("meta[" + attribute + '="' + key + '"]');
    if element {
        element.remove();
    }
}

"""JS `String.replace(str, "")` drops only the first match."""
def drop_first_slash(path: str) -> str {
    index = path.find("/");
    if index < 0 {
        return path;
    }
    return path[:index] + path[index + 1:];
}

def upsert_link(rel: str, href: str) -> None {
    selector = 'link[rel="' + rel + '"]';
    element = query(selector);
    if not href {
        if element {
            element.remove();
        }
        return;
    }
    if not element {
        element = create("link");
        element.setAttribute("rel", rel);
        head().appendChild(element);
    }
    element.setAttribute("href", href);
}

def:pub SeoMeta(
    title: str = "",
    meta_title: str = "",
    image: str = "",
    description: str = "",
    canonical: str = "",
    noindex: bool = False
) -> JsxElement {
    location = useLocation();

    can with (title, meta_title, image, description, canonical, noindex, location.pathname) entry {
        resolved_title = plainify(meta_title if meta_title else (title if title else SITE_TITLE));
        resolved_description = plainify(description if description else META_DESCRIPTION);
        resolved_image = SITE_BASE_URL + (image if image else META_IMAGE);
        # `${base_url}/${pathname.replace("/", "")}` on the old site: JS replaces
        # only the FIRST slash, and base_url is itself "/", so the value keeps
        # the leading double slash.
        page_url = SITE_BASE_URL + "/" + drop_first_slash(location.pathname);

        doc().title = resolved_title;
        upsert_link("canonical", canonical);
        upsert_meta_when(noindex, "name", "robots", "noindex,nofollow");
        upsert_meta("name", "description", resolved_description);
        upsert_meta("name", "author", META_AUTHOR);
        upsert_meta("property", "og:title", resolved_title);
        upsert_meta("property", "og:description", resolved_description);
        upsert_meta("property", "og:type", "website");
        upsert_meta("property", "og:url", page_url);
        upsert_meta("name", "twitter:title", resolved_title);
        upsert_meta("name", "twitter:description", resolved_description);
        upsert_meta("property", "og:image", resolved_image);
        upsert_meta("name", "twitter:image", resolved_image);
        upsert_meta("name", "twitter:card", "summary_large_image");
    }

    return <>{#* head-only component *#}</>;
}
