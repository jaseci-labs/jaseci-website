"""About layout - ports `layouts/About.js`."""

import from ..MDXContent { MDXContent }
import from ..Markdownify { Markdownify }
import from ..Social { Social }

sv import from ...server.content { Doc }

def:pub About(data: Doc) -> JsxElement {
    return <section className="section">
        <div className="container text-center">
            {if data.frontmatter.image {
                <div key="cover" className="img-cover mb-8">
                    <img
                        src={data.frontmatter.image}
                        width={920}
                        height={515}
                        alt={data.frontmatter.title}
                        className="rounded-lg"
                    />
                </div>
            }}
            <Markdownify as_="h1" className="h2" html={data.title_html} />
            <Social source={data.frontmatter.social} className="social-icons-simple my-8" />

            <MDXContent className="content" html={data.html} />
        </div>
    </section>;
}
