"""Default page layout - ports `layouts/Default.js`."""

import from ..MDXContent { MDXContent }

sv import from ...server.content { Doc }

def:pub Default(data: Doc) -> JsxElement {
    return <section className="section">
        <div className="container">
            <h1 className="h2 mb-8 text-center">{unsafe_html(data.title_html)}</h1>
            <div className="content">
                <MDXContent html={data.html} />
            </div>
        </div>
    </section>;
}
