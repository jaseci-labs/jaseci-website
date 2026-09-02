"""Google Analytics - ports `app/Analytics.js` and the gtag snippet in `app/layout.js`."""

import from "@jac/runtime" { useLocation }
import from ..lib.site { GA_MEASUREMENT_ID }
import from ..lib.dom { by_id, create, head, win }

"""The gtag property loaded by the page (kept separate from the pageview id,
exactly as the Next.js site had it)."""
glob GA_TAG_ID: str = "G-B7JPCXKQ36";

def:pub Analytics() -> JsxElement {
    location = useLocation();

    can with entry {
        if not by_id("gtag-loader") {
            loader = create("script");
            loader.id = "gtag-loader";
            loader.`async = True;
            loader.src = "https://www.googletagmanager.com/gtag/js?id=" + GA_TAG_ID;
            head().appendChild(loader);

            boot = create("script");
            boot.text = "window.dataLayer = window.dataLayer || [];function gtag(){dataLayer.push(arguments);}gtag('js', new Date());gtag('config', '" + GA_TAG_ID + "', { send_page_view: false });";
            head().appendChild(boot);
        }
    }

    can with [location.pathname] entry {
        browser = win();
        if browser.gtag {
            browser.gtag("config", GA_MEASUREMENT_ID, {"page_path": location.pathname});
        }
    }

    return <>{#* analytics has no visual output *#}</>;
}
