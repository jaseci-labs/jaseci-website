"""Per-page document head - ports `layouts/partials/SeoMeta.js`."""

import from "@jac/runtime" { useLocation }
import from ..lib.site { META_AUTHOR, META_DESCRIPTION, META_IMAGE, SITE_BASE_URL, SITE_TITLE }
import from ..lib.dom { create, doc, head, query }

"""Strip markdown/HTML from a value destined for a meta tag."""
def plainify(content: str) -> str {
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
        page_url = SITE_BASE_URL + location.pathname.replace("/", "");

        doc().title = resolved_title;
        upsert_link("canonical", canonical);
        upsert_meta("name", "robots", "noindex,nofollow" if noindex else "index,follow");
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
