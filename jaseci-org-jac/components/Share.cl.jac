"""Share buttons - ports `layouts/components/Share.js`."""

import from "react-icons/io5" { IoLogoFacebook, IoLogoLinkedin, IoLogoPinterest, IoLogoTwitter }
import from ..lib.site { SITE_BASE_URL }

def:pub Share(title: str, description: str, slug: str, className: str = "") -> JsxElement {
    base = SITE_BASE_URL;
    return <ul className={className}>
        <li className="inline-block">
            <a
                aria-label="facebook share button"
                href={"https://facebook.com/sharer/sharer.php?u=" + base + "/" + slug}
                target="_blank"
                rel="noreferrer noopener"
            >
                <IoLogoFacebook />
            </a>
        </li>
        <li className="inline-block">
            <a
                aria-label="twitter share button"
                href={"https://twitter.com/intent/tweet/?text=" + title + "&url=" + base + "/" + slug}
                target="_blank"
                rel="noreferrer noopener"
            >
                <IoLogoTwitter />
            </a>
        </li>
        <li className="inline-block">
            <a
                aria-label="linkedin share button"
                href={"https://www.linkedin.com/shareArticle?mini=true&url=" + base + "/" + slug + "&title=" + title + "&summary=" + description + "&source=" + base}
                target="_blank"
                rel="noreferrer noopener"
            >
                <IoLogoLinkedin />
            </a>
        </li>
        <li className="inline-block">
            <a
                aria-label="pinterest share button"
                href={"https://pinterest.com/pin/create/button/?url=" + base + "/" + slug + "&media=&description=" + description}
                target="_blank"
                rel="noreferrer noopener"
            >
                <IoLogoPinterest />
            </a>
        </li>
    </ul>;
}
