$content = Get-Content 'index.html' -Raw

# Replace about section text to include Lifestyle & Architecture Highlights and Size Metrics
$aboutOldText = 'Brigade Eternia is a premium boutique luxury residential project developed by Brigade Group'
$aboutNewText = 'Brigade Eternia is a premium residential township by Brigade Group, featuring a Central Courtyard designed as a vibrant, multi-functional hub to keep residents active and connected. The layout design boasts winding alleys, cobbled paths, and expansive green spaces. The community focus is centered around a grand signature Clubhouse.'
$content = $content -replace [regex]::Escape($aboutOldText), $aboutNewText

# Inject size metrics text somewhere prominent, like in the config area.
# Find "The project offers 3 &amp; 4 BHK Luxury Apartments." and append it.
$configOldText = 'The project offers 3 &amp; 4 BHK Luxury Apartments. The 3 BHK units range from 1,653 to 2,926 Sq.ft, featuring 2-side open designs for maximum cross-ventilation.'
$configNewText = 'The project offers 3 &amp; 4 BHK Luxury Apartments. Size metrics include a Super Built-Up Area of 65.06 to 271.84 Sq.m. (700 to 2,926 Sq.ft.), Unit Carpet Area of 41.29 to 174.91 Sq.m. (444 to 1,883 Sq.ft.), and Balcony Carpet Area of 3.50 to 4.48 Sq.m. (38 to 48 Sq.ft.).'
$content = $content -replace [regex]::Escape($configOldText), $configNewText

[System.IO.File]::WriteAllText('index.html', $content, [System.Text.Encoding]::UTF8)
