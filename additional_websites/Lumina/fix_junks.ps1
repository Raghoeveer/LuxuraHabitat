$path = "c:\websites_vs\New folder\Lumina\index.html"
$content = Get-Content -Path $path -Raw -Encoding UTF8

$replacements = @{
    'ðŸ” ' = '&#128269;'
    'âœ•' = '&times;'
    'ðŸ“ž' = '&#128222;'
    'ðŸ“±' = '&#128241;'
    'ðŸ’¬' = '&#128172;'
    'âœ‰ï¸ ' = '&#9993;'
    'designâ€”explore' = 'design&mdash;explore'
    'amenitiesâ€”built' = 'amenities&mdash;built'
    'ðŸ ¢' = '&#127970;'
    'ðŸŒ¿' = '&#127807;'
    'ðŸ ™ï¸ ' = '&#127970;'
    'ðŸ €' = '&#9917;'
    'ðŸ”’' = '&#129309;'
    'âš-ï¸ ' = '&#9888;'
    'Â(c)' = '&copy;'
    'â ®' = '&#10094;'
    'â ¯' = '&#10095;'
    'A(c)' = '&copy;'
    'o ' = '&times;'
}

foreach ($key in $replacements.Keys) {
    $content = $content.Replace($key, $replacements[$key])
}

Set-Content -Path $path -Value $content -Encoding UTF8
Write-Output "Done"
