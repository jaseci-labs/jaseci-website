"""Blog post layout - ports `layouts/PostSingle.js`."""

import from "@jac/runtime" { Link }
import from ..MDXContent { MDXContent }
import from ..Markdownify { Markdownify }
import from ..Share { Share }
import from ..SimilarPosts { SimilarPosts }
import from ..Posts { authors_for }
import from ...lib.site { humanize, slugify }

import from content { Doc }

def:pub PostSingle(post: Doc, authors: list[Doc], similar: list[Doc]) -> JsxElement {
    fm = post.frontmatter;
    description = fm.description if fm.description else post.content[:120];

    return
        <>
            <section className="section">
                <div className="container">
                    <article className="text-center">
                        <Markdownify as_="h1" className="h2" html={post.title_html}/>
                        <ul
                            className="mb-8 mt-4 flex flex-wrap items-center justify-center space-x-3 text-text"
                        >
                            <li>
                                {for author in authors_for(post, authors) {
                                    <Link
                                        to={"/authors/"
                                            + slugify(author.frontmatter.title)}
                                        key={author.slug}
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
                            <li>{fm.date_display}</li>
                            <li>
                                <ul>
                                    {for category in fm.categories {
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
                        {if fm.image {
                            <img
                                key="cover"
                                src={fm.image}
                                height={500}
                                width={1000}
                                alt={fm.title}
                                className="rounded-lg"
                            />
                        }}
                        <MDXContent
                            className="content mb-16 text-justify"
                            html={post.html}
                        />
                        <div className="flex flex-wrap items-center justify-between">
                            <ul className="mb-4 mr-4 space-x-3">
                                {for tag in fm.tags {
                                    <li className="inline-block" key={tag}>
                                        <Link
                                            to={"/tags/" + slugify(tag)}
                                            className="block rounded-lg bg-theme-light px-4 py-2 font-semibold text-dark hover:text-primary"
                                        >
                                            {"#" + humanize(tag)}
                                        </Link>
                                    </li>
                                }}
                            </ul>
                            <Share
                                className="social-share mb-4"
                                title={fm.title}
                                description={description}
                                slug={post.slug}
                            />
                        </div>
                    </article>
                </div>
            </section>
            {if len(similar) > 0 {
                <section key="similar" className="section">
                    <div className="container">
                        <h2 className="mb-8 text-center">Similar Posts</h2>
                        <SimilarPosts posts={similar[:3]}/>
                    </div>
                </section>
            }}
        </>;
}
