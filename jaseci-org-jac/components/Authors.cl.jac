"""Author grid - ports `layouts/partials/Authors.js`."""

import from "@jac/runtime" { Link }
import from .Markdownify { Markdownify }

sv import from ..server.content { Doc }

def:pub Authors(authors: list[Doc]) -> JsxElement {
    return <div className="row justify-center">
        {for (i, author) in enumerate(authors) {
            <div className="col-12 mb-8 sm:col-6 md:col-4" key={"key-" + str(i)}>
                {if author.frontmatter.image {
                    <div key="avatar" className="flex justify-center items-center mb-4">
                        <img
                            src={author.frontmatter.image}
                            alt={author.frontmatter.title}
                            height={150}
                            width={150}
                            className="rounded-lg"
                        />
                    </div>
                }}
                <h3 className="h4 mb-2">
                    <Link to={"/authors/" + author.slug} className="block hover:text-primary">
                        {author.frontmatter.title}
                    </Link>
                </h3>
                {if author.content {
                    <Markdownify key="excerpt" as_="p" html={author.excerpt_html} />
                }}
            </div>
        }}
    </div>;
}
