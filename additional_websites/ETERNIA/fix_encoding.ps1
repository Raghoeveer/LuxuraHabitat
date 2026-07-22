$content = Get-Content 'index.html' -Raw
$content = $content -replace '-\+', '&#9670;'
$content = $content -replace 'â—†', '&#9670;'
$content = $content -replace '◆', '&#9670;'
[System.IO.File]::WriteAllText('index.html', $content, [System.Text.Encoding]::UTF8)
