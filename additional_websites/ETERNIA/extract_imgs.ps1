$content = Get-Content 'index.html' -Raw
$matches = [regex]::Matches($content, '(?i)<img[^>]+src=["'']([^"'']+)["'']')
foreach ($m in $matches) {
    Write-Output $m.Groups[1].Value
}
