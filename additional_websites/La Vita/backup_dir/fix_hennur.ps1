$file = 'c:\websites_vs\New folder\La Vita\index.html'
$html = Get-Content $file -Raw

$html = $html -replace '(?i)Hennur Hennur', 'Hennur'
$html = $html -replace '(?i)Hennur, Hennur', 'Hennur'

Set-Content $file -Value $html
