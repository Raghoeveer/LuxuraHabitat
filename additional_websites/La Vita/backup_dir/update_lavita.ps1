$file = 'c:\websites_vs\New folder\La Vita\index.html'
$html = Get-Content $file -Raw

# 1. Inject CSS for the new layouts
$css = @'
        .masterplan-grid { display: grid; gap: 2rem; margin-top: 1.5rem; }
        .masterplan-image { border-radius: 12px; overflow: hidden; box-shadow: 0 14px 36px rgba(2,6,23,0.1); }
        .masterplan-image img { width: 100%; display: block; }
        .masterplan-cards { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 1.5rem; }
        
        .floor-group { margin-top: 3rem; }
        .floor-group h3 { font-size: 1.5rem; color: var(--primary-dark); margin-bottom: 1rem; padding-bottom: 0.5rem; border-bottom: 2px solid var(--accent-warm); }
        .floor-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 1.5rem; }
        .floor-card { background: #fff; border: 1px solid rgba(11,107,60,0.15); border-radius: 12px; padding: 1rem; text-align: center; box-shadow: 0 6px 16px rgba(0,0,0,0.05); transition: transform 0.3s; }
        .floor-card:hover { transform: translateY(-5px); border-color: var(--accent-green); }
        .floor-card img { width: 100%; aspect-ratio: 1/1; object-fit: contain; margin-bottom: 1rem; cursor: pointer; }
        .floor-card h4 { color: var(--text-dark); font-weight: 800; font-size: 1.1rem; }
    </style>
'@
$html = $html -replace '</style>', $css

# 2. Update Hero Intro
$heroOld = '<p class="hero-intro">[\s\S]*?</p>'
$heroNew = '<p class="hero-intro">
                    Sattva La Vita redefines luxury living with exclusive 4 BHK row house villas. Nestled off Hennur Road, Bangalore, it features private gardens, world-class amenities, and a serene lifestyle. Enquire now for brochure and offers.
                </p>'
$html = [regex]::Replace($html, $heroOld, $heroNew, 'IgnoreCase')

# 3. Update About Section
$aboutOld = '(?s)<section class="about" id="about">.*?</section>'
$aboutNew = '<section class="about" id="about">
        <div class="container">
            <h2 class="section-title">Project Overview</h2>
            <p class="section-subtitle">A meticulously planned residential experience offering an exclusive community and premium lifestyle.</p>

            <div class="about-grid">
                <div class="about-content reveal">
                    <h3>Exclusive 4 BHK Luxury Row Villas</h3>
                    <p>
                        Sattva La Vita brings together privacy, community, and unmatched wellness. Situated just off Hennur Road, Bangalore, this luxury enclave offers ultra-spacious 4 BHK row houses.
                        Enjoy lush private gardens, extensive fitness zones, and world-class lifestyle amenities—built to elevate your everyday routines.
                    </p>
                    <p>
                        Explore our thoughtfully designed master plan, detailed unit plans, and vibrant gallery below. With strict adherence to RERA guidelines and premium quality construction, Sattva La Vita is your gateway to a serene urban lifestyle.
                    </p>

                    <div class="features-list">
                        <div class="feature-item">
                            <div class="feature-icon">&check;</div>
                            <div>
                                <h4>Prime Location</h4>
                                <p>Off Hennur Road, Bangalore</p>
                            </div>
                        </div>
                        <div class="feature-item">
                            <div class="feature-icon">&check;</div>
                            <div>
                                <h4>Premium Villas</h4>
                                <p>Exclusive 4 BHK Row Houses</p>
                            </div>
                        </div>
                    </div>
                </div>
                <img class="about-visual" src="Lavita-slide-002.webp" alt="Sattva La Vita aerial view">
            </div>
        </div>
    </section>'
$html = [regex]::Replace($html, $aboutOld, $aboutNew, 'IgnoreCase')

# 4. Update Gallery Section
$galleryOld = '(?s)<section class="gallery" id="gallery">.*?</section>'
$galleryNew = '<section class="gallery" id="gallery">
        <div class="container">
            <h2 class="section-title">Gallery</h2>
            <p class="section-subtitle">Explore the Sattva La Vita visuals.</p>

            <div class="gallery-grid reveal">
                <div class="gallery-item" onclick="openLightbox(this)"><img src="Lavita-001.webp" alt="Sattva La Vita Exterior"></div>
                <div class="gallery-item" onclick="openLightbox(this)"><img src="Lavita-slide-002.webp" alt="Aerial night view"></div>
                <div class="gallery-item" onclick="openLightbox(this)"><img src="Lavita-slide-003.webp" alt="Living Area"></div>
                <div class="gallery-item" onclick="openLightbox(this)"><img src="Lavita-slide-004.webp" alt="Tower Approach"></div>
                <div class="gallery-item" onclick="openLightbox(this)"><img src="Lavita-slide-005.webp" alt="Landscape"></div>
                <div class="gallery-item" onclick="openLightbox(this)"><img src="Lavita-slide-006.webp" alt="Bedroom View"></div>
                <div class="gallery-item" onclick="openLightbox(this)"><img src="Lavita-slide-007.webp" alt="Master Bedroom"></div>
                <div class="gallery-item" onclick="openLightboxFromSrc(''lavita-amenities-SwimmingPool-001.webp'')"><img src="lavita-amenities-SwimmingPool-001.webp" alt="Swimming Pool"></div>
                <div class="gallery-item" onclick="openLightboxFromSrc(''lavita-amenities-KidsPlayArea-001.webp'')"><img src="lavita-amenities-KidsPlayArea-001.webp" alt="Kids Play Area"></div>
                <div class="gallery-item" onclick="openLightboxFromSrc(''lavita-amenities-IndoorPartyArea-001.webp'')"><img src="lavita-amenities-IndoorPartyArea-001.webp" alt="Indoor Party Area"></div>
                <div class="gallery-item" onclick="openLightboxFromSrc(''lavita-amenities-OutdoorGym-001.webp'')"><img src="lavita-amenities-OutdoorGym-001.webp" alt="Outdoor Gym"></div>
                <div class="gallery-item" onclick="openLightboxFromSrc(''lavita-amenities-ReadingLounge-001.webp'')"><img src="lavita-amenities-ReadingLounge-001.webp" alt="Reading Lounge"></div>
                <div class="gallery-item" onclick="openLightboxFromSrc(''lavita-amenities-indoor-games-001.webp'')"><img src="lavita-amenities-indoor-games-001.webp" alt="Indoor Games"></div>
                <div class="gallery-item" onclick="openLightboxFromSrc(''lavita-amenities-indoor-gym-001.webp'')"><img src="lavita-amenities-indoor-gym-001.webp" alt="Indoor Gym"></div>
            </div>
        </div>
    </section>'
$html = [regex]::Replace($html, $galleryOld, $galleryNew, 'IgnoreCase')

# 5. Update Units/Plan Section
$unitsOld = '(?s)<section class="plan" id="units">.*?</section>'
$unitsNew = '<section class="plan" id="masterplan">
        <div class="container">
            <h2 class="section-title">Master Plan</h2>
            <p class="section-subtitle">Discover the expansive layout of Sattva La Vita</p>
            
            <div class="masterplan-grid reveal">
                <div class="masterplan-image">
                    <img src="Master-Paln-001.webp" alt="Sattva La Vita Master Plan" onclick="openLightboxFromSrc(''Master-Paln-001.webp'')" style="cursor: pointer;">
                </div>
                
                <div class="masterplan-cards">
                    <div class="plan-note">
                        <strong>Luxurious Landscaping</strong>
                        <span>The master plan integrates vast open spaces, themed gardens, and a meditation pavilion, creating a perfect harmony between modern architecture and nature. Enjoy unparalleled privacy and greenery.</span>
                    </div>
                    <div class="plan-note">
                        <strong>World-Class Amenities</strong>
                        <span>Strategically placed amenities including a multipurpose court, outdoor gym, cricket practice net, and swimming pool ensure that leisure and fitness are always within reach of your villa.</span>
                    </div>
                    <div class="plan-note">
                        <strong>Vastu Compliant Design</strong>
                        <span>The entire layout has been crafted meticulously adhering to Vastu principles, ensuring a positive flow of energy. Premium infrastructure ensures a safe and serene environment.</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="plan" id="units" style="background: var(--bg-light); padding-top: 5rem;">
        <div class="container">
            <h2 class="section-title">Floor Plans</h2>
            <p class="section-subtitle">Detailed 4 BHK Row House configurations</p>
            
            <div class="floor-plan-groups reveal">
                
                <!-- East Facing -->
                <div class="floor-group">
                    <h3>East Facing Villas</h3>
                    <div class="floor-grid">
                        <div class="floor-card">
                            <img src="Basement-Floor-East.webp" alt="Basement East" onclick="openLightboxFromSrc(''Basement-Floor-East.webp'')">
                            <h4>Basement</h4>
                        </div>
                        <div class="floor-card">
                            <img src="Ground-Floor-East.webp" alt="Ground Floor East" onclick="openLightboxFromSrc(''Ground-Floor-East.webp'')">
                            <h4>Ground Floor</h4>
                        </div>
                        <div class="floor-card">
                            <img src="First-Floor-East.webp" alt="First Floor East" onclick="openLightboxFromSrc(''First-Floor-East.webp'')">
                            <h4>First Floor</h4>
                        </div>
                        <div class="floor-card">
                            <img src="Second-Floor-East.webp" alt="Second Floor East" onclick="openLightboxFromSrc(''Second-Floor-East.webp'')">
                            <h4>Second Floor</h4>
                        </div>
                    </div>
                </div>

                <!-- North Facing -->
                <div class="floor-group">
                    <h3>North Facing Villas</h3>
                    <div class="floor-grid">
                        <div class="floor-card">
                            <img src="Basement-Floor-Nort.webp" alt="Basement North" onclick="openLightboxFromSrc(''Basement-Floor-Nort.webp'')">
                            <h4>Basement</h4>
                        </div>
                        <div class="floor-card">
                            <img src="Ground-Floor-North.webp" alt="Ground Floor North" onclick="openLightboxFromSrc(''Ground-Floor-North.webp'')">
                            <h4>Ground Floor</h4>
                        </div>
                        <div class="floor-card">
                            <img src="Firast-Floor-North.webp" alt="First Floor North" onclick="openLightboxFromSrc(''Firast-Floor-North.webp'')">
                            <h4>First Floor</h4>
                        </div>
                        <div class="floor-card">
                            <img src="Second-Floor-North.webp" alt="Second Floor North" onclick="openLightboxFromSrc(''Second-Floor-North.webp'')">
                            <h4>Second Floor</h4>
                        </div>
                    </div>
                </div>

                <!-- West Facing -->
                <div class="floor-group">
                    <h3>West Facing Villas</h3>
                    <div class="floor-grid">
                        <div class="floor-card">
                            <img src="Basement-Floor-West.webp" alt="Basement West" onclick="openLightboxFromSrc(''Basement-Floor-West.webp'')">
                            <h4>Basement</h4>
                        </div>
                        <div class="floor-card">
                            <img src="Ground-Floor-West.webp" alt="Ground Floor West" onclick="openLightboxFromSrc(''Ground-Floor-West.webp'')">
                            <h4>Ground Floor</h4>
                        </div>
                        <div class="floor-card">
                            <img src="Firast-Floor-West.webp" alt="First Floor West" onclick="openLightboxFromSrc(''Firast-Floor-West.webp'')">
                            <h4>First Floor</h4>
                        </div>
                        <div class="floor-card">
                            <img src="Second-Floor-West.webp" alt="Second Floor West" onclick="openLightboxFromSrc(''Second-Floor-West.webp'')">
                            <h4>Second Floor</h4>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>'
$html = [regex]::Replace($html, $unitsOld, $unitsNew, 'IgnoreCase')

Set-Content $file -Value $html
