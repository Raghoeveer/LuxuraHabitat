$file = 'c:\websites_vs\New folder\La Vita\index.html'
$html = Get-Content $file -Raw

# 1. Restore the deleted nav lines and hero section opening, while applying the user's requested text changes
$badPattern = '(?s)<li><a href="#pricing">Pricing</a></li>\s*<div class="hero-container">'
$restoredContent = '<li><a href="#pricing">Pricing</a></li>
            <li><a href="#location">Location</a></li>
            <li><a href="#form">Enquire</a></li>
        </ul>

        <div class="nav-buttons" id="navButtons">
            <a href="tel:+918438344093" class="phone-section">
                <div class="phone-number">Call: 8438344093</div>
            </a>

            <a href="https://wa.me/918438344093?text=Hi%20I%20would%20like%20to%20know%20more%20about%20Sattva%20La Vita%20Phase%202%20and%20available%20offers" class="whatsapp-btn" target="_blank" rel="noopener">
                <span>Send Details in Whatsapp</span>
            </a>
        </div>
    </nav>

    <section class="hero" id="hero">
        <div class="hero-container">'

$html = [regex]::Replace($html, $badPattern, $restoredContent, 'IgnoreCase')
Set-Content $file -Value $html
