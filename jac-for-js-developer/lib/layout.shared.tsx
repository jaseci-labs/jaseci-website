import { type BaseLayoutProps } from 'fumadocs-ui/layouts/shared';

export function baseOptions(): BaseLayoutProps {
  return {
    nav: {
      title: 'JAC for JS Developers',
      url: '/',
    },
    githubUrl: 'https://github.com/jaseci-labs/jaseci',
    links: [
      {
        text: 'Documentation',
        url: '/docs',
        active: 'nested-url',
      },
      {
        text: 'Jaseci Docs',
        url: 'https://docs.jaseci.org/',
        external: true,
      },
    ],
  };
}
