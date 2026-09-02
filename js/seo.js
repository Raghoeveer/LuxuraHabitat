/* Page-specific SEO metadata and internal-link clusters for Luxura Habitat. */
(() => {
  const origin = 'https://luxurahabitat.com';
  const path = window.location.pathname.replace(/index\.html$/, '').replace(/\/+/g, '/');
  const canonical = `${origin}${path.endsWith('/') ? path : `${path}/`}`;
  const hubByPath = path.includes('hennur') || path.includes('thanisandra') || path.includes('orchid-salisbury')
    ? 'hennur' : path.includes('devanahalli') || path.includes('aeropolis') || path.includes('palmscape') || path.includes('metro-blue-line')
      ? 'devanahalli' : 'yelahanka';
  const clusters = {
    hennur: {
      name: 'Hennur–Thanisandra', hub: '/areas/hennur/',
      projects: [['Goyal Orchid Salisbury', '/projects/orchid-salisbury/'], ['Sattva La Vita', '/projects/sattva-la-vita/']],
      articles: [['Market trends', '/blog/hennur-thanisandra-real-estate-market-2026/'], ['Manyata rental yields', '/blog/manyata-tech-park-rental-yield-hennur-thanisandra/'], ['Connectivity guide', '/blog/hennur-connectivity-orr-hebbal-metro-nagavara/'], ['Project comparison', '/blog/orchid-salisbury-vs-sattva-la-vita-hennur/']]
    },
    devanahalli: {
      name: 'Devanahalli', hub: '/areas/devanahalli/',
      projects: [['Assetz Palmscape', '/projects/assetz-palmscape/'], ['Sattva Aeropolis', '/projects/sattva-aeropolis/'], ['Sattva City', '/projects/sattva-city/']],
      articles: [['Market trends', '/blog/devanahalli-real-estate-market-trends-2026/'], ['ROI guide', '/blog/devanahalli-roi-land-appreciation-vs-rental-yield/'], ['Metro & STRR impact', '/blog/metro-blue-line-strr-impact-devanahalli/'], ['Project comparison', '/blog/assetz-palmscape-vs-sattva-aeropolis-devanahalli/']]
    },
    yelahanka: {
      name: 'Yelahanka', hub: '/areas/yelahanka/',
      projects: [['Assetz Zen & Sato', '/projects/assetz-zen-sato/'], ['Brigade Eternia', '/projects/brigade-eternia/'], ['Concorde Mayfair', '/projects/concorde-mayfair/']],
      articles: [['Luxury apartment guide', '/blog/top-upcoming-luxury-apartments-yelahanka-2026/'], ['Family & lifestyle guide', '/blog/yelahanka-family-guide-top-schools-lifestyle/'], ['Metro Blue Line impact', '/blog/yelahanka-namma-metro-blue-line-impact/'], ['Yelahanka vs New Town', '/blog/yelahanka-vs-yelahanka-new-town-investment/']]
    }
  };
  const cluster = clusters[hubByPath];
  const h1 = document.querySelector('h1')?.textContent.trim() || document.title.replace(/\s*\|.*$/, '');
  const image = document.querySelector('meta[property="og:image"]')?.content || document.querySelector('main img, article img, img')?.src || `${origin}/images/hero/hero_bg.png`;
  const addJsonLd = data => {
    const node = document.createElement('script');
    node.type = 'application/ld+json';
    node.textContent = JSON.stringify(data);
    document.head.appendChild(node);
  };
  const ensureMeta = (property, content) => {
    if (document.querySelector(`meta[property="${property}"]`)) return;
    const node = document.createElement('meta'); node.setAttribute('property', property); node.content = content; document.head.appendChild(node);
  };
  ensureMeta('og:image', image);
  ensureMeta('og:url', canonical);
  const crumbs = [{ '@type': 'ListItem', position: 1, name: 'Home', item: `${origin}/` }];
  if (path.startsWith('/areas/')) crumbs.push({ '@type': 'ListItem', position: 2, name: 'Areas', item: `${origin}/areas/` });
  else if (path.startsWith('/blog/')) crumbs.push({ '@type': 'ListItem', position: 2, name: 'Blog', item: `${origin}/blog/` });
  else if (path.startsWith('/projects/')) crumbs.push({ '@type': 'ListItem', position: 2, name: 'Projects', item: `${origin}/projects/` });
  // City-prefixed pages (/projects/<city>/<slug>/ or /areas/<city>/<locality>/) are one
  // segment deeper than the existing flat Bangalore pattern (/projects/<slug>/). Insert
  // the city itself as its own crumb only in that 3-segment case, so already-shipped
  // 2-segment pages are unaffected.
  const segments = path.split('/').filter(Boolean);
  if (segments.length === 3 && (path.startsWith('/projects/') || path.startsWith('/areas/'))) {
    const citySlug = segments[1];
    const cityName = citySlug.replace(/-/g, ' ').replace(/\b\w/g, c => c.toUpperCase());
    crumbs.push({ '@type': 'ListItem', position: crumbs.length + 1, name: cityName, item: `${origin}/${segments[0]}/${citySlug}/` });
  }
  crumbs.push({ '@type': 'ListItem', position: crumbs.length + 1, name: h1, item: canonical });
  addJsonLd({ '@context': 'https://schema.org', '@type': 'BreadcrumbList', itemListElement: crumbs });
  if (path.startsWith('/blog/') && path !== '/blog/') {
    addJsonLd({ '@context': 'https://schema.org', '@type': 'BlogPosting', headline: h1, mainEntityOfPage: { '@type': 'WebPage', '@id': canonical }, image: [image], datePublished: '2026-07-22', dateModified: '2026-07-22', author: { '@type': 'Person', name: 'Narayanan Rajesh', url: `${origin}/about/` }, publisher: { '@type': 'Organization', name: 'Luxura Habitat', url: `${origin}/`, logo: { '@type': 'ImageObject', url: `${origin}/images/logos/company_logo.png` } } });
  }
  // Dynamic HTML cluster injection removed: 
  // We now use hardcoded, fully-styled HTML cards (project-footer-strip & explore-cluster)
  // in the actual index.html files instead of relying on this unstyled JS injection.
})();
