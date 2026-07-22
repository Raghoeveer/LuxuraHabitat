$content = Get-Content "index.html" -Raw -Encoding UTF8

$galIndex = $content.IndexOf("    <!-- ===== GALLERY ===== -->")
$locIndex = $content.IndexOf("    <!-- ===== LOCATION ===== -->")
$priceIndex = $content.IndexOf("    <!-- ===== PRICING ===== -->")
$specIndex = $content.IndexOf("    <!-- ===== SPECIFICATIONS ===== -->")

if ($galIndex -gt 0 -and $locIndex -gt $galIndex -and $priceIndex -gt $locIndex -and $specIndex -gt $priceIndex) {
    $beforeGal = $content.Substring(0, $galIndex)
    $galBlock = $content.Substring($galIndex, $locIndex - $galIndex)
    $locPriceBlock = $content.Substring($locIndex, $specIndex - $locIndex)
    $afterPrice = $content.Substring($specIndex)
    
    $newContent = $beforeGal + $locPriceBlock + $galBlock + $afterPrice
    Set-Content "index.html" -Value $newContent -Encoding UTF8
    Write-Host "Success! DOM reordered."
} else {
    Write-Host "Failed to find indices properly."
    Write-Host "Gal: $galIndex, Loc: $locIndex, Price: $priceIndex, Spec: $specIndex"
}
