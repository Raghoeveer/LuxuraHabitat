$content = Get-Content 'index.html' -Raw

# 1. Update Pricing Cards Block using regex to avoid whitespace issues
$content = [regex]::Replace($content, '(?si)<div class="pricing-amount">&#8377;2\.25 Cr\* <span[^>]*>Onwards</span></div>\s*<div class="pricing-sub">1,573 - 2,714 Sq\.Ft</div>', '<div class="pricing-amount">&#8377;2.47 Cr* <span style="font-size:0.4em;font-weight:normal">Onwards</span></div>
                      <div class="pricing-sub">1,653 - 2,111 Sq.Ft</div>')

$content = [regex]::Replace($content, '(?si)<div class="pricing-amount">INR 2\.47 Crore Onwards\*</div>\s*<div class="pricing-sub">Available</div>', '<div class="pricing-amount">Price On Request</div>
                      <div class="pricing-sub">2,714 - 2,926 Sq.Ft</div>')

# 2. Update Floor Plan Prices (Wait, the previous floor plan prices also failed to replace!)
# Let's fix floor plans as well using more robust regex
$content = [regex]::Replace($content, '(?si)<div class="floor-size">1,653 Sq\.Ft</div>.*?<span class="detail-value">&#8377;2\.25 Cr\* Onwards</span>', '<div class="floor-size">1,653 Sq.Ft</div>
                          <div class="floor-details">
                              <div class="detail-item">
                                  <span class="detail-label">Price</span>
                                  <span class="detail-value">&#8377;2.47 Cr* Onwards</span>')

$content = [regex]::Replace($content, '(?si)<div class="floor-size">1,848 Sq\.Ft</div>.*?<span class="detail-value">&#8377;2\.40 Cr\* Onwards</span>', '<div class="floor-size">1,848 Sq.Ft</div>
                          <div class="floor-details">
                              <div class="detail-item">
                                  <span class="detail-label">Price</span>
                                  <span class="detail-value">Price On Request</span>')

$content = [regex]::Replace($content, '(?si)<div class="floor-size">1,915 Sq\.Ft</div>.*?<span class="detail-value">&#8377;2\.64 Cr\* Onwards</span>', '<div class="floor-size">1,915 Sq.Ft</div>
                          <div class="floor-details">
                              <div class="detail-item">
                                  <span class="detail-label">Price</span>
                                  <span class="detail-value">Price On Request</span>')

$content = [regex]::Replace($content, '(?si)<div class="floor-size">2,111 Sq\.Ft</div>.*?<span class="detail-value">&#8377;2\.94 Cr\* Onwards</span>', '<div class="floor-size">2,111 Sq.Ft</div>
                          <div class="floor-details">
                              <div class="detail-item">
                                  <span class="detail-label">Price</span>
                                  <span class="detail-value">Price On Request</span>')

$content = [regex]::Replace($content, '(?si)<div class="floor-type">3 BHK Apartment</div>.*?<div class="floor-size">2,714 Sq\.Ft</div>.*?<span class="detail-value">&#8377;3\.54 Cr\* Onwards</span>', '<div class="floor-type">4 BHK Apartment</div>
                          <div class="floor-size">2,714 Sq.Ft</div>
                          <div class="floor-details">
                              <div class="detail-item">
                                  <span class="detail-label">Price</span>
                                  <span class="detail-value">Price On Request</span>')

$content = [regex]::Replace($content, '(?si)<div class="floor-size">Available</div>.*?<span class="detail-value">INR 2\.47 Crore Onwards\*</span>', '<div class="floor-size">2,926 Sq.Ft</div>
                          <div class="floor-details">
                              <div class="detail-item">
                                  <span class="detail-label">Price</span>
                                  <span class="detail-value">Price On Request</span>')

[System.IO.File]::WriteAllText('index.html', $content, [System.Text.Encoding]::UTF8)
