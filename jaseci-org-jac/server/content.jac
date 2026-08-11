"""Content layer for jaseci.org.

Replaces the Next.js `lib/contentParser.js`, `lib/taxonomyParser.js`,
`lib/jsonGenerator.js` and `lib/utils/*` helpers. Markdown under `content/`
is parsed once at server start and served to the client as typed objects.
"""

import os;
import re;
import json;
import yaml;
import markdown;
import urllib.request as urlrequest;
import from datetime { datetime, timezone }
import from zoneinfo { ZoneInfo }

# ---------------------------------------------------------------------------
# Settings (config/config.json -> settings)
# ---------------------------------------------------------------------------

glob BLOG_FOLDER: str = "posts";
glob SUMMARY_LENGTH: int = 200;

glob PROJECT_ROOT: str = os.path.dirname(os.path.dirname(os.path.abspath(__file__)));
glob CONTENT_ROOT: str = os.path.join(PROJECT_ROOT, "content");

"""github-slugger strips this punctuation class before hyphenating spaces."""
glob SLUG_STRIP: str = "\\'!\"#$%&()*+,./:;<=>?@[]^`{|}~";

"""Rendering order mirrors layouts/components/Social.js."""
glob SOCIAL_ORDER: list[str] = [
    "facebook", "twitter", "instagram", "youtube", "linkedin", "github",
    "gitlab", "medium", "codepen", "bitbucket", "dribbble", "behance",
    "pinterest", "soundcloud", "tumblr", "reddit", "vk", "whatsapp",
    "snapchat", "vimeo", "tiktok", "foursquare", "skype", "website",
    "rss", "email", "phone", "address"
];

# ---------------------------------------------------------------------------
# Wire types
# ---------------------------------------------------------------------------

obj SocialLink {
    has kind: str = "",
        url: str = "";
}

obj Frontmatter {
    has title: str = "",
        meta_title: str = "",
        description: str = "",
        date: str = "",
        date_display: str = "",
        image: str = "",
        layout: str = "",
        canonical: str = "",
        noindex: bool = False,
        draft: bool = False,
        categories: list[str] = [],
        tags: list[str] = [],
        authors: list[str] = [],
        social: list[SocialLink] = [];
}

"""A parsed markdown document: frontmatter plus pre-rendered HTML."""
obj Doc {
    has frontmatter: Frontmatter;
    has slug: str = "",
        content: str = "",
        html: str = "",
        title_html: str = "",
        summary: str = "",
        excerpt_html: str = "";
}

"""`/[regular]` resolves to either a blog post or a standalone page."""
obj RegularPage {
    has doc: Doc;
    has is_post: bool = False;
}

obj GithubStats {
    has stars: str = "--",
        forks: str = "--",
        last_updated: str = "";
}

# ---------------------------------------------------------------------------
# Text helpers (lib/utils/textConverter.js)
# ---------------------------------------------------------------------------

"""Port of github-slugger's `slug()` as used by the Next.js site."""
def:pub slugify(content: str) -> str {
    lowered = content.lower();
    kept = [ch for ch in lowered if ch not in SLUG_STRIP];
    return "".join(kept).replace(" ", "-");
}

"""Port of `humanize()` - trim underscores/space runs and capitalise."""
def:pub humanize(content: str) -> str {
    trimmed = re.sub(r"^[\s_]+|[\s_]+$", "", content);
    spaced = re.sub(r"[_\s]+", " ", trimmed);
    if spaced and spaced[0].islower() {
        return spaced[0].upper() + spaced[1:];
    }
    return spaced;
}

"""`pymdownx.tilde` supplies GFM strikethrough; `md_in_html` lets markdown
inside raw HTML blocks render the way MDX did on the Next.js site."""
glob BLOCK_EXTENSIONS: list[str] = ["extra", "sane_lists", "md_in_html", "pymdownx.tilde"];

"""Containers whose children should still be parsed as markdown."""
glob MD_CONTAINERS: str = "dl|ol|ul|div|section|article|aside|details|table|thead|tbody|tr";

"""Leaves whose contents are inline markdown (no wrapping `<p>`)."""
glob MD_LEAVES: str = "dt|dd|td|th|li|figcaption|summary|p";

"""MDX parsed markdown inside raw HTML; Python-Markdown needs to be told to.

`md_in_html` only descends into elements carrying a `markdown` attribute, so
annotate block containers with `markdown="1"` and inline leaves with
`markdown="span"` before conversion.
"""
def mark_html_blocks(text: str) -> str {
    containers = re.sub(r"<(" + MD_CONTAINERS + r")(?=[\s>])", r'<\1 markdown="1"', text);
    return re.sub(r"<(" + MD_LEAVES + r")(?=[\s>])", r'<\1 markdown="span"', containers);
}

"""Block-level markdown -> HTML, with image paths pointed at `/assets`."""
def render_block(text: str) -> str {
    if not text {
        return "";
    }
    html = markdown.markdown(mark_html_blocks(text), extensions=BLOCK_EXTENSIONS);
    return html.replace('src="/images/', 'src="/assets/images/');
}

"""Inline markdown -> HTML (the `marked.parseInline` equivalent)."""
def render_inline(text: str) -> str {
    if not text {
        return "";
    }
    html = markdown.markdown(text, extensions=["extra", "pymdownx.tilde"]).strip();
    if html.startswith("<p>") and html.endswith("</p>") {
        return html[3:-4];
    }
    return html;
}

"""Rewrite authored `/images/...` paths onto the `assets/` dir jac serves."""
def:pub asset_path(raw: str) -> str {
    if raw.startswith("/images/") {
        return "/assets" + raw;
    }
    return raw;
}

def strip_tags(text: str) -> str {
    return re.sub(r"<\/?[^>]+(>|$)", "", text);
}

"""Port of `plainify()` - inline-render, drop tags, decode entities."""
def:pub plainify(content: str) -> str {
    stripped = strip_tags(render_inline(content));
    collapsed = re.sub(r"[\r\n]\s*[\r\n]", "", stripped);
    entities = {
        "&nbsp;": " ", "&lt;": "<", "&gt;": ">",
        "&amp;": "&", "&quot;": '"', "&#39;": "'"
    };
    for (entity, char) in entities.items() {
        collapsed = collapsed.replace(entity, char);
    }
    return collapsed;
}

"""`dd MMM yyyy` in America/New_York, matching date-fns-tz on the old site.

Unquoted YAML dates were read by gray-matter as UTC midnight, so a
`2023-04-04` front-matter date renders as `03 Apr 2023`.
"""
def format_date(raw: any) -> str {
    if not raw {
        return "";
    }
    moment: any = None;
    if isinstance(raw, datetime) {
        moment = raw if raw.tzinfo else raw.replace(tzinfo=timezone.utc);
    } else {
        try {
            moment = datetime.fromisoformat(str(raw)).replace(tzinfo=timezone.utc);
        } except ValueError {
            return str(raw);
        }
    }
    local = moment.astimezone(ZoneInfo("America/New_York"));
    return local.strftime("%d %b %Y");
}

def iso_date(raw: any) -> str {
    if not raw {
        return "";
    }
    if isinstance(raw, datetime) {
        return raw.isoformat();
    }
    return str(raw);
}

# ---------------------------------------------------------------------------
# Markdown parsing
# ---------------------------------------------------------------------------

"""Split a `---`-delimited markdown file into its frontmatter and body."""
def split_frontmatter(source: str) -> tuple[dict[str, any], str] {
    if not source.startswith("---") {
        return ({}, source);
    }
    parts = source.split("---", 2);
    if len(parts) < 3 {
        return ({}, source);
    }
    data = yaml.safe_load(parts[1]) or {};
    # gray-matter consumes only the newline that ends the closing `---` line,
    # so the body keeps one leading newline - and that newline counts toward
    # the 200-character post summaries.
    body = parts[2][1:] if parts[2].startswith("\n") else parts[2];
    return (data, body);
}

def build_social(raw: any) -> list[SocialLink] {
    links: list[SocialLink] = [];
    if not isinstance(raw, dict) {
        return links;
    }
    for key in SOCIAL_ORDER {
        value = raw.get(key);
        if value {
            links.append(SocialLink(kind=key, url=str(value)));
        }
    }
    return links;
}

def build_frontmatter(data: dict[str, any]) -> Frontmatter {
    return Frontmatter(
        title=str(data.get("title") or ""),
        meta_title=str(data.get("meta_title") or ""),
        description=str(data.get("description") or ""),
        date=iso_date(data.get("date")),
        date_display=format_date(data.get("date")),
        image=asset_path(str(data.get("image") or "")),
        layout=str(data.get("layout") or ""),
        canonical=str(data.get("canonical") or ""),
        noindex=bool(data.get("noindex") or False),
        draft=bool(data.get("draft") or False),
        categories=[str(c) for c in (data.get("categories") or [])],
        tags=[str(t) for t in (data.get("tags") or [])],
        authors=[str(a) for a in (data.get("authors") or [])],
        social=build_social(data.get("social"))
    );
}

def parse_doc(path: str, filename: str) -> Doc {
    handle = open(path, "r", encoding="utf-8");
    source = handle.read();
    handle.close();
    (data, body) = split_frontmatter(source);
    frontmatter = build_frontmatter(data);
    stem = filename[:-3] if filename.endswith(".md") else filename;
    url = data.get("url");
    slug = str(url).replace("/", "") if url else stem;
    return Doc(
        frontmatter=frontmatter,
        slug=slug,
        content=body,
        html=render_block(body),
        title_html=render_inline(frontmatter.title),
        summary=body[:SUMMARY_LENGTH],
        excerpt_html=render_inline(body[:120])
    );
}

def by_date(doc: Doc) -> str {
    return doc.frontmatter.date;
}

"""Port of `getSinglePage()`: skip `_`-prefixed files, drafts and 404s."""
def read_folder(folder: str) -> list[Doc] {
    target = os.path.join(CONTENT_ROOT, folder) if folder else CONTENT_ROOT;
    if not os.path.isdir(target) {
        return [];
    }
    docs: list[Doc] = [];
    for filename in sorted(os.listdir(target)) {
        if ".md" not in filename or filename.startswith("_") {
            continue;
        }
        doc = parse_doc(os.path.join(target, filename), filename);
        if doc.frontmatter.draft or doc.frontmatter.layout == "404" {
            continue;
        }
        docs.append(doc);
    }
    return sorted(docs, key=by_date, reverse=True);
}

def read_single(folder: str, filename: str) -> Doc | None {
    target = os.path.join(CONTENT_ROOT, folder, filename) if folder else os.path.join(CONTENT_ROOT, filename);
    if not os.path.isfile(target) {
        return None;
    }
    return parse_doc(target, filename);
}

# ---------------------------------------------------------------------------
# Cached content graph (markdown is static, so parse once at boot)
# ---------------------------------------------------------------------------

glob POSTS: list[Doc] = read_folder(BLOG_FOLDER);
glob PAGES: list[Doc] = read_folder("");
glob AUTHORS: list[Doc] = read_folder("authors");
glob AUTHORS_INDEX: Doc | None = read_single("authors", "_index.md");
glob NOT_FOUND: Doc | None = read_single("", "404.md");

# ---------------------------------------------------------------------------
# Endpoints
# ---------------------------------------------------------------------------

"""Every published blog post, newest first."""
def:pub list_posts -> list[Doc] {
    return POSTS;
}

"""Every author profile in `content/authors`."""
def:pub list_authors -> list[Doc] {
    return AUTHORS;
}

"""`content/authors/_index.md` - the authors listing page."""
def:pub authors_index -> Doc {
    if AUTHORS_INDEX {
        return AUTHORS_INDEX;
    }
    return Doc(frontmatter=Frontmatter(title="Authors"));
}

"""`content/404.md`."""
def:pub not_found_page -> Doc {
    if NOT_FOUND {
        return NOT_FOUND;
    }
    return Doc(frontmatter=Frontmatter(title="Error 404"));
}

def:pub get_author(slug: str) -> Doc | None {
    for author in AUTHORS {
        if author.slug == slug {
            return author;
        }
    }
    return None;
}

"""Port of `getRegularPage()` - posts win, then standalone pages, then 404."""
def:pub get_regular_page(slug: str) -> RegularPage {
    for post in POSTS {
        if post.slug == slug {
            return RegularPage(doc=post, is_post=True);
        }
    }
    for page in PAGES {
        if page.slug == slug {
            return RegularPage(doc=page, is_post=False);
        }
    }
    return RegularPage(doc=not_found_page(), is_post=False);
}

"""Distinct slugified `categories` / `tags` across every post."""
def:pub taxonomy(name: str) -> list[str] {
    seen: list[str] = [];
    for post in POSTS {
        values = post.frontmatter.categories if name == "categories" else post.frontmatter.tags;
        for value in values {
            slug = slugify(value);
            if slug not in seen {
                seen.append(slug);
            }
        }
    }
    return seen;
}

def:pub posts_by_taxonomy(name: str, value: str) -> list[Doc] {
    matched: list[Doc] = [];
    for post in POSTS {
        values = post.frontmatter.categories if name == "categories" else post.frontmatter.tags;
        for candidate in values {
            if value in slugify(candidate) {
                matched.append(post);
                break;
            }
        }
    }
    return matched;
}

"""Port of `SearchResults` - match title, categories, tags or body."""
def:pub search_posts(key: str) -> list[Doc] {
    keyword = slugify(key or "");
    matched: list[Doc] = [];
    for post in POSTS {
        fm = post.frontmatter;
        hit = keyword in slugify(fm.title);
        if not hit {
            for category in fm.categories {
                if keyword in slugify(category) {
                    hit = True;
                    break;
                }
            }
        }
        if not hit {
            for tag in fm.tags {
                if keyword in slugify(tag) {
                    hit = True;
                    break;
                }
            }
        }
        if not hit and keyword in slugify(post.content) {
            hit = True;
        }
        if hit {
            matched.append(post);
        }
    }
    return matched;
}

"""Port of `lib/utils/similarItems.js` - shared category or tag, minus self."""
def:pub similar_posts(slug: str) -> list[Doc] {
    current: Doc | None = None;
    for post in POSTS {
        if post.slug == slug {
            current = post;
            break;
        }
    }
    if current is None {
        return [];
    }
    categories = current.frontmatter.categories;
    tags = current.frontmatter.tags;
    merged: list[Doc] = [];
    for post in POSTS {
        if post.slug == slug {
            continue;
        }
        shared = False;
        for category in categories {
            if category in post.frontmatter.categories {
                shared = True;
                break;
            }
        }
        if not shared {
            for tag in tags {
                if tag in post.frontmatter.tags {
                    shared = True;
                    break;
                }
            }
        }
        if shared {
            merged.append(post);
        }
    }
    return merged;
}

# ---------------------------------------------------------------------------
# GitHub stats (replaces app/api/github-stats/route.js)
# ---------------------------------------------------------------------------

glob GH_CACHE: GithubStats | None = None;
glob GH_FETCHED_AT: float = 0.0;
glob GH_CACHE_SECONDS: float = 300.0;

"""Star/fork counts for jaseci-labs/jaseci, cached for five minutes."""
def:pub github_stats -> GithubStats {
    now = datetime.now(timezone.utc).timestamp();
    if GH_CACHE is not None and (now - GH_FETCHED_AT) < GH_CACHE_SECONDS {
        return GH_CACHE;
    }
    try {
        request = urlrequest.Request(
            "https://api.github.com/repos/jaseci-labs/jaseci",
            headers={
                "Accept": "application/vnd.github.v3+json",
                "User-Agent": "jac-website"
            }
        );
        response = urlrequest.urlopen(request, timeout=10);
        payload = json.loads(response.read().decode("utf-8"));
        stats = GithubStats(
            stars=str(payload.get("stargazers_count", "--")),
            forks=str(payload.get("forks_count", "--")),
            last_updated=datetime.now(timezone.utc).isoformat()
        );
        GH_CACHE = stats;
        GH_FETCHED_AT = now;
        return stats;
    } except Exception {
        if GH_CACHE {
            return GH_CACHE;
        }
        return GithubStats();
    }
}
