$content = Get-Content 'index.html' -Raw

$content = $content -replace 'Price upon request', 'INR 2.47 Crore Onwards*'
$content = $content -replace 'Price on Request', 'INR 2.47 Crore Onwards*'

$content = $content -replace '2, 3, 4 BHK', '3 &amp; 4 BHK Luxury Apartments'
$content = $content -replace '3 &amp; 4 BHK\b', '3 &amp; 4 BHK Luxury Apartments'
$content = $content -replace '1,573 to 2,406 Sq\.Ft\.', '1,653 to 2,926 Sq.ft'

# Update select dropdown for form
$newSelect = '<select name="config" style="width:100%;padding:0.7rem;border:1px solid var(--border-light);border-radius:5px;font-family:inherit;font-size:0.88rem;background:#fff;color:var(--text-dark);">
                    <option value="">Select BHK Type</option>
                    <option>3 BHK - 1,653 to 2,111 Sq.ft</option>
                    <option>4 BHK - 2,714 to 2,926 Sq.ft</option>
                </select>'
$content = [regex]::Replace($content, '(?s)<select name="config".*?</select>', $newSelect)

# Amenities Replacement
$content = $content -replace 'Skating Rink', 'Badminton Court'
$content = $content -replace 'Basketball Court', 'Squash Court'
$content = $content -replace 'Tennis Court', 'Table Tennis'
$content = $content -replace 'Amphitheatre', 'Multipurpose Hall'
$content = $content -replace 'Yoga/Meditation', 'Indoor Games Area'

# Amenities Image Replacement
$content = $content -replace 'amenity-1\.jpg', 'indoor_swimming_pool_1.webp'
$content = $content -replace 'amenity-2\.jpg', 'gym.webp'
$content = $content -replace 'amenity-3\.jpg', 'badminton-courts.webp'
$content = $content -replace 'amenity-4\.jpg', 'squash-court.webp'
$content = $content -replace 'amenity-5\.jpg', 'table-tennis.webp'
$content = $content -replace 'amenity-6\.jpg', 'indoor-games-area.webp'

[System.IO.File]::WriteAllText('index.html', $content, [System.Text.Encoding]::UTF8)
