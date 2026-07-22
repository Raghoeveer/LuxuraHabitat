$content = Get-Content 'index.html' -Raw
[System.IO.File]::WriteAllText('index.html', $content, [System.Text.Encoding]::UTF8)
