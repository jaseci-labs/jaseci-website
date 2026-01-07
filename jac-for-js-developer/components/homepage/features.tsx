const features = [
  {
    title: 'Python-Inspired Syntax',
    description: 'Clean, readable syntax without semicolons. Use def for functions, and/or/not for logic.',
    icon: '🐍',
  },
  {
    title: 'React-Compatible JSX',
    description: 'Build UI components with familiar JSX syntax. All React hooks work seamlessly.',
    icon: '⚛️',
  },
  {
    title: 'Compiles to JavaScript',
    description: 'JAC-Client compiles to standard JavaScript/React. Use any npm package.',
    icon: '🔄',
  },
  {
    title: 'Progressive Learning',
    description: 'Structured learning path from beginner to advanced with real-world examples.',
    icon: '📚',
  },
];

export function Features() {
  return (
    <div className="py-16">
      <h2 className="text-3xl font-bold text-center mb-12">Why JAC-Client?</h2>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
        {features.map((feature) => (
          <div key={feature.title} className="text-center p-6 rounded-lg border border-gray-200 dark:border-gray-700">
            <div className="text-4xl mb-4">{feature.icon}</div>
            <h3 className="text-xl font-semibold mb-2">{feature.title}</h3>
            <p className="text-gray-600 dark:text-gray-400">{feature.description}</p>
          </div>
        ))}
      </div>
    </div>
  );
}
