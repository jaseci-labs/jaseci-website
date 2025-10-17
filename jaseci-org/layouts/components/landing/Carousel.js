"use client";

import { useState, useEffect, useRef, useMemo } from "react";
import PropTypes from "prop-types";

// --- Custom Hook for Intersection Observer ---
const useIntersectionObserver = (ref, options) => {
  const [inView, setInView] = useState(false);

  useEffect(() => {
    const observer = new IntersectionObserver(([entry]) => {
      // Once it's in view, we stop observing.
      if (entry.isIntersecting) {
        setInView(true);
        observer.unobserve(entry.target);
      }
    }, options);

    if (ref.current) {
      observer.observe(ref.current);
    }

    return () => {
      if (ref.current) {
        observer.unobserve(ref.current);
      }
    };
  }, [ref, options]);

  return inView;
};



// The system displays the flat array of card objects in chunks of three for desktop users.
const Carousel = ({ slides, title, sectionId }) => {
  // safeguard check for the slides prop
  if (!slides || !Array.isArray(slides) || slides.length === 0) {
    return null; 
  }
 
  const GROUP_SIZE = 3; // cards per view on desktop

  // Refs for scroll animation
  const titleRef = useRef(null);
  const carouselRef = useRef(null);
  const navRef = useRef(null);

  const titleInView = useIntersectionObserver(titleRef, { threshold: 0.1 });
  const carouselInView = useIntersectionObserver(carouselRef, { threshold: 0.2 });
  const navInView = useIntersectionObserver(navRef, { threshold: 0.1 });


  // Group cards into pages of 3
  const grouped = useMemo(() => {
    const chunks = [];
    // slides is guaranteed to be a non-empty array here due to the check above
    for (let i = 0; i < slides.length; i += GROUP_SIZE) {
      chunks.push(slides.slice(i, i + GROUP_SIZE));
    }
    return chunks;
  }, [slides]);

  const [currentSlide, setCurrentSlide] = useState(0); // index of group
  const totalGroups = grouped.length;
  const showNav = slides.length > GROUP_SIZE; // only if more than 3 cards total
  const autoplayInterval = useRef(null);

  const nextSlide = () => {
    setCurrentSlide((prev) => (prev < totalGroups - 1 ? prev + 1 : 0));
  };

  const prevSlide = () => {
    setCurrentSlide((prev) => (prev > 0 ? prev - 1 : totalGroups - 1));
  };

  const startAutoPlay = () => {
    stopAutoPlay();
    if (showNav) {
      autoplayInterval.current = setInterval(nextSlide, 4000);
    }
  };

  const stopAutoPlay = () => {
    clearInterval(autoplayInterval.current);
  };

  useEffect(() => {
    if (currentSlide >= totalGroups) setCurrentSlide(0);
  }, [totalGroups, currentSlide]);

  useEffect(() => {
    startAutoPlay();
    return () => stopAutoPlay();
  }, [showNav, totalGroups]);

  return (
    <section className="py-8 sm:py-12 lg:py-16 bg-gradient-to-b from-[#1a1a1a] to-dark-bg relative overflow-hidden" id={sectionId}>
      {/* Background decorative elements */}
      <div className="absolute inset-0 opacity-5 overflow-hidden">
        <div className="absolute top-16 sm:top-32 left-8 sm:left-20 w-20 sm:w-32 lg:w-40 h-20 sm:h-32 lg:h-40 bg-gradient-to-br from-primary-orange to-primary-yellow rounded-full blur-xl animate-pulse delay-300"></div>
        <div className="absolute bottom-16 sm:bottom-32 right-6 sm:right-16 w-16 sm:w-24 lg:w-32 h-16 sm:h-24 lg:h-32 bg-gradient-to-br from-primary-yellow to-primary-orange rounded-full blur-lg animate-pulse delay-1000"></div>
      </div>

      <div className="max-w-7xl mx-auto px-2 sm:px-4 lg:px-8 relative z-10">
        {title && (
          <div
            ref={titleRef} // Attach ref for title observation
            className={`
              text-center mb-8 sm:mb-10 transition-all duration-700 ease-out
              ${titleInView ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-10'}
            `}
          >
            <h2 className="text-2xl sm:text-3xl lg:text-4xl font-bold text-white mb-3 bg-gradient-to-r from-white via-primary-orange to-primary-yellow bg-clip-text text-transparent">
              {title}
            </h2>
            <div className="h-1 bg-gradient-to-r from-transparent via-primary-orange to-transparent mx-auto w-24 mb-3"></div>
            <p className="text-base sm:text-lg text-gray-300 max-w-3xl mx-auto leading-normal">
              Explore the core components of the Jaseci ecosystem
            </p>
          </div>
        )}
        
        <div
          ref={carouselRef} // Attach ref for carousel observation
          className={`
            relative **overflow-visible** transition-all duration-700 ease-out delay-200 // CHANGED: overflow-hidden to overflow-visible to prevent card popup clipping
            ${carouselInView ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-10'}
          `}
          onMouseEnter={stopAutoPlay}
          onMouseLeave={startAutoPlay}
        >
          <div
            className="flex transition-transform duration-500 ease-in-out"
            style={{ transform: `translateX(-${currentSlide * 100}%)` }}
          >
            {grouped.map((group, groupIndex) => (
              <div
                key={groupIndex}
                className="min-w-full flex flex-col lg:flex-row gap-6 lg:gap-8 px-2"
              >
                {group.map((card, cardIndex) => (
                  <div
                    key={cardIndex}
                    // --- Added Popup Effect ---
                    className="flex-1 bg-gradient-to-br from-dark-bg/80 via-dark-bg/60 to-dark-bg/80 backdrop-blur-sm rounded-xl border border-light-bg/20 p-6 sm:p-8 shadow-2xl transition-all duration-300 hover:border-primary-orange/50 hover:shadow-3xl hover:shadow-primary-orange/20 hover:scale-[1.02] hover:-translate-y-2 group mx-2 sm:mx-0"
                    // --- Increased shadow, added scale and translateY on hover ---
                  >
                    {/* Card Header */}
                    <div className="flex items-center gap-4 mb-4">
                      <div className="w-12 h-12 sm:w-14 sm:h-14 bg-gradient-to-br from-primary-orange/20 to-primary-yellow/20 backdrop-blur-sm rounded-xl border border-primary-orange/30 flex items-center justify-center text-2xl sm:text-3xl group-hover:scale-110 transition-transform duration-300">
                        {card.icon}
                      </div>
                      <div>
                        <h3 className="text-white font-bold text-lg sm:text-xl group-hover:text-primary-orange transition-colors duration-300">
                          {card.title}
                        </h3>
                      </div>
                    </div>

                    {/* Card Content */}
                    <p className="text-gray-300 text-sm sm:text-base leading-relaxed mb-6">
                      {card.description}
                    </p>

                    {/* Card Action */}
                    {card.link && (
                      <div className="flex justify-start">
                        <a
                          href={card.link}
                          target="_blank"
                          rel="noopener noreferrer"
                          className="inline-flex items-center justify-center px-4 py-2 bg-gradient-to-r from-primary-orange/20 to-primary-yellow/20 text-primary-orange font-medium rounded-lg border border-primary-orange/30 hover:bg-gradient-to-r hover:from-primary-orange hover:to-primary-yellow hover:text-white transition-all duration-300 transform hover:scale-105 text-sm"
                        >
                          {card.linkText}
                          <svg className="ml-2 w-4 h-4" fill="currentColor" viewBox="0 0 24 24">
                            <path d="M14,3V5H17.59L7.76,14.83L9.17,16.24L19,6.41V10H21V3M19,19H5V5H12V3H5C3.89,3 3,3.9 3,5V19A2,2 0 0,0 5,21H19A2,2 0 0,0 21,19V12H19V19Z" />
                          </svg>
                        </a>
                      </div>
                    )}
                  </div>
                ))}
              </div>
            ))}
          </div>

          {showNav && (
            <div 
              ref={navRef} // Attach ref for navigation observation
              className={`
                flex justify-center items-center gap-4 mt-8 transition-all duration-700 ease-out delay-300 // Added delay to follow carousel
                ${navInView ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-10'}
              `}
            >
              <button
                onClick={prevSlide}
                className="bg-gradient-to-r from-primary-orange to-primary-yellow text-white w-10 h-10 sm:w-12 sm:h-12 rounded-full flex items-center justify-center cursor-pointer transition-all duration-300 text-lg font-bold hover:scale-110 hover:shadow-lg hover:shadow-primary-orange/25"
                aria-label="Previous slides"
              >
                ‹
              </button>
              <div className="flex gap-2">
                {grouped.map((_, index) => (
                  <div
                    key={index}
                    onClick={() => setCurrentSlide(index)}
                    className={`w-2.5 h-2.5 sm:w-3 sm:h-3 rounded-full cursor-pointer transition-all duration-300 ${
                      currentSlide === index 
                        ? "bg-gradient-to-r from-primary-orange to-primary-yellow scale-125 shadow-lg shadow-primary-orange/50" 
                        : "bg-gray-600 hover:bg-gray-500"
                    }`}
                    aria-label={`Go to group ${index + 1}`}
                  />
                ))}
              </div>
              <button
                onClick={nextSlide}
                className="bg-gradient-to-r from-primary-orange to-primary-yellow text-white w-10 h-10 sm:w-12 sm:h-12 rounded-full flex items-center justify-center cursor-pointer transition-all duration-300 text-lg font-bold hover:scale-110 hover:shadow-lg hover:shadow-primary-orange/25"
                aria-label="Next slides"
              >
                ›
              </button>
            </div>
          )}
        </div>
      </div>

      {/* Removed unused @keyframes fadeInUp CSS */}
    </section>
  );
};

Carousel.propTypes = {
  slides: PropTypes.arrayOf(
    PropTypes.shape({
      icon: PropTypes.node,
      title: PropTypes.string.isRequired,
      description: PropTypes.string.isRequired,
      link: PropTypes.string,
      linkText: PropTypes.string,
    }),
  ).isRequired,
  title: PropTypes.string,
  sectionId: PropTypes.string,
};

export default Carousel;
