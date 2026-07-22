$content = Get-Content 'index.html' -Raw

$content = $content -replace 'Vajram Vivera', 'Brigade Eternia'
$content = $content -replace 'Vajram Group', 'Brigade Group'
$content = $content -replace 'Vajram', 'Brigade'

$content = $content -replace 'Kogilu Main Road, North Bengaluru', 'Yelahanka, North Bengaluru'
$content = $content -replace 'Kogilu Main Road', 'Yelahanka'

$content = $content -replace '6.2 Acres', '14 Acres'
$content = $content -replace '3 Towers \(2B \+ G \+ 17 Floors\)', '1,124 units'
$content = $content -replace '85% Open Space', 'Premium Open Spaces'
$content = $content -replace '55\+ Lifestyle Amenities', 'Premium Lifestyle Amenities'

# Form key
$content = $content -replace 'b3ea5464-ddde-4fdf-b9a5-ed31e81cbf9b', '66e56681-a1b1-4395-a293-d94094e999b1'

# Images (based on what we saw in the directory)
$content = $content -replace 'banner\.jpg', 'brigade-eternia_1920x780-01.webp'
$content = $content -replace 'mobile-banner\.jpg', 'mobile-01_2.webp'
$content = $content -replace 'Brigade-city-logo\.svg', 'logo_4.png'
$content = $content -replace 'Brigade CRAFTING LANDMARKS LOGO BOLD-01\.webp', 'logo_4.png'
$content = $content -replace 'gallery-01\.webp', 'Brigade-Eternia-Photo.webp'
$content = $content -replace 'gallery-03\.webp', 'Brigade-Eternia-Photo_3.webp'

# SEO Title/Description
$content = $content -replace '<title>.*?</title>', '<title>Brigade Eternia Yelahanka | 3 &amp; 4 BHK Luxury Apartments in North Bengaluru</title>'
$content = $content -replace '<meta name="description".*?>', '<meta name="description" content="Brigade Eternia in Yelahanka, North Bengaluru offers luxury 3 &amp; 4 BHK apartments across 14 acres. Experience premium amenities, winding alleys, and a grand signature clubhouse. Starting from INR 2.47 Crore Onwards*.">'
$content = $content -replace '<meta name="keywords".*?>', '<meta name="keywords" content="Brigade Eternia, Brigade Eternia Yelahanka, Brigade Eternia Bangalore, 3 BHK luxury apartments Yelahanka, 4 BHK luxury apartments North Bengaluru, Brigade Group properties, Brigade apartments in Yelahanka">'

# Amenities (since there are 55+ amenities in the old one, we should probably update the amenities list)
# But we can just use powershell script to overwrite the amenities section using regex, or I can manually do it after.

Set-Content 'index.html' -Value $content
