/** @type {import('next').NextConfig} */
const nextConfig = {
  // You might have other configurations here
  reactStrictMode: true,
  
  // Enable standalone output for Docker production
  output: 'standalone',

  // Add the images configuration below
  images: {
    remotePatterns: [
      {
        protocol: "https",
        hostname: "www.jaseci.org",
        port: "",
        pathname: "/wp-content/uploads/**", // This is optional but recommended for security
      },
    ],
  },
};

module.exports = nextConfig;
