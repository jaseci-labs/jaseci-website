"use client";

import SeoMeta from "@layouts/partials/SeoMeta";
import EcosystemHero from "@layouts/components/landing/EcosystemHero";
import JaclangSection from "@layouts/components/landing/JaclangSection";
import JachacksSection from "@layouts/components/landing/JachacksSection";
import JachammerSection from "@layouts/components/landing/JachammerSection";

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
