$path = "c:\websites_vs\New folder\Sattva City\index.html"
$content = Get-Content -Path $path -Raw -Encoding UTF8
$replacements = @{
    "â€“" = "–"
    "â€”" = "—"
    "â€¢" = "•"
    "â€˜" = "‘"
    "â€™" = "’"
    "â–¼" = "▼"
    "Â©" = "©"
    "âœ“" = "✓"
    "Ã—" = "×"
    "âž”" = "➔"
    "â€œ" = "“"
    "â€ " = "”"
    "Ã¢â‚¬Â¢" = "•"
    "âœˆï¸ " = "✈️"
    "ðŸ —ï¸ " = "🏗️"
    "ðŸŒ¿" = "🌿"
    "ðŸ ¡" = "🏡"
    "ðŸ“ˆ" = "📈"
    "ðŸ› ï¸ " = "🛍️"
    "ðŸ ‹ï¸ " = "🏋️"
    "ðŸ§˜" = "🧘"
    "ðŸŽ­" = "🎬"
    "ðŸ‘¨â€ ðŸ‘©â€ ðŸ‘§" = "👨‍👩‍👧"
    "ðŸ ¢" = "🏢"
    "ðŸŽ“" = "🎓"
    "ðŸ ³" = "🍳"
    "âš¡" = "⚡"
    "ðŸšª" = "🚪"
    "ðŸš¿" = "🚽"
    "ðŸ“‹" = "📋"
}
foreach ($k in $replacements.Keys) {
    $content = $content.Replace($k, $replacements[$k])
}
Set-Content -Path $path -Value $content -Encoding UTF8
Write-Host "Replaced all broken encodings."
