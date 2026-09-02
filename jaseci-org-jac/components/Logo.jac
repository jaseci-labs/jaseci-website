"""Brand mark - ports `layouts/components/Logo.js`."""

import from "@jac/runtime" { Link }
import from ..lib.site { SITE_LOGO, SITE_LOGO_HEIGHT, SITE_LOGO_TEXT, SITE_LOGO_WIDTH, SITE_TITLE }

def:pub Logo(src: str = "") -> JsxElement {
    source = src if src else SITE_LOGO;
    return <Link to="/" className="navbar-brand block">
        {if source {
            <img
                key="logo-image"
                src={source}
                alt={SITE_TITLE}
                width={SITE_LOGO_WIDTH}
                height={SITE_LOGO_HEIGHT}
                style={{
                    "height": str(SITE_LOGO_HEIGHT) + "px",
                    "width": str(SITE_LOGO_WIDTH) + "px"
                }}
            />
        } else {
            <span key="logo-text">{SITE_LOGO_TEXT}</span>
        }}
    </Link>;
}
