$lines = Get-Content "index.html" -Encoding UTF8

$beforeGallery = @()
$galleryBlock = @()
$locationBlock = @()
$pricingBlock = @()
$afterPricing = @()

$state = "beforeGallery"

for ($i = 0; $i -lt $lines.Count; $i++) {
    $line = $lines[$i]
    
    if ($line -match '<!-- ===== GALLERY ===== -->') {
        $state = "galleryBlock"
    } elseif ($line -match '<!-- ===== LOCATION ===== -->') {
        $state = "locationBlock"
    } elseif ($line -match '<!-- ===== PRICING ===== -->') {
        $state = "pricingBlock"
    } elseif ($line -match '<!-- ===== SPECIFICATIONS ===== -->') {
        $state = "afterPricing"
    }
    
    switch ($state) {
        "beforeGallery" { $beforeGallery += $line }
        "galleryBlock" { $galleryBlock += $line }
        "locationBlock" { $locationBlock += $line }
        "pricingBlock" { $pricingBlock += $line }
        "afterPricing" { $afterPricing += $line }
    }
}

$newLines = @()
$newLines += $beforeGallery
$newLines += $locationBlock
$newLines += $pricingBlock
$newLines += $galleryBlock
$newLines += $afterPricing

# Fix the nav menu back to the original order
for ($i = 0; $i -lt $newLines.Count; $i++) {
    if ($newLines[$i] -match '<li><a href="#gallery">Gallery</a></li>') {
        $newLines[$i] = '            <li><a href="#location">Location</a></li>'
        $newLines[$i+1] = '            <li><a href="#pricing">Pricing</a></li>'
        $newLines[$i+2] = '            <li><a href="#gallery">Gallery</a></li>'
    } elseif ($newLines[$i] -match '<li><a href="#location">Location</a></li>') {
        # Already replaced above, just skip if we encounter it directly
    }
}

# The above logic has a flaw if it matches sequentially. Let's do a strict replacement.
$html = $newLines -join "`n"

$oldNav = @"
        <ul class="nav-links" id="navLinks">
            <li><a href="#hero">Overview</a></li>
            <li><a href="#about">About</a></li>
            <li><a href="#floorplans">Floor Plans</a></li>
            <li><a href="#masterplan">Master Plan</a></li>
            <li><a href="#amenities">Amenities</a></li>
            <li><a href="#gallery">Gallery</a></li>
            <li><a href="#location">Location</a></li>
            <li><a href="#pricing">Pricing</a></li>
            <li><a href="#specs">Specs</a></li>
            <li><a href="#faq">FAQ</a></li>
            <li><a href="#form">Contact</a></li>
        </ul>
"@

$newNav = @"
        <ul class="nav-links" id="navLinks">
            <li><a href="#hero">Overview</a></li>
            <li><a href="#about">About</a></li>
            <li><a href="#floorplans">Floor Plans</a></li>
            <li><a href="#masterplan">Master Plan</a></li>
            <li><a href="#amenities">Amenities</a></li>
            <li><a href="#location">Location</a></li>
            <li><a href="#pricing">Pricing</a></li>
            <li><a href="#gallery">Gallery</a></li>
            <li><a href="#specs">Specs</a></li>
            <li><a href="#faq">FAQ</a></li>
            <li><a href="#form">Contact</a></li>
        </ul>
"@

$html = $html.Replace($oldNav, $newNav)

Set-Content "index.html" -Value $html -Encoding UTF8
Write-Host "Done!"
