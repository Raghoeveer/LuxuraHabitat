$content = Get-Content 'index.html' -Raw

$content = $content -replace 'location-map\.jpg', 'location_3.jpg'
$content = $content -replace 'master-plan\.jpg', 'Brigade-Eternia-master_plan-01.webp'

[System.IO.File]::WriteAllText('index.html', $content, [System.Text.Encoding]::UTF8)
