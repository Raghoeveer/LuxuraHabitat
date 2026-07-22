Copy-Item -Path "location_3.jpg" -Destination "location_3.webp" -Force

$content = Get-Content 'index.html' -Raw

# Replace iframe with img tag
$iframeRegex = '(?si)<iframe src="https://www\.google\.com/maps/embed\?pb=[^>]+></iframe>'
$imgTag = '<img src="location_3.webp" alt="Brigade Eternia Yelahanka Location Map" loading="lazy" onclick="if(document.getElementById(''mapModal'')) { document.getElementById(''mapModal'').style.display=''flex''; }">'
$content = [regex]::Replace($content, $iframeRegex, $imgTag)

# Update any lingering references to location_3.jpg
$content = $content -replace 'location_3\.jpg', 'location_3.webp'

[System.IO.File]::WriteAllText('index.html', $content, [System.Text.Encoding]::UTF8)
