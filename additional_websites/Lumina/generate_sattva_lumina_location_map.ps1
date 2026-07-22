Add-Type -AssemblyName System.Drawing

$width = 1200
$height = 1000
$bitmap = New-Object System.Drawing.Bitmap $width, $height
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)
$graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$graphics.Clear([System.Drawing.ColorTranslator]::FromHtml("#f8fafc"))

function Brush($hex) { New-Object System.Drawing.SolidBrush ([System.Drawing.ColorTranslator]::FromHtml($hex)) }
function Pen($hex, $w = 1) { New-Object System.Drawing.Pen ([System.Drawing.ColorTranslator]::FromHtml($hex)), $w }
function Font($name, $size, $style = [System.Drawing.FontStyle]::Regular) { New-Object System.Drawing.Font $name, $size, $style }

$cPrimary = "#0f172a"
$cSecondary = "#475569"
$cAccent = "#0284c7"
$cHighway = "#cbd5e1"
$cGreen = "#16a34a"
$cAlert = "#b91c1c"

$fontTitle = Font "Arial" 26 ([System.Drawing.FontStyle]::Bold)
$fontSubtitle = Font "Arial" 15
$fontBold = Font "Arial" 14 ([System.Drawing.FontStyle]::Bold)
$fontRegular = Font "Arial" 13
$fontSmall = Font "Arial" 11

function Draw-Text($x, $y, $text, $color, $font) {
    $graphics.DrawString($text, $font, (Brush $color), [single]$x, [single]$y)
}

function Fill-Rect($x1, $y1, $x2, $y2, $color) {
    $graphics.FillRectangle((Brush $color), $x1, $y1, ($x2 - $x1), ($y2 - $y1))
}

function Stroke-Line($x1, $y1, $x2, $y2, $color, $w = 1) {
    $graphics.DrawLine((Pen $color $w), $x1, $y1, $x2, $y2)
}

function Draw-Node($x, $y, $title, $subtitle, $markerColor, $w = 250, $h = 65) {
    $x1 = [int]($x - $w / 2)
    $y1 = [int]($y - $h / 2)
    $path = New-Object System.Drawing.Drawing2D.GraphicsPath
    $radius = 8
    $path.AddArc($x1, $y1, $radius, $radius, 180, 90)
    $path.AddArc($x1 + $w - $radius, $y1, $radius, $radius, 270, 90)
    $path.AddArc($x1 + $w - $radius, $y1 + $h - $radius, $radius, $radius, 0, 90)
    $path.AddArc($x1, $y1 + $h - $radius, $radius, $radius, 90, 90)
    $path.CloseFigure()
    $graphics.FillPath((Brush "#ffffff"), $path)
    $graphics.DrawPath((Pen "#cbd5e1" 2), $path)
    $graphics.FillEllipse((Brush $markerColor), ($x - 6), ($y1 - 6), 12, 12)
    Draw-Text ($x1 + 12) ($y1 + 10) $title $cPrimary $fontBold
    Draw-Text ($x1 + 12) ($y1 + 32) $subtitle $cSecondary $fontSmall
}

$graphics.FillPie((Brush "#e0f2fe"), 40, 160, 220, 180, 0, 360)
$graphics.DrawPie((Pen "#bae6fd" 2), 40, 160, 220, 180, 0, 360)
Draw-Text 90 240 "Nagadasanahalli`n      Lake" "#0369a1" $fontSmall

Fill-Rect 340 0 380 400 $cHighway
for ($y = 0; $y -lt 400; $y += 30) { Stroke-Line 360 $y 360 ($y + 15) "#ffffff" 2 }
Fill-Rect 840 0 880 ($height - 120) "#94a3b8"
for ($y = 0; $y -lt ($height - 120); $y += 30) { Stroke-Line 860 $y 860 ($y + 15) "#ffffff" 2 }
Fill-Rect 360 380 840 415 $cHighway
for ($x = 360; $x -lt 840; $x += 30) { Stroke-Line $x 397 ($x + 15) 397 "#ffffff" 2 }
Fill-Rect 0 660 $width 695 "#64748b"
for ($x = 0; $x -lt $width; $x += 30) { Stroke-Line $x 677 ($x + 15) 677 "#ffffff" 2 }
Fill-Rect 840 685 880 $height "#475569"

Draw-Text 120 25 "Doddaballapura Main Road (SH-9)" $cSecondary $fontSubtitle
Draw-Text 490 355 "Yelahanka Connecting Arterial" $cSecondary $fontSubtitle
Draw-Text 900 25 "NH-44 (Bellary Airport Highway)" $cSecondary $fontSubtitle
Draw-Text 40 635 "Outer Ring Road (ORR Interchange)" $cSecondary $fontSubtitle
Draw-Text 900 840 "Cubbon Road / Raj Bhavan Link" $cSecondary $fontSubtitle

$pX = 360
$pY = 240
$graphics.DrawEllipse((Pen "#bae6fd" 3), ($pX - 45), ($pY - 45), 90, 90)
$graphics.FillEllipse((Brush $cAccent), ($pX - 25), ($pY - 25), 50, 50)
Draw-Text ($pX - 18) ($pY - 7) "SITE" "#ffffff" $fontBold

Fill-Rect 40 280 300 440 "#ffffff"
$graphics.DrawRectangle((Pen $cAccent 2), 40, 280, 260, 160)
Draw-Text 55 295 "SATTVA LUMINA" $cPrimary $fontBold
Draw-Text 55 320 "- 13.88 Acre Lakeview Land`n- Towers: 8 Blocks | G+29`n- Launch Matrix: Nov 2024`n- RERA: PRM/KA/RERA/...7009" $cSecondary $fontRegular

Draw-Node 360 90 "Rajanukunte Station" "2.1 KM From Site | Rail Link" $cAccent
Draw-Node 860 90 "Kempegowda Int'l Airport" "20.1 KM | Toll-Free Corridor Link" "#d97706"
Draw-Node 360 480 "Yelahanka Junction" "12.7 KM | Major Rail Hub Interchange" $cAccent
Draw-Node 610 240 "Dravid Padukone CSE" "3.9 KM | International Sports Centre" $cGreen
Draw-Node 860 240 "KIADB Aerospace Park" "Major Aviation & Hardware IT SEZ" "#d97706"
Draw-Node 860 520 "Phoenix Mall of Asia" "Premium Retail & Entertainment Hub" $cGreen
Draw-Node 860 675 "Hebbal Flyover Junction" "22 KM Checkpoint | Gateway to City" $cPrimary 260
Draw-Node 1060 600 "Manyata Tech Park" "17.8 KM | Key IT Employment Hub" $cAccent
Draw-Node 860 840 "Vidhana Soudha / Cubbon Park" "Administrative Core Landmark" $cAlert
Draw-Node 860 930 "MG Road Central CBD" "27.1 KM Direct Ride from Project Site" $cAlert 270 70

Fill-Rect 0 0 $width 85 $cPrimary
Draw-Text 40 15 "SATTVA LUMINA - REGIONAL NORTH-TO-CENTRAL CONNECTIVITY MAP" "#ffffff" $fontTitle
Draw-Text 40 52 "Complete 27.1 KM Corridor Analysis from Rajanukunte Hub down to the MG Road Central CBD Vector" "#94a3b8" $fontRegular

Fill-Rect 0 ($height - 40) $width $height "#f1f5f9"
Draw-Text 40 ($height - 26) "Disclaimer: Map graphic layout is conceptual and designed for macro-geographical navigation and structural reference only. Distances are approximate values." $cSecondary $fontSmall

$output = Join-Path $PSScriptRoot "sattva-lumina-location.jpg"
$bitmap.Save($output, [System.Drawing.Imaging.ImageFormat]::Jpeg)
$graphics.Dispose()
$bitmap.Dispose()
Write-Host "Map generated at: $output"
