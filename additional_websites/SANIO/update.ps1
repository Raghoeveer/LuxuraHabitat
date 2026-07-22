$content = Get-Content -Path "index.html" -Raw -Encoding UTF8

$content = $content.Replace('18f2ff46-8221-476c-85a0-dda60a13f358', '50a82aad-4d8f-489f-a7f3-0740334db877')
$content = $content.Replace('Sattva Park Cubix', 'Sattva Sanio')
$content = $content.Replace('Park Cubix', 'Sattva Sanio')
$content = $content.Replace('Devanahalli', 'Old Madras Road')

$metaNew = @"
<title>Sattva Sanio | Premium 3 & 4 BHK Apartments on Old Madras Road, Bangalore</title>
    <meta name="description"
        content="Sattva Sanio offers ultra-luxury 3, 4 BHK & Duplex residences on Old Madras Road (NH-4), Bangalore. 10.3 Acres | 7 Iconic Towers | 1000+ Premium Homes. Register for Pre-Launch Offers.">
    <meta name="keywords"
        content="Sattva Sanio, Sattva Saniyo, Sattva Sanio Old Madras Road, apartments on Old Madras Road, luxury flats in Bangalore, 3 BHK flats OMR Bangalore, 4 BHK flats Bangalore, Sattva group new launch, premium residences KR Puram, real estate Whitefield">
    <meta name="author" content="Sattva Group">
    <meta name="robots" content="index, follow">
    <link rel="canonical" href="https://sattvasanio.projectdetail.net/">
"@

$ogNew = @"
<!-- Open Graph / Social -->
    <meta property="og:title" content="Sattva Sanio | Premium 3 & 4 BHK Apartments">
    <meta property="og:description"
        content="Own your dream home at Sattva Sanio on Old Madras Road. Spacious 3 & 4 BHK residences designed for modern, elevated living. 10.3 Acres | 1000+ Homes.">
    <meta property="og:url" content="https://sattvasanio.projectdetail.net/">
    <meta property="og:image" content="https://sattvasanio.projectdetail.net/Sattva-sanio-overview.png">
    <meta property="og:image:width" content="1200">
    <meta property="og:image:height" content="630">
    <meta property="og:image:alt" content="Sattva Sanio – Premium Apartments in Bangalore">
    <meta property="og:type" content="website">
    <meta property="og:site_name" content="Sattva Sanio">
    <meta property="og:locale" content="en_IN">

    <!-- Twitter Card -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="Sattva Sanio – Luxury Apartments on Old Madras Road">
    <meta name="twitter:description"
        content="3 & 4 BHK apartments in Bangalore. 10.3 Acres | 7 Towers | Pre-Launch Offers. Book Now!">
    <meta name="twitter:image" content="https://sattvasanio.projectdetail.net/Sattva-sanio-overview.png">
    <meta name="twitter:image:alt" content="Sattva Sanio – Premium Apartments in Bangalore">
"@

$heroNew = @"
<!-- ===== HERO SECTION ===== -->
    <section class="hero" id="hero" aria-label="Hero section">
        <div class="hero-container">

            <div class="hero-content">
                <a href="#" class="hero-logo" aria-label="Sattva Sanio">
                    <img src="park cubix log.jpg" alt="Sattva Sanio" onerror="this.style.display='none'">
                </a>
                <div class="hero-badge">New Pre-Launch Opportunity | Old Madras Road</div>
                <h1 style="font-size: clamp(2rem, 3.5vw, 4rem);">Sattva Sanio</h1>
                <p class="hero-tagline">"Elevated Living on Old Madras Road"</p>
                <p class="hero-intro">Step into a landmark residential community by Sattva Group, offering spacious 3 & 4 BHK residences designed for modern, elevated living. Spread across 10.3 acres with 7 iconic towers, this Vastu-compliant haven features 1000+ premium homes and world-class amenities.</p>

                <div class="hero-info-boxes">
                    <div class="info-box primary-details">
                        <div class="info-row">
                            <div class="info-box-icon" aria-hidden="true">🏠</div>
                            <div>
                                <div class="info-box-title">3 & 4 BHK</div>
                                <div class="info-box-subtitle">1000+ Residences</div>
                            </div>
                        </div>
                        <div class="info-row">
                            <div class="info-box-icon" aria-hidden="true">📍</div>
                            <div>
                                <div class="info-box-title">Old Madras Road</div>
                                <div class="info-box-subtitle">(NH-4), Bangalore</div>
                            </div>
                        </div>
                        <div class="info-row">
                            <div class="info-box-icon" aria-hidden="true">🏢</div>
                            <div>
                                <div class="info-box-title">7 Iconic Towers</div>
                                <div class="info-box-subtitle">2B + G + 41 Floors</div>
                            </div>
                        </div>
                        <div class="info-row">
                            <div class="info-box-icon" aria-hidden="true">💰</div>
                            <div>
                                <div class="info-box-title">₹13k - 14k / sq.ft</div>
                                <div class="info-box-subtitle">Expected Price</div>
                            </div>
                        </div>
                    </div>
                    <div class="info-box rera-box">
                        <strong>✅ RERA Registration</strong>
                        RERA No: TBA (To Be Announced)<br>
                        Currently Accepting Expressions of Interest
                    </div>
                </div>
            </div>

            <div class="hero-media" aria-hidden="true">
                <img src="Sattva-sanio-overview.png"
                    alt="Sattva Sanio – Premium Apartments on Old Madras Road"
                    fetchpriority="high">
                <span class="artist-note">Artist's Impression</span>
            </div>

            <div class="hero-form-section" id="heroFormSection">
                <h3 class="hero-form-title">Get Pre-Launch Offers</h3>
                <span class="hero-form-subtitle">Register now for exclusive pricing and floor plans.</span>
                <form class="hero-form" action="https://api.web3forms.com/submit" method="POST" id="heroLeadForm">
                    <input type="hidden" name="access_key" value="50a82aad-4d8f-489f-a7f3-0740334db877">
                    <input type="hidden" name="subject" value="New Lead – Sattva Sanio Hero Form">
                    <input type="text" name="name" autocomplete="name" required placeholder="Your full name" aria-label="Full name">
                    <input type="tel" name="phone" autocomplete="tel" required placeholder="Mobile number *" aria-label="Phone number">
                    <input type="email" name="email" autocomplete="email" placeholder="Email address (optional)" aria-label="Email address">
                    <select name="config" aria-label="BHK configuration">
                        <option value="">Select BHK Type</option>
                        <option>3 BHK Residence</option>
                        <option>4 BHK Residence</option>
                        <option>4 BHK Duplex (Limited)</option>
                    </select>
                    <button type="submit" class="hero-form-submit" id="heroSubmitBtn">Request Details Now</button>
                </form>
            </div>

        </div>
    </section>
"@

$statsNew = @"
<!-- ===== STATS STRIP ===== -->
    <div class="stats-strip" aria-label="Project at a glance">
        <div class="stats-inner">
            <div class="stat-item">
                <div class="stat-number">10.3</div>
                <div class="stat-label">Acres Project</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">1000+</div>
                <div class="stat-label">Premium Homes</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">7</div>
                <div class="stat-label">Iconic Towers</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">41</div>
                <div class="stat-label">Floors High</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">3 & 4</div>
                <div class="stat-label">BHK Options</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">NH-4</div>
                <div class="stat-label">Prime Location</div>
            </div>
        </div>
    </div>
"@

$aboutNew = @"
<!-- ===== ABOUT SECTION ===== -->
    <section class="about" id="about">
        <div class="container">
            <h2 class="section-title">About Sattva Sanio</h2>
            <p class="section-subtitle">A landmark residential community redefining luxury on Old Madras Road, designed for those who appreciate the finer things in life.</p>

            <div class="about-grid">
                <div class="about-content">
                    <h2>Experience Unparalleled Luxury and Vastu-Compliant Living</h2>
                    <p>Welcome to Sattva Sanio, an upcoming architectural masterpiece by the renowned Sattva Group. Spread expansively across 10.3 acres of prime real estate on Old Madras Road (NH-4), this residential enclave is meticulously crafted to offer a lifestyle of uncompromised luxury, comfort, and convenience. As one of the most anticipated pre-launch projects in Bangalore, Sattva Sanio presents a rare opportunity to own a home that seamlessly blends modern aesthetics with functional design.</p>
                    <p>The project features 7 iconic towers that soar majestically up to 41 floors (2B + G + 41), redefining the city's skyline. With over 1000+ premium residences, buyers can choose from spacious 3 BHK and lavish 4 BHK apartments, as well as a highly exclusive collection of limited 4 BHK duplex homes. Every residence is strictly Vastu-compliant, ensuring a harmonious flow of positive energy, abundance, and peace for your family.</p>
                    <p>At Sattva Sanio, the focus is on elevated living. The sprawling 10.3-acre land parcel ensures ample open spaces, lush green landscapes, and a tranquil environment away from the city's hustle, yet flawlessly connected to it. Whether you are unwinding in the expansive master bedrooms, entertaining guests in the grand living areas, or enjoying the panoramic views from your private balconies, every moment here is designed to be extraordinary.</p>

                    <div class="features-list">
                        <div class="feature-item">
                            <div class="feature-icon">🏙️</div>
                            <div>
                                <h4>Iconic Architecture</h4>
                                <p>7 towering structures reaching up to 41 floors with stunning views.</p>
                            </div>
                        </div>
                        <div class="feature-item">
                            <div class="feature-icon">🧭</div>
                            <div>
                                <h4>Vastu-Compliant</h4>
                                <p>Thoughtfully oriented homes to ensure prosperity and well-being.</p>
                            </div>
                        </div>
                        <div class="feature-item">
                            <div class="feature-icon">🌳</div>
                            <div>
                                <h4>Expansive Grounds</h4>
                                <p>Set on 10.3 acres featuring beautifully manicured landscapes.</p>
                            </div>
                        </div>
                        <div class="feature-item">
                            <div class="feature-icon">👑</div>
                            <div>
                                <h4>Exclusive Duplexes</h4>
                                <p>Limited edition 4 BHK duplexes offering unparalleled opulence.</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div>
                    <img src="sattva Sanio Elevation.png" alt="Sattva Sanio elevation view" class="about-visual" loading="lazy">
                </div>
            </div>
        </div>
    </section>
"@

$floorNew = @"
<!-- ===== FLOOR PLANS ===== -->
    <section class="floor-plans" id="floorplans">
        <div class="container">
            <h2 class="section-title">Floor Plans & Configurations</h2>
            <p class="section-subtitle">Spacious, Vastu-compliant layouts designed to maximize natural light and ventilation.</p>

            <div class="floor-grid">
                <div class="floor-card">
                    <div class="floor-image" style="position:relative; cursor:pointer;" onclick="toggleDetailsPanel()">
                        <div style="position:absolute; inset:0; z-index:10; display:flex; align-items:center; justify-content:center; background:rgba(255,255,255,0.4);">
                            <span style="background:var(--accent-gold); color:#fff; padding:0.5rem 1rem; border-radius:4px; font-weight:bold; letter-spacing:1px; box-shadow:0 4px 10px rgba(0,0,0,0.2);">COMING SOON</span>
                        </div>
                        <img src="SATTVA-SANIO-DETAILS.png" alt="3 BHK Floor Plan – Sattva Sanio" style="filter: blur(8px);" loading="lazy">
                    </div>
                    <div class="floor-info">
                        <div class="floor-type">3 BHK Residences</div>
                        <div class="floor-size">~1795 – 2232 Sq.ft SBA</div>
                        <div class="floor-details">
                            <div class="detail-item">
                                <span class="detail-label">Configuration</span>
                                <span class="detail-value">3 BHK + 3T</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Design</span>
                                <span class="detail-value">Spacious & Airy</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Vastu</span>
                                <span class="detail-value">Compliant</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Status</span>
                                <span class="detail-value">Pre-Launch</span>
                            </div>
                        </div>
                        <button class="floor-cta" onclick="toggleDetailsPanel()">Request Floor Plan</button>
                    </div>
                </div>

                <div class="floor-card">
                    <div class="floor-image" style="position:relative; cursor:pointer;" onclick="toggleDetailsPanel()">
                        <div style="position:absolute; inset:0; z-index:10; display:flex; align-items:center; justify-content:center; background:rgba(255,255,255,0.4);">
                            <span style="background:var(--accent-gold); color:#fff; padding:0.5rem 1rem; border-radius:4px; font-weight:bold; letter-spacing:1px; box-shadow:0 4px 10px rgba(0,0,0,0.2);">COMING SOON</span>
                        </div>
                        <img src="SATTVA-SANIO-DETAILS.png" alt="4 BHK Floor Plan – Sattva Sanio" style="filter: blur(8px);" loading="lazy">
                    </div>
                    <div class="floor-info">
                        <div class="floor-type">4 BHK Residences</div>
                        <div class="floor-size">~2648 – 2990+ Sq.ft SBA</div>
                        <div class="floor-details">
                            <div class="detail-item">
                                <span class="detail-label">Configuration</span>
                                <span class="detail-value">4 BHK + 4T</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Design</span>
                                <span class="detail-value">Lavish Layout</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Vastu</span>
                                <span class="detail-value">Compliant</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Status</span>
                                <span class="detail-value">Pre-Launch</span>
                            </div>
                        </div>
                        <button class="floor-cta" onclick="toggleDetailsPanel()">Request Floor Plan</button>
                    </div>
                </div>

                <div class="floor-card">
                    <div class="floor-image" style="position:relative; cursor:pointer;" onclick="toggleDetailsPanel()">
                        <div style="position:absolute; inset:0; z-index:10; display:flex; align-items:center; justify-content:center; background:rgba(255,255,255,0.4);">
                            <span style="background:var(--accent-gold); color:#fff; padding:0.5rem 1rem; border-radius:4px; font-weight:bold; letter-spacing:1px; box-shadow:0 4px 10px rgba(0,0,0,0.2);">COMING SOON</span>
                        </div>
                        <img src="SATTVA-SANIO-DETAILS.png" alt="4 BHK Duplex Floor Plan – Sattva Sanio" style="filter: blur(8px);" loading="lazy">
                    </div>
                    <div class="floor-info">
                        <div class="floor-type">4 BHK Duplex (Limited)</div>
                        <div class="floor-size">~4700 – 5100+ Sq.ft SBA</div>
                        <div class="floor-details">
                            <div class="detail-item">
                                <span class="detail-label">Configuration</span>
                                <span class="detail-value">Ultra Luxury Duplex</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Design</span>
                                <span class="detail-value">Double Height</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Vastu</span>
                                <span class="detail-value">Compliant</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Availability</span>
                                <span class="detail-value">Highly Limited</span>
                            </div>
                        </div>
                        <button class="floor-cta" onclick="toggleDetailsPanel()">Request Floor Plan</button>
                    </div>
                </div>
            </div>
        </div>
    </section>
"@

$masterNew = @"
<!-- ===== MASTER PLAN ===== -->
    <section class="master-plan" id="masterplan">
        <div class="container">
            <h2 class="section-title">Master Plan</h2>
            <p class="section-subtitle">A meticulously crafted 10.3-acre development featuring 7 iconic towers and extensive social spaces.</p>

            <div class="master-plan-shell">
                <div class="master-plan-image" style="position:relative; cursor:pointer;" onclick="toggleDetailsPanel()">
                    <div style="position:absolute; inset:0; z-index:10; display:flex; align-items:center; justify-content:center; background:rgba(255,255,255,0.2);">
                        <span style="background:var(--accent-gold); color:#fff; padding:0.7rem 1.5rem; border-radius:4px; font-weight:bold; letter-spacing:1px; font-size:1.2rem; box-shadow:0 4px 15px rgba(0,0,0,0.3);">COMING SOON - CLICK TO ENQUIRE</span>
                    </div>
                    <img src="Sattva-sanio-overview.png" alt="Sattva Sanio Master Plan Layout" style="filter: blur(10px);" loading="lazy">
                </div>
                <div class="master-plan-notes">
                    <div class="plan-note">
                        <strong>10.3-Acre Premium Enclave</strong>
                        <span>The master plan integrates 7 high-rise residential towers surrounded by beautifully curated landscaping, ensuring ample breathing space between structures.</span>
                    </div>
                    <div class="plan-note">
                        <strong>Intelligent Traffic Flow</strong>
                        <span>Designed for pedestrian safety with dedicated vehicular movement zones, drop-off points, and expansive basement parking (2B).</span>
                    </div>
                    <div class="plan-note">
                        <strong>Centralized Amenities</strong>
                        <span>The grand clubhouse and primary recreational zones form the heart of the community, easily accessible from all 7 towers.</span>
                    </div>
                    <div class="plan-note">
                        <strong>Green Sanctuaries</strong>
                        <span>Dedicated pet parks, party lawns, reflexology walks, and expansive green zones provide a serene retreat from urban life.</span>
                    </div>
                </div>
            </div>
        </div>
    </section>
"@

$uspNew = @"
<!-- ===== PROJECT HIGHLIGHTS ===== -->
    <section class="usp" id="usp">
        <div class="container">
            <h2 class="section-title">Why Choose Sattva Sanio?</h2>
            <p class="section-subtitle">The perfect culmination of location, luxury, and lifestyle in Bangalore's most dynamic corridor.</p>

            <div class="usp-grid">
                <div class="usp-card">
                    <h3>📍 Strategic Location Advantage</h3>
                    <p>Situated directly on the bustling Old Madras Road (NH-4), Sattva Sanio offers seamless, signal-free connectivity to major hubs like KR Puram, Whitefield, and Hoskote. The direct access to the Bangalore–Chennai Highway ensures you are always well-connected.</p>
                </div>
                <div class="usp-card">
                    <h3>🚀 Close to Key IT Hubs</h3>
                    <p>Perfect for IT professionals, the property is a short ~20–25 minute drive to ITPL and the Whitefield tech belt. Bagmane Tech Park and RMZ Infinity are also within a comfortable 25–30 minute commute, ensuring a perfect work-life balance.</p>
                </div>
                <div class="usp-card">
                    <h3>💎 Spacious & Lavish Residences</h3>
                    <p>Move away from cramped city apartments. With 3 BHKs starting at ~1795 sq.ft and 4 BHKs reaching up to ~2990+ sq.ft, Sattva Sanio provides the expansive living space your family deserves, complemented by ultra-luxury duplex options.</p>
                </div>
                <div class="usp-card">
                    <h3>✨ Comprehensive Lifestyle</h3>
                    <p>Beyond the four walls of your home, the community offers a holistic lifestyle. From a grand clubhouse and swimming pool to sports courts and pet parks, every age group has dedicated spaces to thrive and socialize.</p>
                </div>
                <div class="usp-card">
                    <h3>🏥 Premium Healthcare Proximity</h3>
                    <p>Peace of mind is guaranteed with top-tier medical facilities nearby. MVJ Medical College & Hospital is just ~10 minutes away, while Manipal Hospital and Narayana Multispeciality Hospital in Whitefield are accessible within ~20 minutes.</p>
                </div>
                <div class="usp-card">
                    <h3>📈 High Appreciation Potential</h3>
                    <p>Purchasing at the expected pre-launch price of ₹13,000 – ₹14,000 / sq.ft offers a significant advantage. The Old Madras Road corridor is witnessing rapid infrastructural growth, promising excellent capital appreciation and rental yields.</p>
                </div>
            </div>
        </div>
    </section>
"@

$amenitiesNew = @"
<!-- ===== AMENITIES ===== -->
    <section class="amenities" id="amenities">
        <div class="container">
            <h2 class="section-title">Exclusive Lifestyle & Amenities</h2>
            <p class="section-subtitle">A curated collection of world-class facilities designed for recreation, wellness, and community engagement.</p>

            <div class="amenity-grid">
                <div class="amenity-card">
                    <div class="amenity-icon">🏛️</div>
                    <h3>Social & Leisure</h3>
                    <ul class="amenity-list">
                        <li>Grand Clubhouse</li>
                        <li>Party Lawns</li>
                        <li>Community Spaces</li>
                        <li>Multipurpose Hall</li>
                        <li>Lounge Areas</li>
                    </ul>
                </div>

                <div class="amenity-card">
                    <div class="amenity-icon">🏊‍♂️</div>
                    <h3>Wellness & Fitness</h3>
                    <ul class="amenity-list">
                        <li>Swimming Pool</li>
                        <li>Outdoor Gym</li>
                        <li>Reflexology Walk</li>
                        <li>Jogging Track</li>
                        <li>Yoga Deck</li>
                    </ul>
                </div>

                <div class="amenity-card">
                    <div class="amenity-icon">🎾</div>
                    <h3>Active Sports</h3>
                    <ul class="amenity-list">
                        <li>Tennis Court</li>
                        <li>Pickleball Courts</li>
                        <li>Cricket Nets</li>
                        <li>Half Basketball Court</li>
                        <li>Indoor Games Room</li>
                    </ul>
                </div>

                <div class="amenity-card">
                    <div class="amenity-icon">🌳</div>
                    <h3>Family & Nature</h3>
                    <ul class="amenity-list">
                        <li>Kids' Play Area</li>
                        <li>Pet Park</li>
                        <li>Landscaped Zones</li>
                        <li>Senior Citizens' Corner</li>
                        <li>Seating Pavilions</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
"@

$locationNew = @"
<!-- ===== LOCATION ===== -->
    <section class="location" id="location">
        <div class="container">
            <h2 class="section-title">Prime Location – Old Madras Road (NH-4)</h2>
            <p class="section-subtitle">Strategically positioned for seamless connectivity to Bangalore's major IT hubs and essential infrastructure.</p>

            <div class="location-grid">
                <div class="location-map">
                    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3887.8926941198544!2d77.6521501!3d12.9818817!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bae16af255c2d33%3A0xe54fb77d34cd4150!2sOld%20Madras%20Rd%2C%20Bengaluru%2C%20Karnataka!5e0!3m2!1sen!2sin!4v1700000000000!5m2!1sen!2sin" width="100%" height="100%" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                </div>

                <div class="location-info">
                    <div class="proximity-wrapper">
                        <div class="proximity-section">
                            <h3>🏢 Key IT Hubs</h3>
                            <div class="proximity-list">
                                <div class="proximity-item">
                                    <span class="proximity-place">ITPL / Whitefield</span>
                                    <span class="proximity-time">~20–25 mins</span>
                                </div>
                                <div class="proximity-item">
                                    <span class="proximity-place">RMZ Infinity</span>
                                    <span class="proximity-time">~25 mins</span>
                                </div>
                                <div class="proximity-item">
                                    <span class="proximity-place">Bagmane Tech Park</span>
                                    <span class="proximity-time">~25–30 mins</span>
                                </div>
                            </div>
                        </div>

                        <div class="proximity-section">
                            <h3>🛣️ Connectivity</h3>
                            <div class="proximity-list">
                                <div class="proximity-item">
                                    <span class="proximity-place">KR Puram</span>
                                    <span class="proximity-time">Seamless</span>
                                </div>
                                <div class="proximity-item">
                                    <span class="proximity-place">Hoskote</span>
                                    <span class="proximity-time">Seamless</span>
                                </div>
                                <div class="proximity-item">
                                    <span class="proximity-place">Bangalore-Chennai NH-4</span>
                                    <span class="proximity-time">Direct Access</span>
                                </div>
                            </div>
                        </div>

                        <div class="proximity-section">
                            <h3>🏥 Healthcare</h3>
                            <div class="proximity-list">
                                <div class="proximity-item">
                                    <span class="proximity-place">MVJ Medical College & Hospital</span>
                                    <span class="proximity-time">~10 mins</span>
                                </div>
                                <div class="proximity-item">
                                    <span class="proximity-place">Manipal Hospital, Whitefield</span>
                                    <span class="proximity-time">~20 mins</span>
                                </div>
                                <div class="proximity-item">
                                    <span class="proximity-place">Narayana Multispeciality</span>
                                    <span class="proximity-time">~20–25 mins</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div style="text-align:center; margin-top: 2rem;">
                <a href="https://maps.app.goo.gl/ZFg2SdzyjhncsKiT8" target="_blank" class="nav-cta" style="padding: 1rem 2rem; font-size: 1rem;">View on Google Maps</a>
            </div>
        </div>
    </section>
"@

$pricingNew = @"
<!-- ===== PRICING ===== -->
    <section class="pricing" id="pricing">
        <div class="container">
            <h2 class="section-title">Pre-Launch Pricing</h2>
            <p class="section-subtitle">Capitalize on early-bird advantage with highly competitive pre-launch pricing for premium luxury.</p>

            <div class="pricing-grid">
                <div class="pricing-card">
                    <h3>3 BHK Residences</h3>
                    <div class="pricing-amount">₹13k - ₹14k</div>
                    <div class="pricing-sub">Per Sq.ft (All Inclusive)</div>
                    <ul class="pricing-details">
                        <li>SBA: ~1795 – 2232 sq.ft</li>
                        <li>3 Bedrooms + 3 Toilets</li>
                        <li>Spacious & Vastu Compliant</li>
                        <li>Premium High-Rise Views</li>
                    </ul>
                    <button class="pricing-btn" onclick="toggleDetailsPanel()">Request Cost Sheet</button>
                </div>

                <div class="pricing-card featured">
                    <h3>4 BHK Residences</h3>
                    <div class="pricing-amount">₹13k - ₹14k</div>
                    <div class="pricing-sub">Per Sq.ft (All Inclusive)</div>
                    <ul class="pricing-details">
                        <li>SBA: ~2648 – 2990+ sq.ft</li>
                        <li>4 Bedrooms + 4 Toilets</li>
                        <li>Lavish Living Spaces</li>
                        <li>Exclusive Corner Units</li>
                    </ul>
                    <button class="pricing-btn" onclick="toggleDetailsPanel()">Get Pre-Launch Offer</button>
                </div>

                <div class="pricing-card">
                    <h3>4 BHK Duplex</h3>
                    <div class="pricing-amount">On Request</div>
                    <div class="pricing-sub">Ultra Luxury Limited Edition</div>
                    <ul class="pricing-details">
                        <li>SBA: ~4700 – 5100+ sq.ft</li>
                        <li>Double Height Living</li>
                        <li>Private Terraces</li>
                        <li>Bespoke Finishes</li>
                    </ul>
                    <button class="pricing-btn" onclick="toggleDetailsPanel()">Enquire Now</button>
                </div>
            </div>

            <div style="text-align:center;margin-top:2rem;color:var(--text-light);font-size:0.86rem;">
                <p>* Prices are indicative and represent the expected pre-launch base price. Final pricing is subject to floor rise, PLC, and final management approval.</p>
            </div>
        </div>
    </section>
"@

$faqNew = @"
<!-- ===== FAQ SECTION ===== -->
    <section class="faq" id="faq">
        <div class="container">
            <h2 class="section-title">Frequently Asked Questions</h2>
            <p class="section-subtitle">Common queries about the Sattva Sanio residential project</p>

            <div class="faq-list" itemscope itemtype="https://schema.org/FAQPage">

                <div class="faq-item" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
                    <button class="faq-question" onclick="toggleFAQ(this)" aria-expanded="false">
                        <span itemprop="name">What is Sattva Sanio and where is it located?</span>
                        <span class="faq-arrow">▼</span>
                    </button>
                    <div class="faq-answer" itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer">
                        <p itemprop="text">Sattva Sanio is a premium residential development by the reputed Sattva Group. It is strategically located on Old Madras Road (NH-4), offering seamless connectivity to KR Puram, Whitefield, and Hoskote, making it a prime destination for luxury living in Bangalore.</p>
                    </div>
                </div>

                <div class="faq-item" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
                    <button class="faq-question" onclick="toggleFAQ(this)" aria-expanded="false">
                        <span itemprop="name">What are the apartment configurations available?</span>
                        <span class="faq-arrow">▼</span>
                    </button>
                    <div class="faq-answer" itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer">
                        <p itemprop="text">The project features spacious 3 BHK and 4 BHK residences. The 3 BHK units range from ~1795 to 2232 sq.ft, while the 4 BHK units range from ~2648 to 2990+ sq.ft. Additionally, there are highly limited ultra-luxury 4 BHK duplexes spanning ~4700 to 5100+ sq.ft.</p>
                    </div>
                </div>

                <div class="faq-item" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
                    <button class="faq-question" onclick="toggleFAQ(this)" aria-expanded="false">
                        <span itemprop="name">What is the total area and scale of the project?</span>
                        <span class="faq-arrow">▼</span>
                    </button>
                    <div class="faq-answer" itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer">
                        <p itemprop="text">Sattva Sanio is spread across a massive 10.3-acre land parcel. It comprises 7 iconic high-rise towers featuring an elevation of 2 Basements + Ground + up to 41 floors, housing a total of 1000+ premium residences.</p>
                    </div>
                </div>

                <div class="faq-item" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
                    <button class="faq-question" onclick="toggleFAQ(this)" aria-expanded="false">
                        <span itemprop="name">What is the expected pricing for Sattva Sanio?</span>
                        <span class="faq-arrow">▼</span>
                    </button>
                    <div class="faq-answer" itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer">
                        <p itemprop="text">The expected pre-launch price for the residences is exceptionally competitive, ranging between ₹13,000 to ₹14,000 per sq.ft (All Inclusive). This presents a fantastic early-bird investment opportunity.</p>
                    </div>
                </div>

                <div class="faq-item" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
                    <button class="faq-question" onclick="toggleFAQ(this)" aria-expanded="false">
                        <span itemprop="name">Are the homes at Sattva Sanio Vastu-compliant?</span>
                        <span class="faq-arrow">▼</span>
                    </button>
                    <div class="faq-answer" itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer">
                        <p itemprop="text">Yes, all the residences at Sattva Sanio are thoughtfully designed to be Vastu-compliant, ensuring positive energy, prosperity, and harmony for your family.</p>
                    </div>
                </div>

                <div class="faq-item" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
                    <button class="faq-question" onclick="toggleFAQ(this)" aria-expanded="false">
                        <span itemprop="name">What amenities can residents expect?</span>
                        <span class="faq-arrow">▼</span>
                    </button>
                    <div class="faq-answer" itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer">
                        <p itemprop="text">Residents will enjoy access to a grand clubhouse, a large swimming pool, kids' play areas, tennis and pickleball courts, cricket nets, an outdoor gym, jogging track, reflexology walk, dedicated pet park, and lush party lawns.</p>
                    </div>
                </div>

            </div>
        </div>
    </section>
"@

$content = $content -replace '(?s)<title>.*?</title>.*?<link rel="canonical" href=".*?">', $metaNew
$content = $content -replace '(?s)<!-- Open Graph / Social -->.*?<!-- Fonts -->', "$ogNew`r`n`r`n    <!-- Fonts -->"
$content = $content -replace '(?s)<!-- ===== HERO SECTION ===== -->.*?<!-- ===== STATS STRIP ===== -->', "$heroNew`r`n`r`n    <!-- ===== STATS STRIP ===== -->"
$content = $content -replace '(?s)<!-- ===== STATS STRIP ===== -->.*?<!-- ===== ABOUT SECTION ===== -->', "$statsNew`r`n`r`n    <!-- ===== ABOUT SECTION ===== -->"
$content = $content -replace '(?s)<!-- ===== ABOUT SECTION ===== -->.*?<!-- ===== FLOOR PLANS ===== -->', "$aboutNew`r`n`r`n    <!-- ===== FLOOR PLANS ===== -->"
$content = $content -replace '(?s)<!-- ===== FLOOR PLANS ===== -->.*?<!-- ===== MASTER PLAN ===== -->', "$floorNew`r`n`r`n    <!-- ===== MASTER PLAN ===== -->"
$content = $content -replace '(?s)<!-- ===== MASTER PLAN ===== -->.*?<!-- ===== PROJECT HIGHLIGHTS ===== -->', "$masterNew`r`n`r`n    <!-- ===== PROJECT HIGHLIGHTS ===== -->"
$content = $content -replace '(?s)<!-- ===== PROJECT HIGHLIGHTS ===== -->.*?<!-- ===== AMENITIES ===== -->', "$uspNew`r`n`r`n    <!-- ===== AMENITIES ===== -->"
$content = $content -replace '(?s)<!-- ===== AMENITIES ===== -->.*?<!-- ===== GALLERY ===== -->', "$amenitiesNew`r`n`r`n    <!-- ===== GALLERY ===== -->"
$content = $content -replace '(?s)<!-- ===== LOCATION ===== -->.*?<!-- ===== PRICING ===== -->', "$locationNew`r`n`r`n    <!-- ===== PRICING ===== -->"
$content = $content -replace '(?s)<!-- ===== PRICING ===== -->.*?<!-- ===== SPECIFICATIONS ===== -->', "$pricingNew`r`n`r`n    <!-- ===== SPECIFICATIONS ===== -->"
$content = $content -replace '(?s)<!-- ===== FAQ SECTION ===== -->.*?<!-- ===== LEAD FORM ===== -->', "$faqNew`r`n`r`n    <!-- ===== LEAD FORM ===== -->"

$content = $content.Replace('every unit in Sattva Sanio', 'every unit in Sattva Sanio')
$content = $content.Replace('1 BHK: 658 Sq.ft', '3 BHK: 1795 - 2232 Sq.ft')
$content = $content.Replace('2 BHK: 997 – 1,180 Sq.ft', '4 BHK: 2648 - 2990+ Sq.ft')
$content = $content.Replace('3 BHK: 1,270 – 1,498 Sq.ft', '4 BHK Duplex: 4700 - 5100+ Sq.ft')

$content = $content.Replace('<option>1 BHK – 658 Sq.ft</option>', '<option>3 BHK Residence</option>')
$content = $content.Replace('<option>2 BHK – 997 to 1180 Sq.ft</option>', '<option>4 BHK Residence</option>')
$content = $content.Replace('<option>3 BHK – 1270 to 1498 Sq.ft</option>', '<option>4 BHK Duplex</option>')

# Fix footer replacements considering we've already done global replacements of Sattva Park Cubix to Sattva Sanio etc.
$footer_text_old = "An 18-acre integrated township by Sattva Group (formerly Salarpuria Sattva) in Old Madras Road, North Bengaluru. Premium 1, 2 & 3 BHK apartments near Kempegowda International Airport with 79% open space and 50+ lifestyle amenities."
$footer_text_new = "A 10.3-acre premium residential community by Sattva Group on Old Madras Road (NH-4), Bangalore. Offering luxury 3 & 4 BHK and Duplex apartments across 7 iconic towers with world-class amenities."
$content = $content.Replace($footer_text_old, $footer_text_new)

$address_old = "Opposite KRN Complex, Old Madras Road<br>Airport Road (NH-207)<br>North Bengaluru – 562110"
$address_new = "Old Madras Road (NH-4)<br>Near KR Puram & Whitefield<br>Bangalore"
$content = $content.Replace($address_old, $address_new)

$content = $content.Replace('Phase 1 RERA:<br>PRM/KA/RERA/1250/303/<br>PR/171023/001749', 'RERA No:<br>TBA<br>Registration in Progress')
$content = $content.Replace('<p style="margin-top:0.7rem;">Phase 2 RERA:<br>PRM/KA/RERA/1250/303/<br>PR/280225/007529</p>', '')

$rera_notice_old = "Phase 1 RERA No: PRM/KA/RERA/1250/303/PR/171023/001749 | Phase 2 RERA No: PRM/KA/RERA/1250/303/PR/280225/007529."
$rera_notice_new = "RERA Registration Number: TBA."
$content = $content.Replace($rera_notice_old, $rera_notice_new)

$content = $content.Replace('© 2026 Sattva Sanio – Old Madras Road, North Bengaluru.', '© 2026 Sattva Sanio – Old Madras Road, Bangalore.')
$content = $content.Replace('© 2026 Sattva Sanio – Devanahalli, North Bengaluru.', '© 2026 Sattva Sanio – Old Madras Road, Bangalore.')

Set-Content -Path "index.html" -Value $content -Encoding UTF8
Write-Output "HTML updated successfully."
