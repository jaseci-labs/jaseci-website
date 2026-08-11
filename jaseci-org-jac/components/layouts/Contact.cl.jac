"""Contact layout - ports `layouts/Contact.js`."""

import from ...lib.site { CONTACT_FORM_ACTION }

sv import from ...server.content { Doc }

def:pub Contact(data: Doc) -> JsxElement {
    return <section className="section">
        <div className="container max-w-[700px]">
            <h1 className="h2 mb-8 text-center">{unsafe_html(data.title_html)}</h1>
            <form className="contact-form" method="POST" action={CONTACT_FORM_ACTION}>
                <div className="mb-6">
                    <label className="mb-2 block" htmlFor="name">
                        Name
                    </label>
                    <input className="form-input w-full" name="name" type="text" required />
                </div>
                <div className="mb-6">
                    <label className="mb-2 block" htmlFor="email">
                        Email
                    </label>
                    <input className="form-input w-full" name="email" type="email" required />
                </div>
                <div className="mb-6">
                    <label className="mb-2 block" htmlFor="subject">
                        Subject
                    </label>
                    <input className="form-input w-full" name="subject" type="text" required />
                </div>
                <div className="mb-6">
                    <label className="mb-2 block" htmlFor="message">
                        Message
                    </label>
                    <textarea className="form-textarea w-full" rows={7} />
                </div>
                <button className="btn btn-outline-primary">Submit Now</button>
            </form>
        </div>
    </section>;
}
