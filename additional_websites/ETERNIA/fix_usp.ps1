$content = Get-Content 'index.html' -Raw

$uspGridHtml = @"
<div class="usp-grid">
                <div class="usp-card">
                    <div class="usp-icon">&#10022;</div>
                    <h3 class="usp-title">Low Density Privacy</h3>
                    <p class="usp-desc">Experience true exclusivity with thoughtfully planned spaces, offering unparalleled personal space, uncrowded amenities, and peaceful living environments.</p>
                </div>
                <div class="usp-card">
                    <div class="usp-icon">&#10022;</div>
                    <h3 class="usp-title">Platinum Green Living</h3>
                    <p class="usp-desc">As an IGBC Platinum Pre-Certified project, Brigade Eternia boasts 1,000+ native trees, smart energy features, and a centralized RO water system.</p>
                </div>
                <div class="usp-card">
                    <div class="usp-icon">&#10022;</div>
                    <h3 class="usp-title">Prime North Bengaluru Hub</h3>
                    <p class="usp-desc">Strategically positioned in Yelahanka, providing rapid connectivity to top tech parks, leading schools, and the airport.</p>
                </div>
                <div class="usp-card">
                    <div class="usp-icon">&#10022;</div>
                    <h3 class="usp-title">Exclusive Payment Plans</h3>
                    <p class="usp-desc" style="font-weight: 600; line-height: 2; margin-top: 10px;">
                        &#9670; 50:50 Pay Plan<br>
                        &#9670; Pay Just 10% To Book<br>
                        &#9670; FlexiChoice Payment Plan
                    </p>
                </div>
            </div>
"@

$content = [regex]::Replace($content, '(?si)<div class="usp-grid">.*?</div>\s*</div>\s*</section>', "$uspGridHtml`n        </div>`n    </section>")

[System.IO.File]::WriteAllText('index.html', $content, [System.Text.Encoding]::UTF8)
