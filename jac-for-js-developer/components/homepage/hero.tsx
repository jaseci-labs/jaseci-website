import Link from 'next/link';

export function Hero() {
  return (
    <div className="relative overflow-hidden bg-gradient-to-br from-blue-50 to-indigo-100 dark:from-gray-900 dark:to-gray-800">
      <div className="container mx-auto px-4 py-24 sm:py-32">
        <div className="text-center">
          <h1 className="text-5xl font-bold tracking-tight text-gray-900 dark:text-white sm:text-6xl">
            JAC for JavaScript Developers
          </h1>
          <p className="mt-6 text-xl leading-8 text-gray-600 dark:text-gray-300 max-w-2xl mx-auto">
            Learn JAC-Client: A language that combines Python-like syntax with React&apos;s component model.
            If you know JavaScript and React, you&apos;re already 80% there.
          </p>
          <div className="mt-10 flex items-center justify-center gap-6">
            <Link
              href="/docs"
              className="rounded-lg bg-blue-600 px-6 py-3 text-base font-semibold text-white shadow-sm hover:bg-blue-500"
            >
              Get Started
            </Link>
            <Link
              href="/docs/cheatsheet"
              className="text-base font-semibold text-gray-900 dark:text-white"
            >
              View Cheatsheet <span>→</span>
            </Link>
          </div>
        </div>
      </div>
    </div>
  );
}
