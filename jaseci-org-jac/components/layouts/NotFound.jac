"""404 layout - ports `layouts/404.js`."""

import from ..MDXContent { MDXContent }

import from content { Doc }

def:pub NotFound(data: Doc) -> JsxElement {
    return
        <section className="section">
            <div className="container">
                <div className="flex h-[40vh] items-center justify-center">
                    <div className="text-center">
                        <h1 className="mb-4">{data.frontmatter.title}</h1>
                        <MDXContent
                            className="content prose-headings:text-text"
                            html={data.html}
                        />
                    </div>
                </div>
            </div>
        </section>;
}
