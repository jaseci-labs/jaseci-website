"use client";

import SeoMeta from "@layouts/partials/SeoMeta";
import EcosystemHero from "@layouts/components/landing/EcosystemHero";
import JaclangSection from "@layouts/components/landing/JaclangSection";
import JachacksSection from "@layouts/components/landing/JachacksSection";
import JachammerSection from "@layouts/components/landing/JachammerSection";
import TestimonialsSection from "@layouts/components/landing/TestimonialsSection";

const LandingPage = () => {
  return (
    <>
      <SeoMeta
        title="Jaseci: The Home of the Jac Ecosystem"
        meta_title="Jaseci: The Home of the Jac Ecosystem"
        description="One ecosystem for AI-native software. Jac, the full-stack AI programming language. JacHacks, the hackathon series. JacHammer, the home for your Jac projects."
        image="/images/logo.png"
      />
      <div className="bg-dark-bg">
        <EcosystemHero />
        <JaclangSection />
        <JachacksSection />
        <JachammerSection />
        <TestimonialsSection />

        {/* References */}
        <section id="ref-1" className="py-8 bg-dark-bg pb-16 overflow-x-hidden">
          <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div className="text-center mb-8">
              <h2 className="text-xl sm:text-2xl font-bold text-white mb-3 bg-gradient-to-r from-white via-gray-300 to-gray-400 bg-clip-text text-transparent">
                References
              </h2>
              <div className="h-0.5 bg-gradient-to-r from-transparent via-gray-600 to-transparent mx-auto w-20"></div>
            </div>
            <div className="max-w-4xl mx-auto">
              <div className="bg-gradient-to-br from-dark-bg/90 via-medium-bg/80 to-dark-bg/90 backdrop-blur-md rounded-xl border border-white/10 p-6 sm:p-8 overflow-x-auto">
                <div className="border-l-4 border-primary-orange pl-5">
                  <p className="text-sm text-gray-400 leading-relaxed">
                    <span className="text-gray-300 font-medium">[1]</span>{" "}
                    Jayanaka L. Dantanarayana, Yiping Kang, Kugesan Sivasothynathan, Christopher Clarke, Baichuan Li, Savini Kashmira, Krisztian Flautner, Lingjia Tang, and Jason Mars. 2025.
                  </p>
                  <p className="text-sm text-gray-400 italic mt-1 leading-relaxed">
                    &quot;MTP: A Meaning-Typed Language Abstraction for AI-Integrated Programming.&quot;
                  </p>
                  <p className="text-sm text-gray-500 mt-1 leading-relaxed break-all">
                    Proc. ACM Program. Lang. 9, OOPSLA2, Article 314 (October 2025), 29 pages.{" "}
                    <a href="https://dl.acm.org/doi/10.1145/3763092" target="_blank" rel="noopener noreferrer" className="text-primary-orange underline hover:text-orange-300 transition-colors">
                      https://doi.org/10.1145/3763092
                    </a>
                  </p>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* Closing band */}
        <section className="relative border-t border-white/10 bg-dark-bg py-16 sm:py-20 overflow-hidden">
          <div className="absolute inset-0 pointer-events-none opacity-40">
            <div className="absolute -bottom-24 left-1/2 -translate-x-1/2 w-[600px] h-[300px] bg-gradient-to-t from-primary-orange/15 to-transparent rounded-full blur-3xl"></div>
          </div>
          <div className="relative z-10 max-w-4xl mx-auto px-4 sm:px-6 text-center">
            <h2 className="text-2xl sm:text-3xl font-semibold tracking-tight text-white text-balance">
              Start anywhere. It all runs on Jaseci.
            </h2>
            <p className="mt-3 text-sm sm:text-base text-dark-text/70 leading-relaxed">
              Learn the language, join a hackathon, or give your next creation
              a home.
            </p>
            <div className="mt-7 flex flex-wrap items-center justify-center gap-x-8 gap-y-3 font-mono text-sm">
              <a
                href="https://jaclang.org"
                className="text-dark-text/80 hover:text-primary-orange transition-colors"
              >
                jaclang.org
              </a>
              <span className="hidden sm:inline text-white/15 select-none">/</span>
              <a
                href="https://jachacks.org"
                className="text-dark-text/80 hover:text-white transition-colors"
              >
                jachacks.org
              </a>
              <span className="hidden sm:inline text-white/15 select-none">/</span>
              <a
                href="https://jachammer.ai"
                className="text-dark-text/80 hover:text-amber-400 transition-colors"
              >
                jachammer.ai
              </a>
            </div>
          </div>
        </section>
      </div>
    </>
  );
};

export default LandingPage;
