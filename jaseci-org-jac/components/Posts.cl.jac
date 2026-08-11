"""Post list - ports `layouts/partials/Posts.js`."""

import from "@jac/runtime" { Link }
import from ..lib.site { humanize, slugify, summarize }

sv import from ..server.content { Doc }

"""The author profiles credited on a post (matched by slugified title)."""
def:pub authors_for(post: Doc, authors: list[Doc]) -> list[Doc] {
    wanted = [slugify(name) for name in post.frontmatter.authors];
    return [a for a in authors if slugify(a.frontmatter.title) in wanted];
}

def:pub PostMeta(post: Doc, authors: list[Doc]) -> JsxElement {
    return <ul className="mb-4 mt-4 flex flex-wrap items-center space-x-3 text-text">
        <li>
            {for author in authors_for(post, authors) {
                <Link
                    key={author.slug}
                    to={"/authors/" + slugify(author.frontmatter.title)}
                    className="flex items-center hover:text-primary"
                >
                    {if author.frontmatter.image {
                        <img
                            key="avatar"
                            src={author.frontmatter.image}
                            alt={author.frontmatter.title}
                            height={50}
                            width={50}
                            className="mr-2 h-6 w-6 rounded-full"
                        />
                    }}
                    <span>{author.frontmatter.title}</span>
                </Link>
            }}
        </li>
        <li>{post.frontmatter.date_display}</li>
        <li>
            <ul>
                {for category in post.frontmatter.categories {
                    <li className="inline-block" key={category}>
                        <Link
                            to={"/categories/" + slugify(category)}
                            className="mr-3 hover:text-primary"
                        >
                            {"▣ " + humanize(category)}
                        </Link>
                    </li>
                }}
            </ul>
        </li>
    </ul>;
}

def:pub Posts(posts: list[Doc], authors: list[Doc], className: str = "") -> JsxElement {
    return <div className={"row space-y-16 " + className}>
        {for (i, post) in enumerate(posts) {
            <div key={"key-" + str(i)} className={"col-12" if i == 0 else "col-12 sm:col-6"}>
                {if post.frontmatter.image {
                    <div
                        key="cover"
                        className={
                            "relative w-full overflow-hidden rounded-lg "
                            + ("h-52 sm:h-64 md:h-72 lg:h-96 xl:h-[475px]" if i == 0
                               else "h-44 sm:h-48 md:h-56 lg:h-60 xl:h-[230px]")
                        }
                    >
                        <img
                            className="absolute inset-0 h-full w-full object-cover"
                            src={post.frontmatter.image}
                            alt={post.frontmatter.title}
                        />
                    </div>
                }}
                <PostMeta post={post} authors={authors} />
                <h3 className="mb-2">
                    <Link to={"/" + post.slug} className="block hover:text-primary">
                        {post.frontmatter.title}
                    </Link>
                </h3>
                <p className="text-text">
                    {summarize(post.content) + "..."}
                </p>
            </div>
        }}
    </div>;
}
