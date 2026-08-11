"""Default page layout - ports `layouts/Default.js`."""

import from ..MDXContent { MDXContent }
import from ..Markdownify { Markdownify }

sv import from ...server.content { Doc }

def:pub Default(data: Doc) -> JsxElement {
    return <section className="section">
        <div className="container">
            <Markdownify as_="h1" className="h2 mb-8 text-center" html={data.title_html} />
            <MDXContent className="content" html={data.html} />
        </div>
    </section>;
}
