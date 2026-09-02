"""jaseci.org - entry point.

Server endpoints are imported here so they register at `/function/<name>`;
the client half is the `app` shell that wraps the file-based router.
"""

import from content {
    Doc, Frontmatter, SocialLink, RegularPage, GithubStats,
    list_posts, list_authors, authors_index, not_found_page, get_author,
    get_regular_page, taxonomy, posts_by_taxonomy, search_posts,
    similar_posts, github_stats, slugify, humanize, plainify
}

import "./assets/global.css";

def:pub app(children: any) -> JsxElement {
    return <>{children}</>;
}
