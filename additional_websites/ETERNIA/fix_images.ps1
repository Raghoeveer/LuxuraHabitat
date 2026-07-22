$content = Get-Content 'index.html' -Raw

# 1. Hero / Elevation Images
$content = $content -replace '(?i)Brigade-Eternia-Elevation\.webp', 'brigade-eternia_1920x780-01.webp'
$content = $content -replace '(?i)Brigade-Eternia-elevation-long-1\.webp', 'brigade-eternia_1920x780_copy.webp'
$content = $content -replace '(?i)Brigade-Eternia-elevation-night-2\.webp', 'frame_1.webp'
$content = $content -replace '(?i)Brigade-Eternia-Road\.webp', 'frame_4.webp'
$content = $content -replace '(?i)Brigade-Eternia-5\.webp', 'frame_5.webp'

# 2. Location & Master Plan
$content = $content -replace '(?i)location_map\.webp', 'location_3.jpg'
$content = $content -replace '(?i)Brigade-Eternia-master-plan\.webp', 'Brigade-Eternia-master_plan-01.webp'

# 3. Amenities
$content = $content -replace '(?i)Brigade-Eternia-Amenities 2\.webp', 'indoor_swimming_pool_1.webp'
$content = $content -replace '(?i)Brigade-Eternia-Amenities-3\.webp', 'gym.webp'
$content = $content -replace '(?i)Brigade-Eternia-Amenities-10\.webp', 'badminton-courts.webp'
$content = $content -replace '(?i)Brigade-Eternia-Amenities1\.webp', 'squash-court.webp'
# Ensure table-tennis and indoor-games-area are used if there are other images
$content = $content -replace '(?i)amenity-5\.jpg', 'table-tennis.webp'
$content = $content -replace '(?i)amenity-6\.jpg', 'indoor-games-area.webp'

# 4. Floor Plans (Directly replace the old file names with the new ones, and update the text around them)
$content = $content -replace '(?i)Brigade-Eternia-floor-plan-3BHK-1573\.webp', 'Brigade-Eternia-floor-Plan-3-bhk-1653-sq-ft.webp'
$content = $content -replace '(?i)3 BHK Floor Plan 1573 Sq\.Ft', '3 BHK Floor Plan 1653 Sq.Ft'
$content = $content -replace '(?i)1,573 Sq\.Ft', '1,653 Sq.Ft'

$content = $content -replace '(?i)Brigade-Eternia-floor-plan-3BHK-1680\.webp', 'Brigade-Eternia-floor-Plan-3-bhk-1848-sq-ft.webp'
$content = $content -replace '(?i)3 BHK Floor Plan 1680 Sq\.Ft', '3 BHK Floor Plan 1848 Sq.Ft'
$content = $content -replace '(?i)1,680 Sq\.Ft', '1,848 Sq.Ft'

$content = $content -replace '(?i)Brigade-Eternia-floor-plan-3BHK-1863\.webp', 'Brigade-Eternia-floor-Plan-3-bhk-1915-sq-ft.webp'
$content = $content -replace '(?i)3 BHK Floor Plan 1863 Sq\.Ft', '3 BHK Floor Plan 1915 Sq.Ft'
$content = $content -replace '(?i)1,863 Sq\.Ft', '1,915 Sq.Ft'

$content = $content -replace '(?i)Brigade-Eternia-floor-plan-3BHK-2069\.webp', 'Brigade-Eternia-floor-Plan-3-bhk-2111-sq-ft.webp'
$content = $content -replace '(?i)3 BHK Floor Plan 2069 Sq\.Ft', '3 BHK Floor Plan 2111 Sq.Ft'
$content = $content -replace '(?i)2,069 Sq\.Ft', '2,111 Sq.Ft'

$content = $content -replace '(?i)Brigade-Eternia-Typical-Plan\.webp', 'Brigade-Eternia-floor-Plan-4-bhk-2714-sq-ft.webp'
$content = $content -replace '(?i)3 BHK Floor Plan 2406 Sq\.Ft', '4 BHK Floor Plan 2714 Sq.Ft'
$content = $content -replace '(?i)2,406 Sq\.Ft', '2,714 Sq.Ft'

$content = $content -replace '(?i)Brigade-Eternia-floor-plan-Aura\.webp', 'Brigade-Eternia-floor-Plan-4-bhk-2926-sq-ft.webp'
$content = $content -replace '(?i)4 BHK Floor Plan - Brigade Eternia', '4 BHK Floor Plan 2926 Sq.Ft - Brigade Eternia'
# Wait, Aura didn't have size under it? Let's assume it has 4 BHK.

[System.IO.File]::WriteAllText('index.html', $content, [System.Text.Encoding]::UTF8)
