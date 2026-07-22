$file = 'c:\websites_vs\New folder\La Vita\index.html'
$html = Get-Content $file -Raw

# We need to replace from the end of the #units section to the end of the location section
$oldPattern = '(?s)</section>\s*<div class="container">\s*<h2 class="section-title">Location</h2>.*?</section>'

$newContent = '</section>

    <section class="pricing" id="pricing" style="padding: 4rem 1rem; background: var(--bg-white);">
        <div class="container">
            <h2 class="section-title">Price</h2>
            <p class="section-subtitle">Exclusive pricing for Sattva La Vita</p>

            <div class="pricing-table-wrap" style="max-width: 800px; margin: 0 auto; box-shadow: 0 10px 30px rgba(0,0,0,0.08); border-radius: 12px; overflow: hidden; background: #fff;">
                <table class="pricing-table" style="margin: 0; width: 100%;">
                    <thead>
                        <tr>
                            <th style="padding: 1.5rem; text-align: center;">Configuration</th>
                            <th style="padding: 1.5rem; text-align: center;">Villa Type</th>
                            <th style="padding: 1.5rem; text-align: center;">Pricing</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td style="padding: 1.5rem; text-align: center; font-weight: 700; color: var(--primary-dark); font-size: 1.1rem;">4 BHK</td>
                            <td style="padding: 1.5rem; text-align: center; color: var(--text-dark);">Luxury Row House Villas</td>
                            <td style="padding: 1.5rem; text-align: center;"><a href="https://wa.me/918438344093?text=Hi%20I%20would%20like%20to%20know%20the%20price%20for%20Sattva%20La Vita" target="_blank" rel="noopener" style="background: var(--accent-warm); color: #fff; padding: 0.6rem 1.2rem; border-radius: 6px; text-decoration: none; font-weight: 600; display: inline-block; transition: background 0.3s;">On Request*</a></td>
                        </tr>
                    </tbody>
                </table>
                <div class="pricing-footnote" style="padding: 1rem; text-align: center; background: #f8fafc; border-top: 1px solid #e2e8f0; font-size: 0.85rem; color: #64748b; margin: 0;">*Indicative starting price. Please enquire for the latest availability, area ranges, and special offers.</div>
            </div>
        </div>
    </section>

    <section class="plan" id="location" style="background: var(--bg-light); padding: 4rem 1rem;">
        <div class="container">
            <h2 class="section-title">Location</h2>
            <p class="section-subtitle">Sattva La Vita offers convenient connectivity and an urban-friendly lifestyle.</p>

            <div class="masterplan-grid reveal">
                <div class="masterplan-image">
                    <img src="sattva-la-vita-location-map.webp" alt="Sattva La Vita location map" onclick="openLightboxFromSrc(''sattva-la-vita-location-map.webp'')" style="cursor: pointer;">
                </div>
                <div class="masterplan-cards" style="transition-delay:160ms;">
                    <div class="plan-note">
                        <strong>Nearby Schools</strong>
                        <span>Families living at Sattva La Vita enjoy close proximity to top educational institutions. Prominent schools such as Stonehill International School, Canadian International School, Vidyashilp Academy, and Ryan International School are located just a short drive away, ensuring quality education options for children.</span>
                    </div>
                    <div class="plan-note">
                        <strong>Nearby Hospitals</strong>
                        <span>Healthcare accessibility is critical. Residents have quick access to specialized medical care at nearby hospitals including Aster CMI Hospital, Cytecare Cancer Hospitals, Manipal Hospital (Hebbal), and Prolife Hospital.</span>
                    </div>
                    <div class="plan-note">
                        <strong>Connected Living</strong>
                        <span>Easy access to key city zones, Kempegowda International Airport (KIA), and major connectivity corridors like Doddaballapura Road and Bellary Road (NH 44).</span>
                    </div>
                </div>
            </div>
        </div>
    </section>'

$html = [regex]::Replace($html, $oldPattern, $newContent, 'IgnoreCase')
Set-Content $file -Value $html
