"""`/about-us` - ports `app/about-us/page.js`."""

import from "@jac/runtime" { Link }
import from "react-icons/fa" { FaExternalLinkAlt, FaLinkedin }
import from "react-icons/fa6" { FaXTwitter }
import from ..SeoMeta { SeoMeta }
import from ..landing.Journey { Journey }

obj TeamMember {
    has name: str = "",
        title: str = "",
        image: str = "",
        description: str = "",
        linkedin: str = "",
        twitter: str = "",
        website: str = "";
}

obj Testimonial {
    has quote: str = "",
        author: str = "",
        title: str = "",
        company: str = "",
        logo: str = "";
}

glob TEAM: list[TeamMember] = [
    TeamMember(
        name="Jason Mars",
        title="Founder, Computer Science Professor, University of Michigan",
        image="/assets/images/assets/leadership_team/Jason.png",
        description="Prof. Jason Mars is the founder and architect of Jaseci. His expertise is demonstrated by over 100 research papers, 30+ patents, and his bestselling book, “Breaking Bots.” As a serial entrepreneur, his ventures have delivered cutting-edge AI to over 20 million users, raised over $62M in funding, and earned him accolades like the prestigious CARAH Award and Crain's 40 under 40.",
        linkedin="https://linkedin.com/in/drjasonmars",
        twitter="https://x.com/drjasonmars",
        website="https://www.jasonmars.org"
    ),
    TeamMember(
        name="Lingjia Tang",
        title="Computer Science Professor, University of Michigan",
        image="/assets/images/assets/leadership_team/Lingjia.png",
        description="Prof. Lingjia is an award-winning researcher in AI systems, recognised with the Google Research Award, Facebook Research Award, ISCA Hall of Fame, and MICRO Hall of Fame. As a co-founder of AI companies Myca.ai and Clinc, she built technology serving tens of millions of enterprise users and helped raise $70 million in venture capital for her prior company.",
        linkedin="https://linkedin.com/in/lingjia-tang-a7667912",
        twitter="https://x.com/Lingjia781856",
        website="https://lingjia.org"
    ),
    TeamMember(
        name="Yiping Kang",
        title="Research Fellow, University of Michigan",
        image="/assets/images/assets/leadership_team/Yiping.png",
        description="Dr. Yiping Kang is a research expert in natural language processing, computer vision, computer architecture and systems, with numerous publications at top tier academic conferences including ISCA, ASPLOS, ACL and NeurIPS. Previously, he was Head of Product at Clinc, a conversational AI startup, leading the product development of the world’s most sophisticated conversational AI platform serving millions of users worldwide.",
        linkedin="https://linkedin.com/in/yipingkang0608",
        twitter="https://x.com/yipingkang",
        website="https://ypkang.github.io"
    ),
    TeamMember(
        name="Kris Flaunter",
        title="Advisor, Professor of Engineering Practice, EECS Department, University of Michigan",
        image="/assets/images/assets/leadership_team/Krisztian.png",
        description="Kris Flaunter is a Professor of Engineering Practice at the University of Michigan, serving as an advisor to students and researchers. Before his current academic role, he built an extensive career in the tech industry, holding leadership positions such as Director of Strategy, Emerging Technology and Incubation at Cisco and CEO of Banzai cloud. Previously, he was the VP of Research and Development at ARM, where his work on power-efficient computing earned him the 2017 ISCA influential paper award.",
        linkedin="https://linkedin.com/in/kflautner",
        website="https://linkedin.com/in/kflautner"
    ),
    TeamMember(
        name="Jayanaka Dantanarayana",
        title="PhD Candidate, University of Michigan",
        image="/assets/images/assets/leadership_team/Jayanaka.png",
        description="Jayanaka Dantanarayana is a multidisciplinary researcher and PhD student at the University of Michigan's Jaseci Research Laboratory. His work centers on developing novel AI-integration techniques to simplify the process for developers building software with AI functionalities. He is also exploring the field of Agentic-AI through his tool, MTP (MTLLM), within the Jac programming language.",
        linkedin="https://linkedin.com/in/jayanaka-dantanarayana",
        twitter="https://x.com/JayanakaD",
        website="https://linkedin.com/in/jayanaka-dantanarayana"
    ),
    TeamMember(
        name="Logeeshan Velmanickam",
        title="Senior Lecturer in the Department of Electrical Engineering at the University of Moratuwa",
        image="/assets/images/assets/leadership_team/Logeeshan.png",
        description="Dr. Logeeshan Velamanikkam's primary research focuses on the intersection of AI and the Internet of Things (IoT), biomedical instrumentation, and smart sensor development. He has a keen interest in dielectrophoresis and its applications in biomedical devices, as well as advancements in renewable energy.",
        linkedin="https://linkedin.com/in/logeeshan-velmanickam-ph-d-b6727113b",
        twitter="https://x.com/LogeeshanV",
        website="https://linkedin.com/in/logeeshan-velmanickam-ph-d-b6727113b"
    ),
    TeamMember(
        name="Eldon Marks",
        title="Founding Director of V75 Inc. and Co-Founder of TrueSelph Inc",
        image="/assets/images/assets/leadership_team/Eldon.png",
        description="Eldon Marks is a tech entrepreneur and innovator dedicated to empowering Guyana's tech industry. After 13 years as a university lecturer and mentor, he founded the conversational AI company V75 Inc and its non-profit partner, NeXus Hub Inc, which provides industry-level upskilling and job placement for local youth.",
        linkedin="https://linkedin.com/in/eldonmarks",
        twitter="https://x.com/theeldonmarks",
        website="https://eldonmarks.com"
    ),
    TeamMember(
        name="Asim Salim",
        title="Head of Technology, BCS Technology",
        image="/assets/images/assets/leadership_team/Asim.png",
        description="Asim is a technology consultant who has led multiple complex IT engagements delivering innovative solutions for global organizations. Asim led the product development of Zero Shot Bot which uses Jaseci at its core. Asim is currently the Head of Technology at BCS Technology, a leading global IT services provider.",
        linkedin="https://linkedin.com/in/asimsalim",
        website="https://linkedin.com/in/asimsalim"
    )
];

glob TESTIMONIALS: list[Testimonial] = [
    Testimonial(
        quote="We are very excited that Jaseci solved our challenges of providing AI solutions for our customers, lowered cost and increased our development speed.",
        author="Richard Parhusip",
        title="Commercial Director",
        company="BCS Technology and BCS Consulting",
        logo="/assets/images/assets/partners/bcs.png"
    ),
    Testimonial(
        quote="Jaseci is a new programming language and runtime system that has the potential to hide the complexity of backend systems for many AI practitioners and thus lowers the barrier of entry for general developers, leading to great improvement of developers' productivity.",
        author="Robert Hundt",
        title="Distinguished Engineer",
        company="Google",
        logo="/assets/images/assets/partners/google.png"
    ),
    Testimonial(
        quote="I believe that Jaseci has the potential to provide solutions to some of the major pain points for enterprise Al transformation.",
        author="Judd Standage",
        title="Enterprise Solution Architect",
        company="Cognizant",
        logo="/assets/images/assets/partners/cognizant.png"
    ),
    Testimonial(
        quote="The Jaseci open-source project is a great initiative that has the potential to be a game-changer in enabling the creation and deployment of software that leverages artificial intelligence and machine learning.",
        author="Krisztian Flautner",
        title="Director of Engineering",
        company="CISCO",
        logo="/assets/images/assets/partners/cisco.png"
    )
];

def SocialIcon(href: str, children: any = None) -> JsxElement {
    return <a
        href={href}
        target="_blank"
        rel="noopener noreferrer"
        className="text-about-muted-foreground hover:text-about-primary transition-colors duration-300"
    >
        {children}
    </a>;
}

def TeamMemberCard(member: TeamMember, is_reversed: bool) -> JsxElement {
    return <div className={
        "flex flex-col lg:flex-row items-center gap-12 " + ("lg:flex-row-reverse" if is_reversed else "")
    }>
        <div className="relative flex-shrink-0 group">
            <div className="absolute -inset-1 bg-gradient-border rounded-2xl blur-lg opacity-50 group-hover:opacity-75 transition duration-300"></div>
            <div className="relative bg-about-card rounded-2xl border border-about-border overflow-hidden">
                <img
                    src={member.image}
                    alt={member.name}
                    width={200}
                    height={200}
                    className="object-cover"
                />
            </div>
        </div>
        <div className="flex-1 flex flex-col gap-6">
            <div>
                <h3 className="text-3xl font-bold flex items-center gap-3 mb-2">
                    {member.name}
                    <span className="flex gap-2">
                        {if member.linkedin {
                            <SocialIcon key="linkedin" href={member.linkedin}><FaLinkedin /></SocialIcon>
                        }}
                        {if member.twitter {
                            <SocialIcon key="twitter" href={member.twitter}><FaXTwitter /></SocialIcon>
                        }}
                    </span>
                </h3>
                <div className="flex items-center gap-3 flex-wrap">
                    <p className="text-base font-semibold text-about-primary uppercase tracking-wider">
                        {member.title}
                    </p>
                    <a
                        href={member.website}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="inline-flex items-center gap-1 text-about-primary text-sm border border-about-primary px-3 py-1 rounded-md font-semibold transition-all duration-300 hover:bg-about-primary hover:text-white"
                    >
                        <FaExternalLinkAlt size={12} />
                        More Info
                    </a>
                </div>
            </div>
            <p className="text-about-muted-foreground leading-relaxed">
                {member.description}
            </p>
        </div>
    </div>;
}

def TestimonialCard(testimonial: Testimonial) -> JsxElement {
    return <div className="relative group">
        <div className="absolute -inset-0.5 bg-gradient-border rounded-2xl blur-md opacity-0 group-hover:opacity-75 transition duration-300"></div>
        <div className="relative h-full bg-about-card rounded-2xl border border-about-border p-8 transition-shadow duration-300 group-hover:shadow-2xl group-hover:shadow-primary-orange/10">
            <svg
                xmlns="http://www.w3.org/2000/svg"
                width="32"
                height="32"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                strokeWidth="2"
                strokeLinecap="round"
                strokeLinejoin="round"
                className="text-about-primary mb-6"
            >
                <path d="M3 21c3 0 7-1 7-8V5c0-1.25-.75-2-2-2H4c-1.25 0-2 .75-2 2v6c0 7 4 8 7 8z"></path>
                <path d="M14 21c3 0 7-1 7-8V5c0-1.25-.75-2-2-2h-4c-1.25 0-2 .75-2 2v6c0 7 4 8 7 8z"></path>
            </svg>
            <blockquote className="text-lg font-medium italic mb-8">
                {"\"" + testimonial.quote + "\""}
            </blockquote>
            <div className="flex items-center gap-4">
                <div className="w-12 h-12 bg-about-background rounded-lg flex items-center justify-center p-1 flex-shrink-0">
                    <img
                        src={testimonial.logo}
                        alt={testimonial.company + " logo"}
                        width={40}
                        height={40}
                        className="object-contain w-full h-full"
                    />
                </div>
                <div>
                    <p className="font-semibold">{testimonial.author}</p>
                    <p className="text-sm text-about-muted-foreground">
                        {testimonial.title}
                    </p>
                    <p className="text-sm font-medium text-about-primary">
                        {testimonial.company}
                    </p>
                </div>
            </div>
        </div>
    </div>;
}

def HeroSection() -> JsxElement {
    return <section className="relative min-h-screen flex items-center justify-center overflow-hidden text-center">
        <div className="absolute inset-0 bg-radial-gradient from-about-background/50 via-primary-orange to-about-background"></div>
        <div className="absolute inset-0 overflow-hidden">
            <div className="absolute top-1/4 left-1/4 w-64 h-64 bg-primary-orange/10 rounded-full filter blur-3xl animate-blob-pulse"></div>
            <div className="absolute bottom-1/4 right-1/4 w-96 h-96 bg-primary-yellow/5 rounded-full filter blur-3xl animate-blob-pulse animation-delay-2000"></div>
        </div>

        <div className="container relative z-10 px-6">
            <div className="max-w-4xl mx-auto">
                <h1 className="text-6xl md:text-7xl font-extrabold mb-8 bg-gradient-primary text-transparent bg-clip-text">
                    About Jaseci
                </h1>
                <div className="flex flex-col gap-8 text-about-muted-foreground">
                    <p className="text-2xl md:text-3xl font-medium text-about-foreground">
                        We envision a world where the pace of innovation is only limited by
                        imagination, not by infrastructure.
                    </p>
                    <p className="text-xl md:text-2xl font-medium text-about-primary">
                        Our mission is to simplify the creation of scalable AI to accelerate
                        a new wave of innovation.
                    </p>
                    <p className="max-w-3xl mx-auto text-lg">
                        Jaseci is an end-to-end, open-source technology stack designed for
                        the next generation of AI. It enables developers to rapidly build
                        and deploy robust, sophisticated AI products at scale. The project
                        is stewarded by Jaseci Labs. Our team is composed of leading AI
                        professors, PhD students, and industry experts.
                    </p>
                </div>
            </div>
        </div>
    </section>;
}

def:pub AboutUsView() -> JsxElement {
    return <div className="bg-about-background text-about-foreground">
        <SeoMeta
            title="About Jaseci"
            description="Learn about the team, mission, and vision behind the Jaseci open-source AI stack."
            image="/assets/images/logo.png"
        />

        <HeroSection />
        <Journey />

        <section className="py-20">
            <div className="container px-6">
                <div className="text-center mb-16">
                    <h2 className="text-3xl md:text-4xl font-extrabold text-about-foreground mb-4">
                        Our Leadership Team
                    </h2>
                    <p className="text-lg text-about-muted-foreground max-w-3xl mx-auto">
                        Meet the world-class team of AI researchers, professors, and industry
                        veterans driving innovation at Jaseci
                    </p>
                </div>
                <div className="flex flex-col gap-16">
                    {for (i, member) in enumerate(TEAM) {
                        <TeamMemberCard key={member.name} member={member} is_reversed={i % 2 != 0} />
                    }}
                </div>
            </div>
        </section>

        <section className="py-20 bg-about-secondary/30">
            <div className="container px-6">
                <div className="text-center mb-16">
                    <h2 className="text-3xl md:text-4xl font-extrabold text-about-foreground mb-4">
                        Developer Excerpts
                    </h2>
                    <p className="text-lg text-about-muted-foreground max-w-3xl mx-auto">
                        Hear from the developers and industry leaders who trust Jaseci for
                        their AI infrastructure needs
                    </p>
                </div>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
                    {for testimonial in TESTIMONIALS {
                        <TestimonialCard key={testimonial.author} testimonial={testimonial} />
                    }}
                </div>
            </div>
        </section>
    </div>;
}
