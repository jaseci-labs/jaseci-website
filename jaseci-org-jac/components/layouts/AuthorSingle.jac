"""Author profile layout - ports `layouts/AuthorSingle.js`."""

import from ..MDXContent { MDXContent }
import from ..Markdownify { Markdownify }
import from ..Social { Social }
import from ..SeoMeta { SeoMeta }

import from content { Doc }

def:pub AuthorSingle(author: Doc) -> JsxElement {
    fm = author.frontmatter;
    description = fm.description if fm.description else author.content[:120];

    return
        <>
            <SeoMeta title={fm.title} description={description}/>
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
                        <Markdownify
                            as_="h1"
                            className="h2 mb-8"
                            html={author.title_html}
                        />
                        <Social source={fm.social} className="social-icons-simple"/>
                        <MDXContent className="content" html={author.html}/>
                    </div>
                </div>
            </section>
        </>;
}
