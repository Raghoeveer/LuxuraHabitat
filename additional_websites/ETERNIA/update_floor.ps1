$content = Get-Content 'index.html' -Raw

$floorPlanHtml = @"
    <section id="floor-plan" class="section">
        <div class="container">
            <h2 class="section-title">Floor Plans</h2>
            <p class="section-subtitle">Thoughtfully designed spaces for maximum comfort</p>
            <div class="floor-grid">
                <div class="floor-card">
                    <div class="floor-img">
                        <img src="Brigade-Eternia-floor-Plan-3-bhk-1653-sq-ft.webp" alt="3 BHK Floor Plan 1653 Sq.Ft - Brigade Eternia" loading="lazy">
                    </div>
                    <div class="floor-details">
                        <div class="floor-type">3 BHK Luxury</div>
                        <div class="floor-size">1,653 Sq.Ft</div>
                        <button class="floor-cta" onclick="document.getElementById('form').scrollIntoView({behavior:'smooth'})">Get Best Price</button>
                    </div>
                </div>
                <div class="floor-card">
                    <div class="floor-img">
                        <img src="Brigade-Eternia-floor-Plan-3-bhk-1848-sq-ft.webp" alt="3 BHK Floor Plan 1848 Sq.Ft - Brigade Eternia" loading="lazy">
                    </div>
                    <div class="floor-details">
                        <div class="floor-type">3 BHK Luxury</div>
                        <div class="floor-size">1,848 Sq.Ft</div>
                        <button class="floor-cta" onclick="document.getElementById('form').scrollIntoView({behavior:'smooth'})">Get Best Price</button>
                    </div>
                </div>
                <div class="floor-card">
                    <div class="floor-img">
                        <img src="Brigade-Eternia-floor-Plan-3-bhk-1915-sq-ft.webp" alt="3 BHK Floor Plan 1915 Sq.Ft - Brigade Eternia" loading="lazy">
                    </div>
                    <div class="floor-details">
                        <div class="floor-type">3 BHK Luxury</div>
                        <div class="floor-size">1,915 Sq.Ft</div>
                        <button class="floor-cta" onclick="document.getElementById('form').scrollIntoView({behavior:'smooth'})">Get Best Price</button>
                    </div>
                </div>
                <div class="floor-card">
                    <div class="floor-img">
                        <img src="Brigade-Eternia-floor-Plan-3-bhk-2111-sq-ft.webp" alt="3 BHK Floor Plan 2111 Sq.Ft - Brigade Eternia" loading="lazy">
                    </div>
                    <div class="floor-details">
                        <div class="floor-type">3 BHK Luxury</div>
                        <div class="floor-size">2,111 Sq.Ft</div>
                        <button class="floor-cta" onclick="document.getElementById('form').scrollIntoView({behavior:'smooth'})">Get Best Price</button>
                    </div>
                </div>
                <div class="floor-card">
                    <div class="floor-img">
                        <img src="Brigade-Eternia-floor-Plan-4-bhk-2714-sq-ft.webp" alt="4 BHK Floor Plan 2714 Sq.Ft - Brigade Eternia" loading="lazy">
                    </div>
                    <div class="floor-details">
                        <div class="floor-type">4 BHK Luxury</div>
                        <div class="floor-size">2,714 Sq.Ft</div>
                        <button class="floor-cta" onclick="document.getElementById('form').scrollIntoView({behavior:'smooth'})">Get Best Price</button>
                    </div>
                </div>
                <div class="floor-card">
                    <div class="floor-img">
                        <img src="Brigade-Eternia-floor-Plan-4-bhk-2926-sq-ft.webp" alt="4 BHK Floor Plan 2926 Sq.Ft - Brigade Eternia" loading="lazy">
                    </div>
                    <div class="floor-details">
                        <div class="floor-type">4 BHK Luxury</div>
                        <div class="floor-size">2,926 Sq.Ft</div>
                        <button class="floor-cta" onclick="document.getElementById('form').scrollIntoView({behavior:'smooth'})">Get Best Price</button>
                    </div>
                </div>
            </div>
            <div style="text-align:center;margin-top:2rem;">
                <button class="hero-cta" onclick="document.getElementById('form').scrollIntoView({behavior:'smooth'})">Download Master Plan</button>
            </div>
        </div>
    </section>
"@

$content = [regex]::Replace($content, '(?si)<section[^>]*id="floor-plan".*?</section>', $floorPlanHtml)
[System.IO.File]::WriteAllText('index.html', $content, [System.Text.Encoding]::UTF8)
