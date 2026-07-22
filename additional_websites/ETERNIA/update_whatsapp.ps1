$content = Get-Content 'index.html' -Raw
$content = $content -replace 'I%20want%20details%20about%20Brigade%20City', 'Hi%20I%20would%20like%20to%20get%20more%20info%20on%20Brigade%20Eternia'
[System.IO.File]::WriteAllText('index.html', $content, [System.Text.Encoding]::UTF8)
