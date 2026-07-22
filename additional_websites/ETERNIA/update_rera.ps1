$content = Get-Content 'index.html' -Raw
$content = $content -replace '\[PRM/KA/RERA/XXXXX/XXXXX\]', 'PRM/KA/RERA/1251/309/PR/070325/007559'
[System.IO.File]::WriteAllText('index.html', $content, [System.Text.Encoding]::UTF8)
