$file = 'c:\websites_vs\New folder\La Vita\index.html'
$html = Get-Content $file -Raw

$seoHtml = @'
    <!-- SEO Long-Form Content Section -->
    <section class="seo-guide" id="buyers-guide" style="padding: 5rem 1rem; background: #f8fafc;">
        <div class="container" style="max-width: 900px;">
            <h2 class="section-title">Expert Insights & Buyer's Guide</h2>
            <p class="section-subtitle">Deep dive into real estate trends and make an informed investment decision.</p>

            <div class="accordion-container" style="margin-top: 3rem; display: flex; flex-direction: column; gap: 1.5rem;">
                
                <details class="seo-accordion" open>
                    <summary class="seo-accordion-header">
                        <h3>Why Hennur Road is Bangalore's Premier Investment Hub</h3>
                        <span class="seo-icon">+</span>
                    </summary>
                    <div class="seo-accordion-content">
                        <p>Hennur Road has rapidly transformed from a quiet suburban stretch into one of North Bangalore’s most dynamic and sought-after real estate micro-markets. The driving force behind this metamorphosis is a master-planned combination of infrastructure development, strategic connectivity, and commercial expansion.</p>
                        
                        <h4>Strategic Connectivity & Infrastructure</h4>
                        <p>At the heart of Hennur’s appeal is its unparalleled connectivity. The expansion of the <strong>New Airport Link Road</strong> ensures that the Kempegowda International Airport (KIA) is accessible within an effortless drive, bypassing the traditional bottlenecks of the city. Furthermore, the upcoming <strong>Peripheral Ring Road (PRR)</strong> and the widening of the Hennur Main Road to a four-lane highway are set to drastically reduce commute times to prime city centers. By seamlessly linking Bellary Road, Old Madras Road, and Hoskote, the PRR positions Hennur as a central node in North Bangalore’s transport network.</p>

                        <h4>Proximity to Global Tech Corridors</h4>
                        <p>For professionals, Hennur offers the perfect balance of proximity to work and serene living. It is strategically positioned just minutes away from <strong>Manyata Tech Park</strong>, one of Asia’s largest IT ecosystems housing global giants like IBM, Cognizant, and Target. Additionally, the fast-developing <strong>KIADB Aerospace Park</strong> and the Bagalur IT SEZ are drawing a highly affluent demographic of executives and tech professionals to the area. This influx of high-net-worth individuals ensures a steady, premium rental demand and robust tenant quality.</p>

                        <h4>High Capital Appreciation</h4>
                        <p>Historical data indicates that real estate along the Hennur-Bagalur corridor has consistently outperformed the city average in terms of Year-over-Year (YoY) capital appreciation. Unlike saturated markets in East or South Bangalore, Hennur offers a distinct first-mover advantage for luxury properties. Investing in an exclusive gated community like Sattva La Vita secures a high-value asset at a competitive price point, with projections indicating double-digit appreciation as major infrastructure milestones are completed.</p>

                        <h4>A Holistic Ecosystem</h4>
                        <p>Beyond concrete and roads, Hennur boasts a mature social infrastructure. Renowned educational institutions such as Vidyashilp Academy, Canadian International School, and Stonehill International School are in the immediate vicinity. Healthcare is covered by top-tier facilities like Aster CMI and Cytecare. With the Bhartiya City Centre and vibrant retail avenues springing up, residents enjoy a complete, self-sustained lifestyle.</p>
                    </div>
                </details>

                <details class="seo-accordion">
                    <summary class="seo-accordion-header">
                        <h3>Luxury Row Houses vs. High-Rise Apartments: The Ultimate Comparison</h3>
                        <span class="seo-icon">+</span>
                    </summary>
                    <div class="seo-accordion-content">
                        <p>When upgrading to a luxury lifestyle, homebuyers frequently debate between premium high-rise apartments and exclusive row houses. While both offer distinct advantages, 4 BHK Row House Villas like those at Sattva La Vita provide a unique value proposition that apartments simply cannot replicate.</p>
                        
                        <h4>Uncompromised Privacy and Space</h4>
                        <p>The most significant advantage of a row house is the absolute privacy it affords. Unlike apartments where you share ceilings, floors, and common corridors with neighbors, a row house gives you an independent multi-level sanctuary. With no shared walls on the vertical axis, you eliminate overhead noise completely. Furthermore, row houses traditionally come with a private backyard or garden space—an architectural luxury that a typical apartment balcony cannot compete with.</p>

                        <h4>Higher Undivided Share of Land (UDS)</h4>
                        <p>From a financial and investment perspective, the Undivided Share of Land (UDS) is the most critical metric. The true appreciating asset in real estate is the land itself, while the constructed building depreciates over time. Row houses typically offer a significantly higher UDS compared to high-rise apartments. Because row house developments have a lower population density and fewer units per acre, you technically "own" a larger piece of the earth, leading to much higher long-term resale value and capital appreciation.</p>

                        <h4>Bespoke Living with Community Perks</h4>
                        <p>Independent villas often suffer from a lack of community and high individual maintenance costs. Row houses bridge this gap perfectly. You enjoy the grandeur and independence of a villa, while still having access to world-class clubhouse amenities—swimming pools, gymnasiums, and manicured parks—maintained collectively by the association. It is the perfect hybrid of independent living and community convenience.</p>

                        <h4>Customization Freedom</h4>
                        <p>In a high-rise apartment, structural changes and exterior modifications are strictly prohibited by building codes and society rules. A row house grants homeowners far greater flexibility to customize their internal layouts, landscape their private gardens, and truly personalize their living space to reflect their unique tastes.</p>
                    </div>
                </details>

            </div>
        </div>
    </section>

    <section class="lead-form-section" id="form">
'@

$oldPattern = '(?i)<section class="lead-form-section" id="form">'
$html = [regex]::Replace($html, $oldPattern, $seoHtml)

$css = @'
        /* SEO Accordion Styles */
        .seo-accordion {
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0,0,0,0.02);
            transition: all 0.3s ease;
        }
        .seo-accordion[open] {
            box-shadow: 0 10px 25px rgba(0,0,0,0.06);
            border-color: var(--accent-green);
        }
        .seo-accordion-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1.5rem;
            cursor: pointer;
            background: #fff;
            list-style: none;
            transition: background 0.3s ease;
        }
        .seo-accordion-header::-webkit-details-marker {
            display: none;
        }
        .seo-accordion-header:hover {
            background: #f8fafc;
        }
        .seo-accordion-header h3 {
            margin: 0;
            font-size: 1.2rem;
            color: var(--primary-dark);
            font-family: 'Playfair Display', serif;
            padding-right: 1rem;
            line-height: 1.4;
        }
        .seo-icon {
            font-size: 1.8rem;
            font-weight: 300;
            color: var(--accent-green);
            transition: transform 0.3s ease;
        }
        .seo-accordion[open] .seo-icon {
            transform: rotate(45deg);
        }
        .seo-accordion-content {
            padding: 0 1.5rem 1.5rem 1.5rem;
            color: #475569;
            line-height: 1.8;
            font-size: 0.95rem;
            border-top: 1px solid #f1f5f9;
            margin-top: 0.5rem;
            padding-top: 1.5rem;
        }
        .seo-accordion-content h4 {
            color: var(--primary-dark);
            margin: 1.5rem 0 0.5rem 0;
            font-size: 1.05rem;
        }
        .seo-accordion-content p {
            margin-bottom: 1rem;
        }
        .seo-accordion-content p:last-child {
            margin-bottom: 0;
        }
    </style>
'@

$html = $html -replace '</style>', $css

Set-Content $file -Value $html
