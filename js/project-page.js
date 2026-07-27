/* ============================================
   LUXURA HABITAT — Shared behavior for project detail pages
   (projects/<slug>/index.html)

   Each project page still calls these with its own existing
   selectors/options so visual behavior is unchanged page-to-page —
   this file only removes the duplicated *implementation*, so a bug
   fix here applies everywhere instead of needing twelve edits.
   ============================================ */

function getProjectPageNavEl() {
  return document.querySelector('.site-header')
      || document.querySelector('header')
      || document.querySelector('nav');
}

// Smooth-scroll anchor links, offset by the live height of whichever
// element is actually the fixed/sticky nav on this page, and update the
// URL hash via an absolute path so a <base href> tag can't hijack it into
// a full page navigation.
function initProjectPageSmoothScroll() {
  document.querySelectorAll('a[href^="#"]').forEach(function (anchor) {
    anchor.addEventListener('click', function (e) {
      var href = this.getAttribute('href');
      if (href === '#') return;
      var target = document.querySelector(href);
      if (!target) return;
      e.preventDefault();
      var nav = getProjectPageNavEl();
      var navHeight = nav ? nav.offsetHeight : 0;
      var targetTop = target.getBoundingClientRect().top + window.pageYOffset - navHeight - 12;
      window.scrollTo({ top: targetTop, behavior: 'smooth' });
      history.pushState(null, '', window.location.pathname + href);
    });
  });
}

// Scroll-reveal fade-in. `selector` matches each page's own existing
// reveal-target list so the set of elements that fade in is unchanged.
function initProjectPageScrollReveal(selector) {
  var revealTargets = document.querySelectorAll(selector);
  revealTargets.forEach(function (element, index) {
    element.classList.add('reveal');
    element.style.transitionDelay = (Math.min(index % 6, 4) * 45) + 'ms';
  });
  if ('IntersectionObserver' in window) {
    var observer = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          entry.target.classList.add('visible');
          observer.unobserve(entry.target);
        }
      });
    }, { threshold: 0.12 });
    revealTargets.forEach(function (el) { observer.observe(el); });
  } else {
    revealTargets.forEach(function (el) { el.classList.add('visible'); });
  }
}

// Active-nav-link highlighting synced to scroll position. `useReplaceState`
// matches whether a given page currently rewrites the URL hash as you
// scroll (only some pages do this today).
function initProjectPageActiveNav(options) {
  options = options || {};
  var linkSelector = options.linkSelector || '.nav-links a[href^="#"]';
  var useReplaceState = !!options.useReplaceState;
  var navLinks = Array.prototype.slice.call(document.querySelectorAll(linkSelector));
  var navSections = navLinks
    .map(function (a) { return document.querySelector(a.getAttribute('href')); })
    .filter(Boolean);

  function update() {
    var current = navSections.filter(function (section) {
      return section.getBoundingClientRect().top <= 140;
    }).pop();
    navLinks.forEach(function (a) {
      a.classList.toggle('active', !!(current && a.getAttribute('href') === '#' + current.id));
    });
    if (useReplaceState && current && window.scrollY > 0) {
      var hash = '#' + current.id;
      if (history.replaceState && window.location.hash !== hash) {
        var cleanUrl = window.location.pathname.replace(/\/index\.html$/i, '') + window.location.search + hash;
        history.replaceState(null, null, cleanUrl);
      }
    }
  }

  window.addEventListener('scroll', update);
  update();
}

// Nav box-shadow that appears once the page has scrolled. `disable: true`
// (Assetz Zen & Sato) means the nav's own CSS already handles its shadow,
// so this only needs to make sure no JS-driven shadow is ever applied.
function initProjectPageNavShadow(options) {
  options = options || {};
  var disable = !!options.disable;
  window.addEventListener('scroll', function () {
    var nav = document.querySelector('nav');
    if (!nav) return;
    if (disable) {
      nav.style.boxShadow = 'none';
    } else {
      nav.style.boxShadow = window.scrollY > 50
        ? '0 4px 14px rgba(0,0,0,0.12)'
        : '0 2px 8px rgba(0,0,0,0.08)';
    }
  });
}

// Track Zendesk widget engagement as a lead signal. Polls for `zE` since
// the widget script (loaded separately per page) initializes async and at
// varying speed depending on how each page embeds it.
(function () {
  var tries = 0;
  var poll = setInterval(function () {
    tries++;
    if (window.zE) {
      clearInterval(poll);
      zE('webWidget:on', 'chat:start', function () {
        if (window.gtag) gtag('event', 'zendesk_chat_start');
      });
      zE('webWidget:on', 'open', function () {
        if (window.gtag) gtag('event', 'zendesk_widget_open');
      });
    } else if (tries > 40) {
      clearInterval(poll);
    }
  }, 500);
})();

// Shared FAQ accordion toggle (Pattern A: button + schema.org microdata).
// Kept as a plain global so existing onclick="toggleFAQ(this)" markup
// keeps working unchanged.
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
