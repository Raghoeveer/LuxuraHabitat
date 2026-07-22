$filePath = 'c:\websites_vs\New folder\Sattva City\index.html'
$content = Get-Content -Path $filePath -Raw -Encoding UTF8
$content = $content.Replace('`n', [Environment]::NewLine)
Set-Content -Path $filePath -Value $content -Encoding UTF8
Write-Output "Fixed."
