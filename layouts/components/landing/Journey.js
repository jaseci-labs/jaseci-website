const journeyMilestones = [
  {
    year: "Prologue (2020)",
    description:
      "The concept of a new way of developing software in the AI era is concieved and later described in a Forbes blog article.",
    link: "https://www.forbes.com/sites/forbesbooksauthors/2021/05/18/whats-in-store-for-the-next-generation-of-ai-the-jaseci-perspective/",
    linkText:
      "What’s In Store For The Next Generation Of AI? The Jaseci Perspective",
  },
  {
    year: "2022",
    description:
      "The idea has evolved and the first intellectual step in the journey of Jaseci and Jac is described.",
    link: "https://arxiv.org/abs/2206.08434",
    linkText:
      "The Case for a Wholistic Serverless Programming Paradigm and Full Stack Automation for AI and Beyond -- The Philosophy of Jaseci and Jac",
  },
  {
    year: "2023",
    description:
      "The idea survives peer-review at Computer Architecture Letters.",
    link: "https://arxiv.org/abs/2305.09864",
    linkText:
      "The Jaseci Programming Paradigm and Runtime Stack: Building Scale-out Production Applications Easy and Fast",
  },
  {
    year: "2024",
    description:
      "The idea that AI should be a conventional code construct in the language is conjoured and ellucidated.",
    link: "https://arxiv.org/abs/2405.08965v1",
    linkText: "LLMs are Meaning-Typed Code Constructs",
  },
];

const Journey = () => {
  return (
    <section className="py-20 bg-dark-bg">
      <div className="max-w-3xl mx-auto px-5">
        <div className="text-center mb-10">
          <h2 className="text-4xl font-semibold mb-5">Journey of Jaseci</h2>
          <p className="text-lg text-primary-orange italic">
            ~ The story of an idea realized ~
          </p>
        </div>
        <div className="text-left">
          {journeyMilestones.map((milestone, index) => (
            <div key={index} className="mb-6">
              <p className="text-base leading-relaxed text-dark-text">
                <strong>{milestone.year}:</strong> {milestone.description}
                <br />
                <strong>
                  <a
                    href={milestone.link}
                    target="_blank"
                    className="card-link"
                  >
                    {milestone.linkText}
                  </a>
                </strong>
              </p>
            </div>
          ))}
          <p className="text-base leading-relaxed text-dark-text mt-8">
            And the journey continues...
          </p>
        </div>
      </div>
    </section>
  );
};

export default Journey;
