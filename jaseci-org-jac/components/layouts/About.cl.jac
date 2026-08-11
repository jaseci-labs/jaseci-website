"""About layout - ports `layouts/About.js`."""

import from ..MDXContent { MDXContent }
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
            <h1 className="h2">{unsafe_html(data.title_html)}</h1>
            <Social source={data.frontmatter.social} className="social-icons-simple my-8" />

            <div className="content">
                <MDXContent html={data.html} />
            </div>
        </div>
    </section>;
}
