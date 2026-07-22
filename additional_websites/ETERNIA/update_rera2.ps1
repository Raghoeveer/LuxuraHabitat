$content = Get-Content 'index.html' -Raw

# 1. Global Replacement of old RERA number with the new one
$oldRera = 'PRM/KA/RERA/1251/472/PR/031125/008217'
$newRera = 'PRM/KA/RERA/1251/309/PR/070325/007559'
$content = $content.Replace($oldRera, $newRera)

# Replace the placeholder if it exists anywhere
$content = $content.Replace('[PRM/KA/RERA/XXXXX/XXXXX]', $newRera)

# 2. Add the Agent Disclaimer explicitly to the footer (if not already there)
if ($content -notmatch 'Agent Disclaimer & Compliance') {
    $footerDisclaimer = @"
              <div class="footer-disclaimer" style="width: 100%; text-align: left; margin-top: 2rem; padding-top: 2rem; border-top: 1px solid rgba(255,255,255,0.1); font-size: 0.75rem; color: rgba(255,255,255,0.6); line-height: 1.6;">
                  <strong>Agent Disclaimer & Compliance:</strong> This website is maintained by an authorized channel partner / marketing agent for informational and marketing purposes only. It does not constitute the official developer website. Any information presented here, including but not limited to project details, specifications, floor plans, pricing, and images, is subject to change based on the developer's discretion and final approval. By using this website, you consent to our team contacting you via calls, SMS, or WhatsApp to share relevant real estate opportunities. <br><br>
                  <strong>RERA Registration:</strong> Brigade Eternia is registered under the Karnataka Real Estate Regulatory Authority (K-RERA). RERA No: <strong>$newRera</strong>. For more details, visit <a href="https://rera.karnataka.gov.in/" target="_blank" style="color: var(--accent-gold); text-decoration: underline;">rera.karnataka.gov.in</a>.
              </div>
"@
    
    # We will just append it inside the footer tag, before it closes
    $content = [regex]::Replace($content, '(?si)</footer>', "$footerDisclaimer`n    </footer>")
}

[System.IO.File]::WriteAllText('index.html', $content, [System.Text.Encoding]::UTF8)
