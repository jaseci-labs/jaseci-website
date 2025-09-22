"use client";

import Image from "next/image";
import { useEffect, useRef } from "react";

const Hero = () => {
  const cursorRef = useRef(null);
  const heroRef = useRef(null);

  useEffect(() => {
    const handleMouseMove = (e) => {
      if (cursorRef.current && heroRef.current) {
        const rect = heroRef.current.getBoundingClientRect();
        const x = e.clientX - rect.left;
        const y = e.clientY - rect.top;
        
        // Convert to percentage for smooth movement
        const xPercent = (x / rect.width) * 100;
        const yPercent = (y / rect.height) * 100;
        
        cursorRef.current.style.transform = `translate(${xPercent - 50}%, ${yPercent - 50}%)`;
        cursorRef.current.style.opacity = '1';
      }
    };

    const handleMouseLeave = () => {
      if (cursorRef.current) {
        cursorRef.current.style.opacity = '0';
      }
    };

    const heroElement = heroRef.current;
    if (heroElement) {
      heroElement.addEventListener('mousemove', handleMouseMove);
      heroElement.addEventListener('mouseleave', handleMouseLeave);
    }

    return () => {
      if (heroElement) {
        heroElement.removeEventListener('mousemove', handleMouseMove);
        heroElement.removeEventListener('mouseleave', handleMouseLeave);
      }
    };
  }, []);

  return (
    <>
      <section ref={heroRef} className="min-h-[80vh] flex items-center py-12 sm:py-16 lg:py-20 bg-dark-bg relative overflow-hidden mt-5">
        <div className="absolute inset-0 opacity-10">
          <div className="absolute top-10 right-20 w-40 h-40 bg-gradient-to-br from-primary-orange to-primary-yellow rounded-full blur-xl animate-pulse"></div>
          <div className="absolute bottom-20 left-10 w-32 h-32 bg-gradient-to-br from-primary-yellow to-primary-orange rounded-full blur-lg animate-pulse delay-1000"></div>
          <div className="absolute top-1/2 left-1/3 w-24 h-24 bg-gradient-to-br from-primary-orange/50 to-primary-yellow/50 rounded-full blur-xl animate-pulse delay-500"></div>
        </div>

        {/* Cursor Following Animation */}
        <div 
          ref={cursorRef}
          className="absolute w-96 h-96 pointer-events-none opacity-0 transition-all duration-300 ease-out z-0"
          style={{
            background: 'radial-gradient(circle, rgba(255, 149, 0, 0.06) 0%, rgba(255, 193, 7, 0.04) 30%, transparent 70%)',
            filter: 'blur(40px)',
            left: '50%',
            top: '50%',
            transform: 'translate(-50%, -50%)'
          }}
        />

        {/* Additional cursor trail effects */}
        <div className="absolute inset-0 pointer-events-none">
          <div 
            className="absolute w-32 h-32 opacity-0 transition-all duration-700 ease-out"
            style={{
              background: 'radial-gradient(circle, rgba(255, 149, 0, 0.05) 0%, transparent 60%)',
              filter: 'blur(20px)',
              animation: 'cursorTrail 3s infinite ease-in-out'
            }}
          />
          <div 
            className="absolute w-24 h-24 opacity-0 transition-all duration-500 ease-out"
            style={{
              background: 'radial-gradient(circle, rgba(255, 193, 7, 0.04) 0%, transparent 50%)',
              filter: 'blur(15px)',
              animation: 'cursorTrail 2.5s infinite ease-in-out 0.5s'
            }}
          />
        </div>

        <div className="container mx-auto max-w-6xl px-4 relative z-10">
          <div className="grid lg:grid-cols-2 gap-10 lg:gap-14 items-center">
            <div className="text-center lg:text-left">
              <div className="mb-6">
                <h1 className="font-bold tracking-tight text-balance leading-tight text-3xl sm:text-4xl lg:text-5xl">
                  <span 
                    className="block text-white"
                    style={{ animation: 'fadeInUp 0.6s ease-out 0s both' }}
                  >
                    Enable fast, low-complexity
                  </span>
                  <span 
                    className="block bg-gradient-to-r from-primary-orange via-primary-yellow to-primary-orange bg-clip-text text-transparent drop-shadow-sm"
                    style={{ animation: 'fadeInUp 0.6s ease-out 0.2s both' }}
                  >
                    development of AI-powered,
                  </span>
                  <span 
                    className="block text-white"
                    style={{ animation: 'fadeInUp 0.6s ease-out 0.4s both' }}
                  >
                    scalable applications
                  </span>
                </h1>
                <div className="h-1 bg-gradient-to-r from-transparent via-primary-orange to-transparent mx-auto lg:mx-0 w-32 mt-4" style={{ animation: 'fadeInUp 0.6s ease-out 0.6s both' }}></div>
              </div>

              <p 
                className="mt-4 sm:mt-5 text-sm sm:text-base lg:text-lg text-dark-text/90 leading-relaxed max-w-prose mx-auto lg:mx-0"
                style={{ animation: 'fadeInUp 0.6s ease-out 0.8s both' }}
              >
                The Jac programming language and Jaseci runtime stack builds on Python, introducing
                <span className="text-primary-orange font-medium hover:text-primary-yellow transition-colors duration-300"> AI-first constructs</span>,
                <span className="text-primary-orange font-medium hover:text-primary-yellow transition-colors duration-300"> object-spatial programming</span>, and
                <span className="text-primary-orange font-medium hover:text-primary-yellow transition-colors duration-300"> scale-native constructs</span>.
              </p>

              <div 
                className="mt-6 sm:mt-8 flex flex-col sm:flex-row gap-3 sm:gap-4 justify-center lg:justify-start"
                style={{ animation: 'fadeInUp 0.6s ease-out 1s both' }}
              >
                <a
                  href="https://www.jac-lang.org/learn/installation/"
                  onClick={() =>
                    import("@lib/gtag").then(({ event }) =>
                      event({
                        action: "click_get_started",
                        category: "engagement",
                        label: "home_hero_get_started",
                        value: 1,
                        transport_type: "beacon",
                      })
                    )
                  }
                  className="group inline-flex items-center justify-center rounded-lg px-6 py-3 text-sm font-semibold text-white bg-gradient-to-r from-primary-orange to-primary-yellow shadow-[0_8px_24px_rgba(255,107,53,0.35)] transition-all duration-300 hover:-translate-y-1 hover:shadow-[0_12px_32px_rgba(255,107,53,0.5)] focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary-yellow/70 transform hover:scale-105"
                >
                  <span>Get Started</span>
                  <svg className="w-4 h-4 ml-2 transition-transform duration-300 group-hover:translate-x-1" fill="currentColor" viewBox="0 0 20 20">
                    <path fillRule="evenodd" d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z" clipRule="evenodd" />
                  </svg>
                </a>
                <a
                  href="https://www.jac-lang.org/learn/introduction/"
                  className="inline-flex items-center justify-center rounded-lg px-6 py-3 text-sm font-semibold border border-primary-orange/30 text-primary-orange bg-primary-orange/10 backdrop-blur-sm transition-all duration-300 hover:bg-primary-orange hover:text-white hover:border-primary-orange hover:shadow-lg hover:shadow-primary-orange/25 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary-orange/60 transform hover:scale-105"
                >
                  Learn More
                </a>
              </div>
            </div>

            <div 
              className="order-first lg:order-last"
              style={{ animation: 'fadeInUp 0.6s ease-out 0.4s both' }}
            >
              <div className="group rounded-2xl border border-light-bg/20 bg-gradient-to-br from-dark-bg/80 via-dark-bg/60 to-dark-bg/80 backdrop-blur-sm p-5 hover:border-primary-orange/30 transition-all duration-300 hover:shadow-xl hover:shadow-primary-orange/10 relative overflow-hidden">
                <div className="flex items-center justify-between mb-4">
                  <div className="flex items-center gap-2">
                    <span className="w-2.5 h-2.5 rounded-full bg-red-500 transition-all duration-300 group-hover:shadow-sm group-hover:shadow-red-500/50" />
                    <span className="w-2.5 h-2.5 rounded-full bg-yellow-500 transition-all duration-300 group-hover:shadow-sm group-hover:shadow-yellow-500/50" />
                    <span className="w-2.5 h-2.5 rounded-full bg-green-500 transition-all duration-300 group-hover:shadow-sm group-hover:shadow-green-500/50" />
                  </div>
                  <span className="text-[10px] text-dark-text/80 group-hover:text-primary-orange transition-colors duration-300">jaseci-stack</span>
                </div>

                {/* Animated Stack Visualization */}
                <div className="relative h-[360px] bg-gradient-to-br from-[#0d1117] to-[#161b22] rounded-lg border border-light-bg/5 overflow-hidden">
                  {/* Background animated grid */}
                  <div className="absolute inset-0 opacity-20">
                    <div className="grid-background"></div>
                  </div>

                  {/* Stack Layers - Animated from bottom to top */}
                  <div className="absolute inset-0 flex flex-col justify-end p-4 space-y-2">
                    {/* Layer 4 - Applications */}
                    <div 
                      className="stack-layer bg-gradient-to-r from-primary-orange/30 to-primary-yellow/30 border border-primary-orange/40 rounded-lg p-3 backdrop-blur-sm"
                      style={{ animation: 'stackSlideUp 0.8s ease-out 0.6s both' }}
                    >
                      <div className="flex items-center justify-between">
                        <span className="text-xs font-semibold text-white">Applications</span>
                        <div className="flex space-x-1">
                          <div className="w-2 h-2 bg-primary-orange rounded-full animate-pulse"></div>
                          <div className="w-2 h-2 bg-primary-yellow rounded-full animate-pulse delay-200"></div>
                        </div>
                      </div>
                      <div className="text-[10px] text-gray-300 mt-1">AI-Powered Web Apps, APIs, Microservices</div>
                    </div>

                    {/* Layer 3 - Jac Language */}
                    <div 
                      className="stack-layer bg-gradient-to-r from-blue-500/30 to-purple-500/30 border border-blue-400/40 rounded-lg p-3 backdrop-blur-sm"
                      style={{ animation: 'stackSlideUp 0.8s ease-out 0.4s both' }}
                    >
                      <div className="flex items-center justify-between">
                        <span className="text-xs font-semibold text-white">Jac Language</span>
                        <div className="flex space-x-1">
                          <div className="w-2 h-2 bg-blue-400 rounded-full animate-pulse"></div>
                          <div className="w-2 h-2 bg-purple-400 rounded-full animate-pulse delay-300"></div>
                        </div>
                      </div>
                      <div className="text-[10px] text-gray-300 mt-1">AI-First Programming, Object-Spatial</div>
                    </div>

                    {/* Layer 2 - Jaseci Runtime */}
                    <div 
                      className="stack-layer bg-gradient-to-r from-green-500/30 to-teal-500/30 border border-green-400/40 rounded-lg p-3 backdrop-blur-sm"
                      style={{ animation: 'stackSlideUp 0.8s ease-out 0.2s both' }}
                    >
                      <div className="flex items-center justify-between">
                        <span className="text-xs font-semibold text-white">Jaseci Runtime</span>
                        <div className="flex space-x-1">
                          <div className="w-2 h-2 bg-green-400 rounded-full animate-pulse delay-100"></div>
                          <div className="w-2 h-2 bg-teal-400 rounded-full animate-pulse delay-400"></div>
                        </div>
                      </div>
                      <div className="text-[10px] text-gray-300 mt-1">Scale-Native Execution, Cloud Ready</div>
                    </div>

                    {/* Layer 1 - Python Foundation */}
                    <div 
                      className="stack-layer bg-gradient-to-r from-yellow-600/30 to-blue-600/30 border border-yellow-500/40 rounded-lg p-3 backdrop-blur-sm"
                      style={{ animation: 'stackSlideUp 0.8s ease-out 0s both' }}
                    >
                      <div className="flex items-center justify-between">
                        <span className="text-xs font-semibold text-white">Python Foundation</span>
                        <div className="flex space-x-1">
                          <div className="w-2 h-2 bg-yellow-500 rounded-full animate-pulse delay-500"></div>
                          <div className="w-2 h-2 bg-blue-500 rounded-full animate-pulse delay-600"></div>
                        </div>
                      </div>
                      <div className="text-[10px] text-gray-300 mt-1">Familiar Syntax, Powerful Extensions</div>
                    </div>
                  </div>

                  {/* Animated data flow particles */}
                  <div className="absolute inset-0 pointer-events-none">
                    <div className="particle particle-1"></div>
                    <div className="particle particle-2"></div>
                    <div className="particle particle-3"></div>
                    <div className="particle particle-4"></div>
                  </div>

                  {/* Floating code snippets */}
                  <div className="absolute top-4 right-4 opacity-60 group-hover:opacity-80 transition-opacity duration-300">
                    <div className="text-[8px] font-mono text-primary-orange bg-black/50 px-2 py-1 rounded animate-float">
                      {"with entry { ... }"}
                    </div>
                  </div>
                  <div className="absolute bottom-4 left-4 opacity-40 group-hover:opacity-60 transition-opacity duration-300">
                    <div className="text-[8px] font-mono text-blue-400 bg-black/50 px-2 py-1 rounded animate-float-delayed">
                      {"node.ai_connect()"}
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <style jsx>{`
          @keyframes fadeInUp {
            from {
              opacity: 0;
              transform: translateY(30px);
            }
            to {
              opacity: 1;
              transform: translateY(0);
            }
          }

          @keyframes cursorTrail {
            0%, 100% {
              opacity: 0;
              transform: scale(0.8);
            }
            50% {
              opacity: 0.6;
              transform: scale(1.2);
            }
          }

          @keyframes stackSlideUp {
            from {
              opacity: 0;
              transform: translateY(20px);
            }
            to {
              opacity: 1;
              transform: translateY(0);
            }
          }

          @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
          }

          @keyframes floatDelayed {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-8px); }
          }

          .grid-background {
            background-image: 
              linear-gradient(rgba(255, 149, 0, 0.1) 1px, transparent 1px),
              linear-gradient(90deg, rgba(255, 149, 0, 0.1) 1px, transparent 1px);
            background-size: 20px 20px;
            animation: gridMove 20s linear infinite;
          }

          @keyframes gridMove {
            0% { transform: translate(0, 0); }
            100% { transform: translate(20px, 20px); }
          }

          .stack-layer {
            position: relative;
            overflow: hidden;
          }

          .stack-layer::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.1), transparent);
            animation: shimmer 3s infinite;
          }

          @keyframes shimmer {
            0% { left: -100%; }
            100% { left: 100%; }
          }

          .particle {
            position: absolute;
            width: 3px;
            height: 3px;
            background: rgba(255, 149, 0, 0.6);
            border-radius: 50%;
          }

          .particle-1 {
            top: 80%; left: 20%;
            animation: particleFloat1 4s infinite ease-in-out;
          }

          .particle-2 {
            top: 60%; left: 70%;
            animation: particleFloat2 3s infinite ease-in-out 1s;
          }

          .particle-3 {
            top: 40%; left: 50%;
            animation: particleFloat3 5s infinite ease-in-out 2s;
          }

          .particle-4 {
            top: 20%; left: 30%;
            animation: particleFloat4 3.5s infinite ease-in-out 0.5s;
          }

          @keyframes particleFloat1 {
            0%, 100% { transform: translate(0, 0) scale(1); opacity: 0.6; }
            50% { transform: translate(-20px, -60px) scale(1.2); opacity: 1; }
          }

          @keyframes particleFloat2 {
            0%, 100% { transform: translate(0, 0) scale(1); opacity: 0.4; }
            50% { transform: translate(15px, -80px) scale(0.8); opacity: 0.8; }
          }

          @keyframes particleFloat3 {
            0%, 100% { transform: translate(0, 0) scale(1); opacity: 0.5; }
            50% { transform: translate(-30px, -40px) scale(1.5); opacity: 1; }
          }

          @keyframes particleFloat4 {
            0%, 100% { transform: translate(0, 0) scale(1); opacity: 0.3; }
            50% { transform: translate(25px, -70px) scale(0.9); opacity: 0.7; }
          }

          .animate-float {
            animation: float 3s ease-in-out infinite;
          }

          .animate-float-delayed {
            animation: floatDelayed 4s ease-in-out infinite 1s;
          }
        `}</style>
      </section>

      <section className="pt-0 pb-8 bg-dark-bg/30 relative">
        <div className="container mx-auto max-w-6xl px-4">
          <div 
            className="text-center py-6 sm:py-8 px-6 sm:px-8 bg-gradient-to-br from-dark-bg/80 via-dark-bg/60 to-dark-bg/80 backdrop-blur-sm rounded-2xl border border-light-bg/20 hover:border-primary-orange/30 transition-all duration-500 hover:shadow-xl hover:shadow-primary-orange/5"
            style={{ animation: 'fadeInUp 0.6s ease-out 1.8s both' }}
          >
            <div className="mb-6">
              <h3 className="text-sm sm:text-base lg:text-lg font-bold text-white mb-2">
                Our journey is strengthened by our sponsors and partners
              </h3>
              <div className="h-0.5 bg-gradient-to-r from-transparent via-primary-orange to-transparent mx-auto w-24"></div>
            </div>

            <div className="flex flex-col sm:flex-row items-center justify-center max-w-5xl mx-auto">
              {[
                {
                  logo: "/images/assets/org1_logo.png",
                  text: "Part of Nvidia Inception Program, supporting cutting edge AI innovation and scalability",
                },
                {
                  logo: "/images/assets/org2_logo.png",
                  text: "Research led by faculty and researchers at University of Michigan, United States",
                },
                {
                  logo: "/images/assets/org3_logo.png",
                  text: "Sponsored by NSF, advancing community driven open source ecosystem",
                },
              ].map((item, index) => (
                <div key={index} className="flex items-center">
                  <div
                    className="group flex flex-col items-center gap-3 text-center p-4 sm:p-6 rounded-xl hover:bg-dark-bg/20 transition-all duration-300 hover:transform hover:scale-105 flex-1"
                    style={{ animation: `fadeInUp 0.6s ease-out ${2 + index * 0.1}s both` }}
                  >
                    <div className="relative">
                      <Image
                        src={item.logo}
                        alt={`Affiliation ${index + 1}`}
                        width={150}
                        height={80}
                        className="h-16 w-auto opacity-90 group-hover:opacity-100 transition-all duration-300 group-hover:drop-shadow-lg"
                      />
                      <div className="absolute inset-0 bg-gradient-to-t from-primary-orange/5 to-transparent rounded opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
                    </div>
                    <p className="text-xs text-[#9AA0A6] leading-relaxed group-hover:text-white/80 transition-colors duration-300 max-w-xs">
                      {item.text}
                    </p>
                  </div>
                  
                  {/* Vertical separator line - only show between items, not after the last one */}
                  {index < 2 && (
                    <div className="hidden sm:block w-px h-20 bg-gradient-to-b from-transparent via-light-bg/30 to-transparent mx-4 lg:mx-6">
                      <div className="w-full h-full bg-gradient-to-b from-transparent via-primary-orange/40 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
                    </div>
                  )}
                </div>
              ))}
            </div>
          </div>
        </div>

        <style jsx>{`
          @keyframes fadeInUp {
            from {
              opacity: 0;
              transform: translateY(30px);
            }
            to {
              opacity: 1;
              transform: translateY(0);
            }
          }
        `}</style>
      </section>
    </>
  );
};

export default Hero;
