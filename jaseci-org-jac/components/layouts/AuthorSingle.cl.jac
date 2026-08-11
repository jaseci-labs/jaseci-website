"""Author profile layout - ports `layouts/AuthorSingle.js`."""

import from ..MDXContent { MDXContent }
import from ..Social { Social }
import from ..SeoMeta { SeoMeta }

sv import from ...server.content { Doc }

def:pub AuthorSingle(author: Doc) -> JsxElement {
    fm = author.frontmatter;
    description = fm.description if fm.description else author.content[:120];

    return <>
        <SeoMeta title={fm.title} description={description} />
        <section className="section">
            <div className="container">
                <div className="mb-4 text-center md:px-24">
                    {if fm.image {
                        <div key="avatar" className="mb-8">
                            <img
                                src={fm.image}
                                className="mx-auto rounded-lg"
                                height={150}
                                width={150}
                                alt={fm.title}
                            />
                        </div>
                    }}
                    <h1 className="h2 mb-8">{unsafe_html(author.title_html)}</h1>
                    <Social source={fm.social} className="social-icons-simple" />
                    <div className="content">
                        <MDXContent html={author.html} />
                    </div>
                </div>
            </div>
        </section>
    </>;
}
