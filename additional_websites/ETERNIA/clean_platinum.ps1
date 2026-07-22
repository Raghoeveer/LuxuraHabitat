$content = Get-Content 'index.html' -Raw

# 1. Hero Badge
$content = $content -replace '<div class="hero-badge">IGBC Platinum Pre-Certified</div>', '<div class="hero-badge">A Legacy of Luxury</div>'

# 2. About section text
$content = $content -replace "As an IGBC Platinum Pre-Certified community, Brigade Eternia pioneers eco-conscious living. We've dedicated 85% of the property to open green spaces, seamlessly integrating over 1,000 native trees and smart home infrastructure including centralized RO water purification\.", 'Embracing sustainable design, Brigade Eternia features expansive green landscapes, smart energy features, and eco-friendly living environments.'
$content = $content -replace 'anchored by two spectacular Grand Clubhouses', 'anchored by a spectacular Signature Clubhouse'

# 3. Features list / Specs
$content = $content -replace 'IGBC Platinum Pre-Certified with 1000\+ trees\.', 'Designed with expansive green spaces.'
$content = $content -replace 'IGBC Platinum Pre-Certified infrastructure featuring centralized RO systems and advanced energy-efficient integrations throughout the property\.', 'Premium infrastructure featuring advanced energy-efficient integrations throughout the property.'

# 4. USP block
$content = $content -replace 'Platinum Green Living', 'Premium Green Living'
$content = $content -replace 'As an IGBC Platinum Pre-Certified project, Brigade Eternia boasts 1,000\+ native trees, smart energy features, and a centralized RO water system\.', 'Embracing sustainable design, Brigade Eternia boasts expansive green spaces, smart energy features, and premium eco-friendly living environments.'

# 5. Pricing card bullets
$content = $content -replace '<li>IGBC Platinum Pre-Certified</li>', '<li>Premium Lifestyle Amenities</li>'

# 6. Specs block
$content = $content -replace 'conforming to IGBC Platinum standards\.', 'conforming to the highest sustainability standards.'
$content = $content -replace 'Centralized RO water purification system, rainwater harvesting, and solar-powered common area lighting', 'Rainwater harvesting and solar-powered common area lighting'

# Also let's fix any lingering "1,000+ trees" and "1000+ trees"
$content = $content -replace '1,000\+ Trees', 'Lush Landscapes'
$content = $content -replace '1000\+ Trees', 'Lush Landscapes'
$content = $content -replace '1,000\+ trees', 'lush landscapes'
$content = $content -replace '1000\+ trees', 'lush landscapes'

# Fix lingering "85% open spaces" and "2 grand clubhouses" just in case they're elsewhere
$content = $content -replace '85% of the property to open green spaces', 'expansive areas to open green spaces'
$content = $content -replace 'two spectacular Grand Clubhouses', 'a spectacular Signature Clubhouse'
$content = $content -replace 'two Grand Clubhouses', 'a Signature Clubhouse'

[System.IO.File]::WriteAllText('index.html', $content, [System.Text.Encoding]::UTF8)
