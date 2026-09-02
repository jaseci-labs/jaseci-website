"""Related posts - ports `layouts/partials/SimilarPosts.js`."""

import from "@jac/runtime" { Link }
import from ..lib.site { humanize, slugify }

import from content { Doc }

def:pub SimilarPosts(posts: list[Doc]) -> JsxElement {
    return
        <div className="row justify-center">
            {for (i, post) in enumerate(posts) {
                <div key={"key-" + str(i)} className="col-12 mb-4 sm:col-4">
                    {if post.frontmatter.image {
                        <img
                            key="cover"
                            className="rounded-lg"
                            src={post.frontmatter.image}
                            alt={post.frontmatter.title}
                            width={445}
                            height={230}
                        />
                    }}
                    <ul className="mt-4 text-text">
                        <li className="mb-2 mr-4 inline-block">
                            {post.frontmatter.date_display}
                        </li>
                        <li className="mb-2 mr-4 inline-block">
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
                    </ul>
                    <h3 className="h4">
                        <Link to={"/" + post.slug} className="block hover:text-primary">
                            {post.frontmatter.title}
                        </Link>
                    </h3>
                </div>
            }}
        </div>;
}
