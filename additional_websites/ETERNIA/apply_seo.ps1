$content = Get-Content 'index.html' -Raw

# 1. Update Title and Meta Description
$content = [regex]::Replace($content, '(?si)<title>.*?</title>', '<title>Brigade Eternia Yelahanka | 3 &amp; 4 BHK Price, Plans &amp; Location</title>')
$content = [regex]::Replace($content, '(?si)<meta name="description".*?>', '<meta name="description" content="Discover Brigade Eternia in Yelahanka, North Bengaluru. Premium 3 &amp; 4 BHK lakeside apartments starting from &#8377;2.47 Cr*. Download brochure, floor plans &amp; pricing.">')

# 2. Inject JSON-LD Schema before </head>
$schema = @"
    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@type": "ApartmentComplex",
      "name": "Brigade Eternia",
      "description": "Premium 3 & 4 BHK lakeside apartments in Yelahanka, North Bengaluru.",
      "url": "https://brigadeeterniayelahanka.projectdetail.net/",
      "address": {
        "@type": "PostalAddress",
        "addressLocality": "Yelahanka",
        "addressRegion": "Bengaluru",
        "addressCountry": "IN"
      },
      "offers": {
        "@type": "Offer",
        "priceCurrency": "INR",
        "price": "24700000",
        "name": "Starting Price for 3 BHK"
      }
    }
    </script>
</head>
"@
$content = $content -replace '</head>', $schema

# 3. Update Headings
$content = [regex]::Replace($content, '(?si)<h1>Brigade Eternia</h1>', '<h1>Brigade Eternia Yelahanka, North Bengaluru</h1>')
$content = [regex]::Replace($content, '(?si)<h2 class="section-title">Transparent Pricing</h2>', '<h2 class="section-title">Project Price, Configurations & Carpet Area</h2>')
$content = [regex]::Replace($content, '(?si)<h2 class="section-title">Premium Lifestyle Amenities</h2>', '<h2 class="section-title">Brigade Eternia Amenities & Master Plan</h2>')
$content = [regex]::Replace($content, '(?si)<h2 class="section-title">Location & Connectivity</h2>', '<h2 class="section-title">Location Advantages & Connectivity in Yelahanka</h2>')

# 4. Carpet Area Matrix Table (CSS + HTML)
$tableStyle = @"
        .area-table {
            width: 100%;
            border-collapse: collapse;
            margin: 2rem 0;
            background: #fff;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            border-radius: 8px;
            overflow: hidden;
        }
        .area-table th, .area-table td {
            padding: 1rem;
            text-align: center;
            border: 1px solid var(--border-light);
        }
        .area-table th {
            background: var(--primary-dark);
            color: #fff;
            font-weight: 600;
        }
"@
# Inject style
$content = $content -replace '(?si)</style>', "$tableStyle`n    </style>"

$tableHtml = @"
              <div class="table-responsive" style="overflow-x: auto;">
                  <table class="area-table">
                      <thead>
                          <tr>
                              <th>Typology</th>
                              <th>Super Built-Up Area</th>
                              <th>Unit Carpet Area</th>
                              <th>Balcony Carpet Area</th>
                          </tr>
                      </thead>
                      <tbody>
                          <tr>
                              <td><strong>3 & 4 BHK Luxury Apartments</strong></td>
                              <td>65.06 to 271.84 Sq.m.<br><small>(700 to 2,926 Sq.ft.)</small></td>
                              <td>41.29 to 174.91 Sq.m.<br><small>(444 to 1,883 Sq.ft.)</small></td>
                              <td>3.50 to 4.48 Sq.m.<br><small>(38 to 48 Sq.ft.)</small></td>
                          </tr>
                      </tbody>
                  </table>
              </div>
"@
# Inject table below pricing grid
$content = [regex]::Replace($content, '(?si)(<div class="pricing-grid">.*?</div>\s*<div[^>]*>.*?</div>\s*)</div>\s*</section>', "`$1$tableHtml`n          </div>`n      </section>")

# 5. Add SEO Copy (Yelahanka Locality Advantages) before the Location Map
$seoCopy = @"
              <div class="seo-content" style="background: #fff; padding: 2rem; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); margin-bottom: 2rem;">
                  <h3 style="color: var(--primary-dark); margin-bottom: 1rem; font-family: 'Playfair Display', serif;">Why Yelahanka is the Ultimate Residential Destination in North Bengaluru</h3>
                  <p style="color: var(--text-dark); line-height: 1.8; margin-bottom: 1rem;">
                      Yelahanka, situated strategically in the rapidly expanding northern corridor of Bengaluru, has emerged as one of the most sought-after residential micro-markets for discerning homebuyers and savvy investors alike. The allure of Yelahanka lies in its seamless blend of heritage, expansive green layouts, and ultra-modern infrastructure. Unlike the congested central zones, Yelahanka offers broad, tree-lined avenues, serene lakes, and an elevated quality of life that is increasingly rare in urban centers. Brigade Eternia perfectly leverages this locale, offering a peaceful sanctuary that doesn't compromise on urban connectivity.
                  </p>
                  <p style="color: var(--text-dark); line-height: 1.8; margin-bottom: 1rem;">
                      One of the primary catalysts for Yelahanka’s booming real estate value is its unbeatable proximity to the <strong>Kempegowda International Airport (KIA)</strong>. For frequent flyers, business executives, and global trotters, the signal-free elevated expressway ensures airport access in under 20-30 minutes. Furthermore, the upcoming Namma Metro Phase 2B (Blue Line), connecting Silk Board to the Airport, will have dedicated stations in and around Yelahanka, promising a massive surge in capital appreciation and effortless daily commutes to core commercial zones.
                  </p>
                  <p style="color: var(--text-dark); line-height: 1.8;">
                      Beyond transit, Yelahanka is a self-sustained ecosystem. The region hosts a robust network of top-tier educational institutions (such as Canadian International School and Delhi Public School), world-class healthcare facilities, and vibrant retail spaces like RMZ Galleria Mall. With massive nearby tech hubs including Manyata Tech Park and the upcoming Aerospace Park drawing a massive workforce, properties in Yelahanka, particularly luxury enclaves like Brigade Eternia, present an incredible investment proposition offering high rental yields and long-term asset growth.
                  </p>
              </div>
"@
$content = [regex]::Replace($content, '(?si)(<div class="location-grid">)', "$seoCopy`n              `$1")

# 6. Legal & Trust Compliance (Footer Disclaimer)
$footerDisclaimer = @"
              <div class="footer-disclaimer" style="width: 100%; text-align: left; margin-top: 2rem; padding-top: 2rem; border-top: 1px solid rgba(255,255,255,0.1); font-size: 0.75rem; color: rgba(255,255,255,0.6); line-height: 1.6;">
                  <strong>Agent Disclaimer & Compliance:</strong> This website is maintained by an authorized channel partner / marketing agent for informational and marketing purposes only. It does not constitute the official developer website. Any information presented here, including but not limited to project details, specifications, floor plans, pricing, and images, is subject to change based on the developer's discretion and final approval. By using this website, you consent to our team contacting you via calls, SMS, or WhatsApp to share relevant real estate opportunities. <br><br>
                  <strong>RERA Registration:</strong> Brigade Eternia is registered under the Karnataka Real Estate Regulatory Authority (K-RERA). RERA No: <strong>[PRM/KA/RERA/XXXXX/XXXXX]</strong>. For more details, visit <a href="https://rera.karnataka.gov.in/" target="_blank" style="color: var(--accent-gold); text-decoration: underline;">rera.karnataka.gov.in</a>.
              </div>
"@
$content = [regex]::Replace($content, '(?si)</div>\s*</footer>', "`$1`n$footerDisclaimer`n    </footer>")

[System.IO.File]::WriteAllText('index.html', $content, [System.Text.Encoding]::UTF8)
