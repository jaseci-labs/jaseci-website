"""Social icon list - ports `layouts/components/Social.js`."""

import from "react-icons/io5" {
    IoCall, IoGlobeOutline, IoLocation, IoLogoBehance, IoLogoBitbucket,
    IoLogoCodepen, IoLogoDiscord, IoLogoDribbble, IoLogoFacebook,
    IoLogoFoursquare, IoLogoGithub, IoLogoGitlab, IoLogoInstagram,
    IoLogoLinkedin, IoLogoMedium, IoLogoPinterest, IoLogoReddit, IoLogoRss,
    IoLogoSkype, IoLogoSnapchat, IoLogoSoundcloud, IoLogoTiktok, IoLogoTumblr,
    IoLogoTwitter, IoLogoVimeo, IoLogoVk, IoLogoWhatsapp, IoLogoYoutube, IoMail
}

sv import from ..server.content { SocialLink }

"""Match the icon the Next.js component rendered for each network."""
def icon_for(kind: str) -> JsxElement {
    if kind == "facebook" {
        return <IoLogoFacebook />;
    }
    if kind == "twitter" {
        return <IoLogoTwitter />;
    }
    if kind == "instagram" {
        return <IoLogoInstagram />;
    }
    if kind == "youtube" {
        return <IoLogoYoutube />;
    }
    if kind == "linkedin" {
        return <IoLogoLinkedin />;
    }
    if kind == "github" {
        return <IoLogoGithub />;
    }
    if kind == "gitlab" {
        return <IoLogoGitlab />;
    }
    if kind == "medium" {
        return <IoLogoMedium />;
    }
    if kind == "codepen" {
        return <IoLogoCodepen />;
    }
    if kind == "bitbucket" {
        return <IoLogoBitbucket />;
    }
    if kind == "dribbble" {
        return <IoLogoDribbble />;
    }
    if kind == "behance" {
        return <IoLogoBehance />;
    }
    if kind == "pinterest" {
        return <IoLogoPinterest />;
    }
    if kind == "soundcloud" {
        return <IoLogoSoundcloud />;
    }
    if kind == "tumblr" {
        return <IoLogoTumblr />;
    }
    if kind == "reddit" {
        return <IoLogoReddit />;
    }
    if kind == "vk" {
        return <IoLogoVk />;
    }
    if kind == "whatsapp" {
        return <IoLogoWhatsapp />;
    }
    if kind == "snapchat" {
        return <IoLogoSnapchat />;
    }
    if kind == "vimeo" {
        return <IoLogoVimeo />;
    }
    if kind == "tiktok" {
        return <IoLogoTiktok />;
    }
    if kind == "foursquare" {
        return <IoLogoFoursquare />;
    }
    if kind == "skype" {
        return <IoLogoSkype />;
    }
    if kind == "discord" {
        return <IoLogoDiscord />;
    }
    if kind == "rss" {
        return <IoLogoRss />;
    }
    if kind == "email" {
        return <IoMail />;
    }
    if kind == "phone" {
        return <IoCall />;
    }
    if kind == "address" {
        return <IoLocation />;
    }
    return <IoGlobeOutline />;
}

def href_for(link: SocialLink) -> str {
    if link.kind == "email" {
        return "mailto:" + link.url;
    }
    if link.kind == "phone" {
        return "tel:" + link.url;
    }
    return link.url;
}

def label_for(kind: str) -> str {
    if kind == "rss" {
        return "rss feed";
    }
    if kind == "phone" {
        return "telephone";
    }
    if kind == "address" {
        return "location";
    }
    return kind;
}

def:pub Social(source: list[SocialLink], className: str = "") -> JsxElement {
    return <ul className={className}>
        {for link in source {
            <li key={link.kind} className="inline-block">
                <a
                    aria-label={label_for(link.kind)}
                    href={href_for(link)}
                    target="_blank"
                    rel="noopener noreferrer nofollow"
                >
                    {icon_for(link.kind)}
                </a>
            </li>
        }}
    </ul>;
}
