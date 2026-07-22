$content = Get-Content 'index.html' -Raw

# Replace empty alt tags
$content = [regex]::Replace($content, '(?si)alt=""', 'alt="Brigade Eternia Yelahanka Premium View"')
$content = [regex]::Replace($content, '(?si)alt="image"', 'alt="Brigade Eternia Yelahanka Project Snapshot"')
$content = [regex]::Replace($content, '(?si)alt="logo"', 'alt="Brigade Eternia Yelahanka Official Logo"')
$content = [regex]::Replace($content, '(?si)alt="banner"', 'alt="Brigade Eternia Yelahanka 14-Acre Masterpiece Banner"')

# Look specifically for Master Plan alt text to update as user requested
$content = [regex]::Replace($content, '(?si)alt="Brigade Eternia Master Plan Layout"', 'alt="Brigade Eternia Yelahanka Master Plan showing 14 acres layout"')

[System.IO.File]::WriteAllText('index.html', $content, [System.Text.Encoding]::UTF8)
