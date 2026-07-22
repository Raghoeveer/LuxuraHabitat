$content = Get-Content 'index.html' -Raw

# 1. Clean up lingering 'Vivera' and 'Brigadevivera'
$content = $content -replace '(?i)Brigadevivera', 'brigadeeterniayelahanka'
$content = $content -replace '(?i)Brigade-vivera', 'Brigade-Eternia'
$content = $content -replace '(?i)vivera-Amenities', 'Brigade-Eternia-Amenities'
$content = $content -replace '(?i)vivera-elevation', 'Brigade-Eternia-elevation'
$content = $content -replace '(?i)vivera-5', 'Brigade-Eternia-5'
$content = $content -replace '(?i)\bVivera\b', 'Brigade Eternia'

# 2. Structure details
$content = $content -replace '3 Towers', '12 Towers'
$content = $content -replace '3 iconic towers', '12 iconic towers'
$content = $content -replace '3 beautifully designed residential towers', '12 beautifully designed residential towers'
$content = $content -replace '2B \+ G \+ 17 Floors', '2B+G+13/14 Floors'
$content = $content -replace '6.2 pristine acres', '14 pristine acres'
$content = $content -replace '6.2 Acres', '14 Acres'
$content = $content -replace '1,124 units', '1124 Units'

# 3. Clean up specific outdated phrases that were missed
$content = $content -replace 'only 55 units per acre', 'thoughtfully planned spaces'
$content = $content -replace '55\+ world-class amenities', 'world-class amenities'
$content = $content -replace 'spread across 2\.5 acres', 'spread across the expansive township'
$content = $content -replace 'spanning 2\.5 acres', 'spanning the expansive township'
$content = $content -replace '2\.5 acres dedicated purely to', 'expansive green spaces dedicated purely to'
$content = $content -replace '2 Grand Clubhouses', 'a grand signature Clubhouse'
$content = $content -replace '2 grand clubhouses', 'a grand signature Clubhouse'

[System.IO.File]::WriteAllText('index.html', $content, [System.Text.Encoding]::UTF8)
