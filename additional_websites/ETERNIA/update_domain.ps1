$oldUrl = 'brigadeeterniayelahanka.projectdetail.net'
$newUrl = 'eterniayelahanka.projectdetail.net'

# Update index.html
$content = Get-Content 'index.html' -Raw
$content = $content.Replace($oldUrl, $newUrl)
[System.IO.File]::WriteAllText('index.html', $content, [System.Text.Encoding]::UTF8)

# Update robots.txt
$content = Get-Content 'robots.txt' -Raw
$content = $content.Replace($oldUrl, $newUrl)
[System.IO.File]::WriteAllText('robots.txt', $content, [System.Text.Encoding]::UTF8)

# Update sitemap.xml
$content = Get-Content 'sitemap.xml' -Raw
$content = $content.Replace($oldUrl, $newUrl)
[System.IO.File]::WriteAllText('sitemap.xml', $content, [System.Text.Encoding]::UTF8)
