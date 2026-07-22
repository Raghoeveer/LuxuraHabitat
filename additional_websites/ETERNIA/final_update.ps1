$content = Get-Content 'index.html' -Raw

$content = $content -replace 'Spanning over 2\.5 acres', 'Spanning expansive green spaces'
$content = $content -replace 'on Yelahanka near Yelahanka', 'in Yelahanka'

$paymentPlanCard = @"
                <div class="usp-card">
                    <div class="usp-icon">&#10022;</div>
                    <h3 class="usp-title">Exclusive Payment Plans</h3>
                    <p class="usp-desc" style="font-weight: 600; line-height: 2; margin-top: 10px;">
                        ◆ 50:50 Pay Plan<br>
                        ◆ Pay Just 10% To Book<br>
                        ◆ FlexiChoice Payment Plan
                    </p>
                </div>
"@

# Insert after the Prime North Bengaluru Hub card.
$content = $content -replace '(?i)(<h3 class="usp-title">Prime North Bengaluru Hub</h3>\s*<p class="usp-desc">Strategically positioned in Yelahanka, providing rapid connectivity to top tech parks, leading schools, and the airport\.</p>\s*</div>)', "`$1`n$paymentPlanCard"

[System.IO.File]::WriteAllText('index.html', $content, [System.Text.Encoding]::UTF8)
