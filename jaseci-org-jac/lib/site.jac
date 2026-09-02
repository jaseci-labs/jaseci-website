"""Site configuration and text helpers.

Ports `config/config.json`, `config/menu.json`, `config/social.json` and the
client half of `lib/utils/textConverter.js` into Jac.
"""

obj:pub MenuItem {
    has name: str = "",
        url: str = "",
        target: str = "",
        rel: str = "";
}

obj:pub SocialEntry {
    has kind: str = "",
        url: str = "";
}

# --- config/config.json -----------------------------------------------------

glob:pub SITE_TITLE: str = "Jac & Jaseci: The AI-First Programming Language";
glob:pub SITE_BASE_URL: str = "/";
glob:pub SITE_FAVICON: str = "/assets/images/favicon.ico";
glob:pub SITE_LOGO: str = "/assets/images/logo.png";
glob:pub SITE_LOGO_WIDTH: int = 32;
glob:pub SITE_LOGO_HEIGHT: int = 32;
glob:pub SITE_LOGO_TEXT: str = "Jac & Jaseci";

glob:pub PAGINATION: int = 7;
glob:pub SUMMARY_LENGTH: int = 200;

glob:pub CONTACT_FORM_ACTION: str = "#";
glob:pub COPYRIGHT: str = "Copyright © 2025 Jac Hackers Everywhere. All rights reserved.";

glob:pub META_AUTHOR: str = "Jaseci Labs";
glob:pub META_IMAGE: str = "/assets/images/og-image.png";
glob:pub META_DESCRIPTION: str = "The Jac programming language and Jaseci runtime stack replaces Python, JavaScript, and C/Zig/Rust with AI-first constructs, object spatial programming, and scale-native constructs — with full native compatibility for PyPI, npm, and C-ABI.";

glob:pub GA_MEASUREMENT_ID: str = "G-B7JPCXKQ36";

# --- config/menu.json -------------------------------------------------------

glob:pub MAIN_MENU: list[MenuItem] = [
    MenuItem(name="Docs", url="https://jaclang.org/"),
    MenuItem(name="Community", url="/community"),
    MenuItem(name="Built with Jaseci", url="/built-with-jaseci"),
    MenuItem(name="About Us", url="/about-us"),
    MenuItem(
        name="Research",
        url="https://jaseci.engin.umich.edu/",
        target="_blank",
        rel="noopener noreferrer"
    ),
    MenuItem(name="Blogs", url="https://blogs.jaseci.org/")
];

glob:pub FOOTER_MENU: list[MenuItem] = [
    MenuItem(name="About", url="/about"),
    MenuItem(name="Contact", url="/contact"),
    MenuItem(name="Elements", url="/elements"),
    MenuItem(name="Privacy Policy", url="/privacy-policy")
];

# --- config/social.json -----------------------------------------------------

glob:pub SITE_SOCIAL: list[SocialEntry] = [
    SocialEntry(kind="twitter", url="https://x.com/Jaseci_Labs"),
    SocialEntry(kind="linkedin", url="https://www.linkedin.com/company/jaseci-labs/"),
    SocialEntry(kind="github", url="https://github.com/Jaseci-Labs/jaseci"),
    SocialEntry(kind="discord", url="https://discord.gg/6j3QNdtcN6"),
    SocialEntry(kind="email", url="community@jaseci.org"),
    SocialEntry(kind="website", url="https://docs.jaseci.org/")
];

# --- lib/utils/textConverter.js --------------------------------------------

"""Punctuation github-slugger removes before hyphenating spaces."""
glob:pub SLUG_STRIP: str = "\\'!\"#$%&()*+,./:;<=>?@[]^`{|}~";

"""Client-side port of github-slugger's `slug()`."""
def:pub slugify(content: str) -> str {
    lowered = content.lower();
    out = "";
    for ch in lowered {
        if ch in SLUG_STRIP {
            continue;
        }
        out = out + ("-" if ch == " " else ch);
    }
    return out;
}

"""Client-side port of `humanize()`."""
def:pub humanize(content: str) -> str {
    trimmed = content.strip().strip("_").strip();
    out = "";
    previous_gap = False;
    for ch in trimmed {
        if ch == "_" or ch == " " {
            previous_gap = True;
            continue;
        }
        if previous_gap and out {
            out = out + " ";
        }
        previous_gap = False;
        out = out + ch;
    }
    if out {
        return out[0].upper() + out[1:];
    }
    return out;
}

"""Truncate to `summary_length`, matching the old `Posts` excerpt."""
def:pub summarize(content: str) -> str {
    return content[:SUMMARY_LENGTH];
}
