$content = Get-Content 'index.html' -Raw

# 1. Update Pricing
$content = [regex]::Replace($content, '₹ [0-9.]+\s*(?:Cr|Crore|Lakh|L|M)[a-zA-Z*]*', 'INR 2.47 Crore Onwards*', 'IgnoreCase')
$content = [regex]::Replace($content, 'Price on Request', 'INR 2.47 Crore Onwards*', 'IgnoreCase')
$content = [regex]::Replace($content, 'Starting from .*?(?:Cr|Crore|Lakh|L)[a-zA-Z*]*', 'Starting Price: INR 2.47 Crore Onwards*', 'IgnoreCase')
$content = [regex]::Replace($content, '>2\.47<', '>2.47<') # Just in case we need exact matches

# 2. Update Form Select Options
$newSelect = '<select name="config" style="width:100%;padding:0.7rem;border:1px solid var(--border-light);border-radius:5px;font-family:inherit;font-size:0.88rem;background:#fff;color:var(--text-dark);">
                    <option value="">Select BHK Type</option>
                    <option>3 BHK - 1,653 to 2,111 Sq.ft</option>
                    <option>4 BHK - 2,714 to 2,926 Sq.ft</option>
                </select>'
$content = [regex]::Replace($content, '<select name="config".*?</select>', $newSelect, [System.Text.RegularExpressions.RegexOptions]::Singleline)

# 3. Update the Configuration / Specs table
# The original template probably had 2 BHK, 3 BHK, 4 BHK rows. We can just replace the whole text in the floor plans / config section.
$content = $content -replace '2, 3, 4 BHK', '3 &amp; 4 BHK Luxury Apartments'
$content = $content -replace '3 &amp; 4 BHK', '3 &amp; 4 BHK Luxury Apartments'
$content = $content -replace '1,573 to 2,406 Sq\.Ft\.', '1653 to 2926 Sq.ft'

# 4. Amenities list
# We can't easily parse the HTML of amenities in regex without replacing blindly, but we can replace the text.
$content = $content -replace 'Skating Rink', 'Badminton Court'
$content = $content -replace 'Basketball Court', 'Squash Court'
$content = $content -replace 'Tennis Court', 'Table Tennis'
$content = $content -replace 'Amphitheatre', 'Multipurpose Hall'
$content = $content -replace 'Yoga/Meditation', 'Indoor Games Area'
# Update amenities images
$content = $content -replace 'amenity-1\.jpg', 'indoor_swimming_pool_1.webp'
$content = $content -replace 'amenity-2\.jpg', 'gym.webp'
$content = $content -replace 'amenity-3\.jpg', 'badminton-courts.webp'
$content = $content -replace 'amenity-4\.jpg', 'squash-court.webp'
$content = $content -replace 'amenity-5\.jpg', 'table-tennis.webp'
$content = $content -replace 'amenity-6\.jpg', 'indoor-games-area.webp'

# 5. Make sure the phone input is exactly as requested, but the existing form already has it.

Set-Content 'index.html' -Value $content
