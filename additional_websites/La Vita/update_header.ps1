$content = Get-Content -Path "index.html" -Raw

# 1. Change nav background
$navPattern = "(?s)(nav\s*\{\s*background:\s*)rgba\([^)]+\)(.*?backdrop-filter:\s*blur\([^)]+\);\s*\})"
$content = $content -replace $navPattern, '${1}rgba(0, 86, 179, 0.98)$2'

# 2. Change .nav-links a color to white and hover to accent-warm
$navLinksPattern = "(?s)(\.nav-links\s*a\s*\{.*?color:\s*)#[0-9a-fA-F]+(.*?transition:.*?white-space:\s*nowrap;\s*\})\s*\.nav-links\s*a:hover\s*\{.*?\}\s*\.nav-links\s*a\.active\s*\{.*?\}"
$replacement = '${1}#ffffff$2
        .nav-links a:hover { color: var(--accent-warm); }
        .nav-links a.active { color: var(--accent-warm); }'
$content = $content -replace $navLinksPattern, $replacement

# 3. Mobile adjustments (max-width: 768px block)
# Make hamburger menu hidden, make nav-links display flex and scrollable
$mobileNavPattern = "(?s)(@media\s*\(\s*max-width:\s*768px\s*\)\s*\{\s*)nav\s*\{\s*padding-bottom:\s*0\.5rem;\s*\}(.*?).hamburger-menu\s*\{\s*display:\s*flex;\s*order:\s*3;\s*\}(.*?)\.nav-links\s*\{\s*display:\s*none;\s*position:\s*absolute;(.*?)\.nav-links\s*a:last-child\s*\{\s*border-bottom:\s*none;\s*\}"
$mobileNavReplacement = '${1}nav { padding: 0.5rem 1rem; flex-wrap: wrap; justify-content: space-between; }$2.hamburger-menu { display: none !important; }$3.nav-links { display: flex !important; position: static; background: transparent; flex-direction: row; gap: 1.2rem; padding: 0.5rem 0 0.2rem 0; box-shadow: none; z-index: 99; border-bottom: none; width: 100%; overflow-x: auto; -webkit-overflow-scrolling: touch; justify-content: flex-start; }
            .nav-links::-webkit-scrollbar { display: none; }
            .nav-links.active { display: flex; }
            .nav-links a { padding: 0; border-bottom: none; color: #ffffff; font-size: 0.85rem; }
            .nav-links a:last-child { border-bottom: none; }'
$content = $content -replace $mobileNavPattern, $mobileNavReplacement

# 4. Sticky header bottom override (max-width: 1024px or general layout fixes)
# It's under /* Sticky Header */
$stickyHeaderPattern = "(?s)(\/\*\s*Sticky Header\s*\*\/\s*nav\s*\{\s*position:\s*sticky;\s*top:\s*0;\s*z-index:\s*1000;\s*background:\s*)#fff(.*?box-shadow:.*?;\s*\})"
$stickyHeaderReplacement = '${1}rgba(0, 86, 179, 0.98)$2
        nav .logo img {
            filter: brightness(0) invert(1);
        }'
$content = $content -replace $stickyHeaderPattern, $stickyHeaderReplacement

# 5. Fix phone section color for dark background
$phoneSectionPattern = "(?s)(\.phone-section\s*\{.*?background:\s*)rgba\(11, 107, 60, 0\.08\)(.*?\})\s*\.phone-section:hover\s*\{\s*background:\s*rgba\(11, 107, 60, 0\.15\)(.*?\})\s*\.phone-label\s*\{.*?color:\s*)#6b7280(.*?\}\s*\.phone-number\s*\{.*?color:\s*)var\(--accent-green\)(.*?\}?)"
$phoneSectionReplacement = '${1}rgba(255, 255, 255, 0.15)$2
        .phone-section:hover { background: rgba(255, 255, 255, 0.25)$3
        .phone-label { font-size: clamp(0.6rem, 0.8vw, 0.75rem); color: #e2e8f0$4#ffffff$5'
$content = $content -replace $phoneSectionPattern, $phoneSectionReplacement

Set-Content -Path "index.html" -Value $content -NoNewline
