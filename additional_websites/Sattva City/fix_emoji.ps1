$content = Get-Content -Path "index.html" -Raw

$replacements = @{
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
    "â€“" = "–"
    "â€”" = "—"
    "â€¢" = "•"
    "â€˜" = "‘"
    "â€™" = "’"
}

foreach ($key in $replacements.Keys) {
    $content = $content.Replace($key, $replacements[$key])
}

Set-Content -Path "index.html" -Value $content -Encoding UTF8
