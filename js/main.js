/* ============================================
   LUXURA HABITAT — Core JavaScript
   ============================================ */

document.addEventListener('DOMContentLoaded', () => {

  // Load shared structured data, social image and internal-link enhancements.
  const seoScript = document.createElement('script');
  seoScript.src = '/js/seo.js';
  seoScript.defer = true;
  document.head.appendChild(seoScript);

  // --- Scroll-Aware Header ---
  const header = document.querySelector('.site-header');
  if (header) {
    const onScroll = () => {
      header.classList.toggle('scrolled', window.scrollY > 40);
    };
    window.addEventListener('scroll', onScroll, { passive: true });
    onScroll();
  }

  // --- Mobile Navigation Toggle ---
  const navToggle = document.querySelector('.nav-toggle');
  const navLinks = document.querySelector('.nav-links');
  if (navToggle && navLinks) {
    navToggle.addEventListener('click', () => {
      navToggle.classList.toggle('active');
      navLinks.classList.toggle('open');
      document.body.style.overflow = navLinks.classList.contains('open') ? 'hidden' : '';
    });

    // Close on link click
    navLinks.querySelectorAll('a').forEach(link => {
      link.addEventListener('click', () => {
        navToggle.classList.remove('active');
        navLinks.classList.remove('open');
        document.body.style.overflow = '';
      });
    });

    // Close on backdrop click
    document.addEventListener('click', (e) => {
      if (navLinks.classList.contains('open') && !navLinks.contains(e.target) && !navToggle.contains(e.target)) {
        navToggle.classList.remove('active');
        navLinks.classList.remove('open');
        document.body.style.overflow = '';
      }
    });
  }

  // --- Scroll-Reveal Animations ---
  const animatedElements = document.querySelectorAll('.animate-on-scroll');
  if (animatedElements.length > 0) {
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('visible');
          observer.unobserve(entry.target);
        }
      });
    }, { threshold: 0.12, rootMargin: '0px 0px -40px 0px' });

    animatedElements.forEach(el => observer.observe(el));
  }

  // --- Active Nav Link ---
  const currentPath = window.location.pathname;
  document.querySelectorAll('.nav-links a:not(.nav-cta)').forEach(link => {
    const href = link.getAttribute('href');
    if (href === currentPath || (href !== '/' && currentPath.startsWith(href))) {
      link.classList.add('active');
    }
    if (href === '/' && (currentPath === '/' || currentPath.endsWith('index.html') && !currentPath.includes('areas') && !currentPath.includes('developers'))) {
      link.classList.add('active');
    }
  });

  // --- Contact Form Handling ---
  const contactForm = document.getElementById('contact-form');
  if (contactForm) {
    // Preserve the native Web3Forms submission; only clear local validation styling.
    contactForm.querySelectorAll('.form-control').forEach(field => {
      field.addEventListener('input', () => {
        field.style.borderColor = '';
      });
    });
  }

  // --- Smooth scroll for anchor links ---
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function(e) {
      const target = document.querySelector(this.getAttribute('href'));
      if (target) {
        e.preventDefault();
        target.scrollIntoView({ behavior: 'smooth', block: 'start' });
      }
    });
  });

  // --- Counter Animation for Stats ---
  const statNumbers = document.querySelectorAll('.stat-number[data-count]');
  if (statNumbers.length > 0) {
    const counterObserver = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          const el = entry.target;
          const target = parseInt(el.dataset.count, 10);
          const suffix = el.dataset.suffix || '';
          const duration = 1500;
          const step = target / (duration / 16);
          let current = 0;

          const updateCounter = () => {
            current += step;
            if (current < target) {
              el.textContent = Math.floor(current) + suffix;
              requestAnimationFrame(updateCounter);
            } else {
              el.textContent = target + suffix;
            }
          };
          updateCounter();
          counterObserver.unobserve(el);
        }
      });
    }, { threshold: 0.5 });

    statNumbers.forEach(el => counterObserver.observe(el));
  }

  // --- Blog Brochure Popup (fires after 10s of active reading) ---
  initBlogBrochurePopup();

});

function initBlogBrochurePopup() {
  var propertyCard = document.querySelector('.sidebar-property-card');
  if (!propertyCard) return;

  var GENERAL_CONTACT_ACCESS_KEY = 'e0360e8e-90c3-4eb2-89a6-8fb84be2f8de';
  var GENERAL_BLOG_PATHS = [
    '/blog/attibele-electronic-city-south-investment-guide/',
    '/blog/bangalore-metro-phase-3-property-value-impact/',
    '/blog/bangalore-real-estate-price-trends-2026/',
    '/blog/bannerghatta-road-south-bengaluru-investment-guide/',
    '/blog/devanahalli-real-estate-market-trends-2026/',
    '/blog/devanahalli-roi-land-appreciation-vs-rental-yield/',
    '/blog/doddaballapur-real-estate-investment-guide/',
    '/blog/festive-season-2026-bangalore-home-buying-guide/',
    '/blog/hennur-connectivity-orr-hebbal-metro-nagavara/',
    '/blog/hennur-thanisandra-real-estate-market-2026/',
    '/blog/housing-near-kiadb-aerospace-park-airport-road-bangalore/',
    '/blog/kanakapura-road-connectivity-nice-road-metro/',
    '/blog/kanakapura-road-real-estate-market-trends-2026/',
    '/blog/kanakapura-road-schools-family-lifestyle-guide/',
    '/blog/koyambedu-chennai-real-estate-investment-guide/',
    '/blog/kuthambakkam-tirumazhisai-chennai-real-estate-investment-guide/',
    '/blog/mangadu-porur-chennai-real-estate-investment-guide/',
    '/blog/manyata-tech-park-rental-yield-hennur-thanisandra/',
    '/blog/metro-blue-line-strr-impact-devanahalli/',
    '/blog/omr-chennai-villa-investment-guide-rental-yield/',
    '/blog/padur-omr-sea-view-apartments-guide/',
    '/blog/plots-near-coimbatore-golf-club-chettipalayam-guide/',
    '/blog/plots-vs-apartments-investment-bangalore/',
    '/blog/plots-vs-apartments-investment-coimbatore/',
    '/blog/purva-codename-skye-3bhk-vs-4bhk-study-configuration-guide/',
    '/blog/rbi-repo-rate-2026-home-loan-emi-guide/',
    '/blog/rera-2-0-what-homebuyers-need-to-know-2026/',
    '/blog/sriperumbudur-oragadam-plot-investment-guide/',
    '/blog/top-upcoming-luxury-apartments-yelahanka-2026/',
    '/blog/villament-vs-apartment-vs-villa-bangalore/',
    '/blog/villas-in-navalur-omr-siruseri-commute-guide/',
    '/blog/villas-vs-apartments-north-bengaluru-yelahanka/',
    '/blog/why-invest-in-bagalur-main-road-real-estate/',
    '/blog/why-invest-in-budigere-cross-real-estate/',
    '/blog/why-invest-in-nelamangala-tumkur-road-real-estate/',
    '/blog/why-invest-mysore-road-hejjala-real-estate/',
    '/blog/yelahanka-bellary-road-manyata-tech-park-connectivity-guide/',
    '/blog/yelahanka-family-guide-top-schools-lifestyle/',
    '/blog/yelahanka-namma-metro-blue-line-impact/',
    '/blog/yelahanka-vs-yelahanka-new-town-investment/'
  ];

  var isGeneral = GENERAL_BLOG_PATHS.indexOf(window.location.pathname) !== -1;

  var PROJECT_ACCESS_KEYS = {
    '/projects/assetz-meru-meadows/': '279d458e-2b55-447e-8bf2-d2045a5785be',
    '/projects/assetz-mizu-and-ki/': '34b1143d-68a7-4986-938f-e53f058dbaa8',
    '/projects/assetz-palmscape/': '96085fb1-ee18-4b8c-86a6-a274170bdc6f',
    '/projects/assetz-zen-sato/': '32c071b5-855b-4346-b783-55a84f00aca2',
    '/projects/brigade-eternia/': '66e56681-a1b1-4395-a293-d94094e999b1',
    '/projects/brigade-jeevan-sandhya/': '80b578b2-eca2-43c6-a08c-755ed69c9562',
    '/projects/century-astoria/': 'a41ede52-e0aa-4c13-aa7f-cfd3676bb911',
    '/projects/century-kindle/': 'a41ede52-e0aa-4c13-aa7f-cfd3676bb911',
    '/projects/chennai/godrej-azure/': '7d8c2efc-a81b-4871-9d20-2407b772b4cc',
    '/projects/chennai/radiance-edgewood/': 'eca8dc5d-504f-4feb-a9a1-9f74bddf1c86',
    '/projects/chennai/shriram-122-west/': 'eca8dc5d-504f-4feb-a9a1-9f74bddf1c86',
    '/projects/chennai/shriram-codename-10x/': '8c1a88ab-d186-46d7-aac0-9849498df092',
    '/projects/chennai/shriram-codename-pudhiya-chennai/': 'eca8dc5d-504f-4feb-a9a1-9f74bddf1c86',
    '/projects/chennai/shriram-kinglife-koyambedu/': '9b968d45-09e7-45c8-b19d-60a2de9ebd26',
    '/projects/chennai/shriram-shankari/': 'eca8dc5d-504f-4feb-a9a1-9f74bddf1c86',
    '/projects/coimbatore/godrej-plots-coimbatore/': 'ee9b19b8-af24-4212-87b6-a66294d568a3',
    '/projects/concorde-neo/': 'c6eda406-8588-421e-af25-461743b3179e',
    '/projects/concorde-sienna/': 'e00eb13b-f1a4-49cc-ac16-33e6b4ca8dcb',
    '/projects/divyasree-quiet-side/': '04fc40f6-ab86-46b1-93f2-494ad7117568',
    '/projects/goyal-riviera-glade/': 'e1cf0499-d40f-426f-baf8-59023e63be50',
    '/projects/kns-samooha/': 'ebb7d6a7-6f74-4c78-943e-129e00c3a268',
    '/projects/kns-sampada/': '8d599447-ffa5-4e12-8e10-69d41bfe0e2a',
    '/projects/orchid-salisbury/': 'ad01464c-7fb7-49dd-af0e-bbde628b71a6',
    '/projects/park-cubix/': '18f2ff46-8221-476c-85a0-dda60a13f358',
    '/projects/purva-codename-skye/': 'f6cde344-a193-40a8-8b47-b66f24d55f9f',
    '/projects/purva-hallmark/': 'cd498e23-5c73-459c-bc6f-2e31a790d89f',
    '/projects/sattva-aeropolis/': 'a41ede52-e0aa-4c13-aa7f-cfd3676bb911',
    '/projects/sattva-forest-ridge/': 'a832d04e-8138-4d22-808c-d504c22f02f6',
    '/projects/sattva-green-groves/': 'fbb07716-bda4-45c9-96cc-76286a94dc08',
    '/projects/sattva-la-vita/': '6e79c430-ddd9-4967-aae9-ae056d8a4134',
    '/projects/sattva-lumina/': '3faa65bd-b289-41d9-857a-0b5feec9ec3d',
    '/projects/sattva-songbird/': 'a41ede52-e0aa-4c13-aa7f-cfd3676bb911',
    '/projects/sattva-thippapura/': 'a7b4dbfa-7d56-43c3-929d-cc7821f47fcd',
    '/projects/shriram-107-south-east/': 'd925a130-8cbe-432a-adfd-674dbd3ffe7a',
    '/projects/shriram-codename-reserve/': '3725b95c-adea-44f6-a152-c625b988cff7',
    '/projects/surya-valencia/': 'b745b3a2-d7ea-48e6-b6b5-a3646e09e13c',
    '/projects/tvs-emerald-altura/': 'b6e5401b-c830-4fa3-810c-a015ea37a060',
    '/projects/vajram-chrysanthemum/': '888b1b66-5412-48e0-88f8-f85dcea2e9a0',
    '/projects/vajram-vivera/': 'b3ea5464-ddde-4fdf-b9a5-ed31e81cbf9b',
    '/projects/vasanta-cove/': '79c68ad5-36dd-4431-908b-2bfb6b88d1b8',
    '/projects/vasanta-skye/': 'aaab9e59-b216-46b6-bfcc-bd5835d8fc3e',
    '/projects/wonder-woods/': 'cc2defb1-1801-4b4f-9536-acd9e7069eb6'
  };

  var accessKey, projectName, imageSrc, popupTitle, popupSubtitle, subjectPrefix;

  if (isGeneral) {
    accessKey = GENERAL_CONTACT_ACCESS_KEY;
    projectName = '';
    imageSrc = '';
    popupTitle = 'Get a Free Real Estate Consultation';
    popupSubtitle = 'Share your details and one of our advisors will call you back to help you find the right property for your needs.';
    subjectPrefix = 'General Callback Request';
  } else {
    var ctaLink = propertyCard.querySelector('.sidebar-cta[href]');
    if (!ctaLink) return;

    var rawHref = ctaLink.getAttribute('href') || '';
    var projectMatch = rawHref.match(/\/projects\/.*$/);
    var projectHref = projectMatch ? projectMatch[0] : rawHref;
    accessKey = PROJECT_ACCESS_KEYS[projectHref];
    if (!accessKey) return;

    var nameEl = propertyCard.querySelector('.sidebar-property-name');
    projectName = nameEl ? nameEl.textContent.trim() : 'This Project';
    var projectImg = propertyCard.querySelector('img');
    imageSrc = projectImg ? projectImg.getAttribute('src') : '';
    popupTitle = 'Receive a Callback About ' + projectName;
    popupSubtitle = 'Share your details and one of our advisors will call you back with pricing, floor plans and RERA details.';
    subjectPrefix = 'Callback Request: ' + projectName;
  }

  try {
    if (localStorage.getItem('lh_brochure_submitted') === 'true') return;
    var lastShown = parseInt(localStorage.getItem('lh_brochure_last_shown') || '0', 10);
    if (Date.now() - lastShown < 24 * 60 * 60 * 1000) return;
  } catch (e) {}

  var visibleSeconds = 0;
  var READ_THRESHOLD = 10;
  var timer = setInterval(function () {
    if (document.visibilityState === 'visible') {
      visibleSeconds += 1;
      if (visibleSeconds >= READ_THRESHOLD) {
        clearInterval(timer);
        showBrochurePopup();
      }
    }
  }, 1000);

  function showBrochurePopup() {
    try { localStorage.setItem('lh_brochure_last_shown', String(Date.now())); } catch (e) {}

    var overlay = document.createElement('div');
    overlay.className = 'blog-brochure-overlay';
    overlay.innerHTML =
      '<div class="blog-brochure-popup" role="dialog" aria-modal="true" aria-label="' + popupTitle + '">' +
        '<button type="button" class="blog-brochure-popup-close" aria-label="Close">✕</button>' +
        (imageSrc ? '<img src="' + imageSrc + '" alt="' + projectName + '" class="blog-brochure-popup-image">' : '') +
        '<div class="blog-brochure-popup-body">' +
          '<p class="blog-brochure-popup-eyebrow">Still Reading?</p>' +
          '<h3 class="blog-brochure-popup-title">' + popupTitle + '</h3>' +
          '<p class="blog-brochure-popup-subtitle">' + popupSubtitle + '</p>' +
          '<form class="blog-brochure-popup-form">' +
            '<div class="form-group">' +
              '<label>Full Name</label>' +
              '<input type="text" name="name" required placeholder="Your name">' +
            '</div>' +
            '<div class="form-group">' +
              '<label>Phone Number</label>' +
              '<input type="tel" name="phone" required placeholder="+91 XXXXX XXXXX">' +
            '</div>' +
            '<div class="form-group">' +
              '<label>Email Address</label>' +
              '<input type="email" name="email" required placeholder="your.email@example.com">' +
            '</div>' +
            '<button type="submit" class="blog-brochure-popup-submit">Request a Callback</button>' +
            '<div class="blog-brochure-popup-message"></div>' +
          '</form>' +
        '</div>' +
      '</div>';
    document.body.appendChild(overlay);
    requestAnimationFrame(function () { overlay.classList.add('active'); });

    function closePopup() {
      overlay.classList.remove('active');
      setTimeout(function () { overlay.remove(); }, 300);
      document.removeEventListener('keydown', escHandler);
    }

    function escHandler(e) {
      if (e.key === 'Escape') closePopup();
    }

    overlay.querySelector('.blog-brochure-popup-close').addEventListener('click', closePopup);
    overlay.addEventListener('click', function (e) {
      if (e.target === overlay) closePopup();
    });
    document.addEventListener('keydown', escHandler);

    var form = overlay.querySelector('.blog-brochure-popup-form');
    form.addEventListener('submit', function (e) {
      e.preventDefault();
      var submitBtn = form.querySelector('button[type="submit"]');
      submitBtn.disabled = true;
      submitBtn.textContent = 'Sending...';

      var formData = new FormData();
      formData.append('access_key', accessKey);
      formData.append('name', form.querySelector('[name="name"]').value);
      formData.append('phone', form.querySelector('[name="phone"]').value);
      formData.append('email', form.querySelector('[name="email"]').value);
      formData.append('subject', subjectPrefix + ' (Blog Popup)');
      formData.append('source', 'Blog 45s Popup: ' + window.location.pathname);

      var messageDiv = form.querySelector('.blog-brochure-popup-message');

      fetch('https://api.web3forms.com/submit', { method: 'POST', body: formData })
        .then(onSuccess)
        .catch(onSuccess);

      function onSuccess() {
        if (typeof gtag === 'function') {
          gtag('event', 'conversion', { send_to: 'AW-16631805949/ZHJcCIKfouQcEP3v1Po9' });
        }
        try { localStorage.setItem('lh_brochure_submitted', 'true'); } catch (e) {}
        messageDiv.textContent = '✓ Thank you! Our advisor will call you back shortly.';
        messageDiv.className = 'blog-brochure-popup-message success';
        form.reset();
        setTimeout(closePopup, 2500);
      }
    });
  }
}

// Shared FAQ accordion toggle (Pattern A: button + schema.org microdata).
// Kept as a plain global so onclick="toggleFAQ(this)" markup works on any
// page that loads main.js, not just project pages (see js/project-page.js).
function toggleFAQ(btn) {
  var answer = btn.nextElementSibling;
  var isOpen = answer.classList.contains('open');
  document.querySelectorAll('.faq-answer.open').forEach(function (a) { a.classList.remove('open'); });
  document.querySelectorAll('.faq-question.open').forEach(function (b) {
    b.classList.remove('open');
    b.setAttribute('aria-expanded', 'false');
  });
  if (!isOpen) {
    answer.classList.add('open');
    btn.classList.add('open');
    btn.setAttribute('aria-expanded', 'true');
  }
}
