$content = Get-Content 'index.html' -Raw

# 1. Update Pricing Cards Block
$pricingCardsOld = @"
              <div class="pricing-grid">
                  <div class="pricing-card">
                      <h3>3 BHK</h3>
                      <div class="pricing-amount">&#8377;2.25 Cr* <span style="font-size:0.4em;font-weight:normal">Onwards</span></div>
                      <div class="pricing-sub">1,573 - 2,714 Sq.Ft</div>
                      <ul class="pricing-details">
                          <li>3 Bedrooms + 3 Toilets</li>
                          <li>Spacious Layouts</li>
                          <li>Premium Finishes</li>
                          <li>Premium Lifestyle Amenities</li>
                      </ul>
                      <button class="pricing-btn" onclick="document.getElementById('form').scrollIntoView({behavior:'smooth'})">Get Best Price</button>
                  </div>
  
                  <div class="pricing-card featured">
                      <h3>4 BHK</h3>
                      <div class="pricing-amount">INR 2.47 Crore Onwards*</div>
                      <div class="pricing-sub">Available</div>
                      <ul class="pricing-details">
                          <li>4 Bedrooms + 4 Toilets</li>
                          <li>Extravagant Living & Dining</li>
                          <li>Ultra Premium Finishes</li>
                          <li>Premium Lifestyle Amenities</li>
                      </ul>
                      <button class="pricing-btn" onclick="document.getElementById('form').scrollIntoView({behavior:'smooth'})">Enquire Now</button>
                  </div>
              </div>
"@

$pricingCardsNew = @"
              <div class="pricing-grid">
                  <div class="pricing-card">
                      <h3>3 BHK</h3>
                      <div class="pricing-amount">&#8377;2.47 Cr* <span style="font-size:0.4em;font-weight:normal">Onwards</span></div>
                      <div class="pricing-sub">1,653 - 2,111 Sq.Ft</div>
                      <ul class="pricing-details">
                          <li>3 Bedrooms + 3 Toilets</li>
                          <li>Spacious Layouts</li>
                          <li>Premium Finishes</li>
                          <li>Premium Lifestyle Amenities</li>
                      </ul>
                      <button class="pricing-btn" onclick="document.getElementById('form').scrollIntoView({behavior:'smooth'})">Get Best Price</button>
                  </div>
  
                  <div class="pricing-card featured">
                      <h3>4 BHK</h3>
                      <div class="pricing-amount">Price On Request</div>
                      <div class="pricing-sub">2,714 - 2,926 Sq.Ft</div>
                      <ul class="pricing-details">
                          <li>4 Bedrooms + 4 Toilets</li>
                          <li>Extravagant Living & Dining</li>
                          <li>Ultra Premium Finishes</li>
                          <li>Premium Lifestyle Amenities</li>
                      </ul>
                      <button class="pricing-btn" onclick="document.getElementById('form').scrollIntoView({behavior:'smooth'})">Enquire Now</button>
                  </div>
              </div>
"@
$content = $content.Replace($pricingCardsOld, $pricingCardsNew)

# 2. Update Floor Plan Prices & Details
# We'll just replace the specific incorrect values globally or within context
# 1653 sqft
$content = $content -replace '<div class="floor-size">1,653 Sq\.Ft</div>\s*<div class="floor-details">\s*<div class="detail-item">\s*<span class="detail-label">Price</span>\s*<span class="detail-value">&#8377;2\.25 Cr\* Onwards</span>', '<div class="floor-size">1,653 Sq.Ft</div>
                          <div class="floor-details">
                              <div class="detail-item">
                                  <span class="detail-label">Price</span>
                                  <span class="detail-value">&#8377;2.47 Cr* Onwards</span>'

# 1848 sqft
$content = $content -replace '<div class="floor-size">1,848 Sq\.Ft</div>\s*<div class="floor-details">\s*<div class="detail-item">\s*<span class="detail-label">Price</span>\s*<span class="detail-value">&#8377;2\.40 Cr\* Onwards</span>', '<div class="floor-size">1,848 Sq.Ft</div>
                          <div class="floor-details">
                              <div class="detail-item">
                                  <span class="detail-label">Price</span>
                                  <span class="detail-value">Price On Request</span>'

# 1915 sqft
$content = $content -replace '<div class="floor-size">1,915 Sq\.Ft</div>\s*<div class="floor-details">\s*<div class="detail-item">\s*<span class="detail-label">Price</span>\s*<span class="detail-value">&#8377;2\.64 Cr\* Onwards</span>', '<div class="floor-size">1,915 Sq.Ft</div>
                          <div class="floor-details">
                              <div class="detail-item">
                                  <span class="detail-label">Price</span>
                                  <span class="detail-value">Price On Request</span>'

# 2111 sqft
$content = $content -replace '<div class="floor-size">2,111 Sq\.Ft</div>\s*<div class="floor-details">\s*<div class="detail-item">\s*<span class="detail-label">Price</span>\s*<span class="detail-value">&#8377;2\.94 Cr\* Onwards</span>', '<div class="floor-size">2,111 Sq.Ft</div>
                          <div class="floor-details">
                              <div class="detail-item">
                                  <span class="detail-label">Price</span>
                                  <span class="detail-value">Price On Request</span>'

# 2714 sqft
$content = $content -replace '<div class="floor-type">3 BHK Apartment</div>\s*<div class="floor-size">2,714 Sq\.Ft</div>\s*<div class="floor-details">\s*<div class="detail-item">\s*<span class="detail-label">Price</span>\s*<span class="detail-value">&#8377;3\.54 Cr\* Onwards</span>', '<div class="floor-type">4 BHK Apartment</div>
                          <div class="floor-size">2,714 Sq.Ft</div>
                          <div class="floor-details">
                              <div class="detail-item">
                                  <span class="detail-label">Price</span>
                                  <span class="detail-value">Price On Request</span>'

# 2926 sqft
$content = $content -replace '<div class="floor-size">Available</div>\s*<div class="floor-details">\s*<div class="detail-item">\s*<span class="detail-label">Price</span>\s*<span class="detail-value">INR 2\.47 Crore Onwards\*</span>', '<div class="floor-size">2,926 Sq.Ft</div>
                          <div class="floor-details">
                              <div class="detail-item">
                                  <span class="detail-label">Price</span>
                                  <span class="detail-value">Price On Request</span>'

[System.IO.File]::WriteAllText('index.html', $content, [System.Text.Encoding]::UTF8)
