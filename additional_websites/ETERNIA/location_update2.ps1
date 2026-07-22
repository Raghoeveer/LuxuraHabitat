Copy-Item -Path "Brigade-Eternia-location-map.jpg" -Destination "Brigade-Eternia-location-map.webp" -Force

$content = Get-Content 'index.html' -Raw

# Replace iframe with img tag
$iframeRegex = '(?si)<iframe src="https://www\.google\.com/maps/embed\?pb=[^>]+></iframe>'
$imgTag = '<img src="Brigade-Eternia-location-map.webp" alt="Brigade Eternia Yelahanka Location Map" loading="lazy" style="width: 100%; height: 100%; object-fit: cover; border-radius: 12px; box-shadow: 0 10px 30px rgba(0,0,0,0.1);" onclick="if(document.getElementById(''mapModal'')) { document.getElementById(''mapModal'').style.display=''flex''; }">'
$content = [regex]::Replace($content, $iframeRegex, $imgTag)

# Update any lingering references to location_3.jpg, location_3.webp, location_map.webp
$content = $content -replace 'location_3\.jpg', 'Brigade-Eternia-location-map.webp'
$content = $content -replace 'location_3\.webp', 'Brigade-Eternia-location-map.webp'
$content = $content -replace 'location_map\.webp', 'Brigade-Eternia-location-map.webp'

[System.IO.File]::WriteAllText('index.html', $content, [System.Text.Encoding]::UTF8)
