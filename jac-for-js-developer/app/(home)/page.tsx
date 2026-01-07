import Link from 'next/link';
import { Hero } from '@/components/homepage/hero';
import { Features } from '@/components/homepage/features';
import { GitHubStars } from '@/components/github-stars';

export default function HomePage() {
  return (
    <div className="flex flex-col">
      <Hero />

      <div className="container mx-auto px-4 py-8">
        <GitHubStars repo="jaseci-labs/jaseci" />
        <Features />

        <div className="mt-16 text-center">
          <Link
            href="/docs"
            className="inline-flex items-center px-6 py-3 text-lg font-semibold text-white bg-blue-600 rounded-lg hover:bg-blue-500 transition"
          >
            Start Learning →
          </Link>
        </div>
      </div>
    </div>
  );
}
