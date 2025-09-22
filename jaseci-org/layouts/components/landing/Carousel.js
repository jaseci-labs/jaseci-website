"use client";

import { useState, useEffect, useRef, useMemo } from "react";
import PropTypes from "prop-types";

// Carousel: expects a flat array of card objects; shows 3 at a time on desktop (chunked)
const Carousel = ({ slides, title, sectionId }) => {
  const GROUP_SIZE = 3; // cards per view on desktop

  // Group cards into pages of 3
  const grouped = useMemo(() => {
    const chunks = [];
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
    <section className="py-16" id={sectionId}>
      <div className="max-w-6xl mx-auto px-5">
        {title && (
          <h2 className="text-center text-4xl font-semibold mb-12">{title}</h2>
        )}
        <div
          className="relative overflow-hidden rounded-2xl pt-3.5"
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
                className="min-w-full flex flex-col md:flex-row gap-8 px-2.5"
              >
                {group.map((card, cardIndex) => (
                  <div
                    key={cardIndex}
                    className="flex-1 min-w-[280px] bg-medium-bg rounded-2xl p-8 md:p-10 text-center transition-all duration-300 border border-light-bg relative overflow-hidden group hover:-translate-y-2 hover:shadow-2xl"
                  >
                    <div className="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-primary-orange to-primary-yellow opacity-0 group-hover:opacity-100 transition-opacity duration-300" />
                    <div className="text-5xl mb-5">{card.icon}</div>
                    <h3 className="text-2xl font-semibold mb-4">
                      {card.title}
                    </h3>
                    <p className="text-dark-text mb-6 text-sm">
                      {card.description}
                    </p>
                    {card.link && (
                      <a
                        href={card.link}
                        className="card-link"
                        target="_blank"
                        rel="noopener noreferrer"
                      >
                        {card.linkText}
                      </a>
                    )}
                  </div>
                ))}
              </div>
            ))}
          </div>

          {showNav && (
            <div className="flex justify-center items-center gap-5 mt-8">
              <button
                onClick={prevSlide}
                className="bg-gradient-to-r from-primary-orange to-primary-yellow text-white w-11 h-11 rounded-full flex items-center justify-center cursor-pointer transition-transform duration-300 text-lg font-bold hover:scale-110"
                aria-label="Previous slides"
              >
                ‹
              </button>
              <div className="flex gap-2">
                {grouped.map((_, index) => (
                  <div
                    key={index}
                    onClick={() => setCurrentSlide(index)}
                    className={`w-3 h-3 rounded-full cursor-pointer transition-all duration-300 ${currentSlide === index ? "bg-gradient-to-r from-primary-orange to-primary-yellow scale-125" : "bg-gray-600"}`}
                    aria-label={`Go to group ${index + 1}`}
                  />
                ))}
              </div>
              <button
                onClick={nextSlide}
                className="bg-gradient-to-r from-primary-orange to-primary-yellow text-white w-11 h-11 rounded-full flex items-center justify-center cursor-pointer transition-transform duration-300 text-lg font-bold hover:scale-110"
                aria-label="Next slides"
              >
                ›
              </button>
            </div>
          )}
        </div>
      </div>
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
