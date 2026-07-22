$content = Get-Content 'index.html' -Raw

$paymentPlanBlock = @"
<p class="usp-desc" style="font-weight: 600; line-height: 2; margin-top: 10px;">
                        &#9670; 50:50 Pay Plan<br>
                        &#9670; Pay Just 10% To Book<br>
                        &#9670; FlexiChoice Payment Plan
                    </p>
"@

$content = [regex]::Replace($content, '(?si)<p class="usp-desc"[^>]*>.*?50:50 Pay Plan.*?</p>', $paymentPlanBlock)

[System.IO.File]::WriteAllText('index.html', $content, [System.Text.Encoding]::UTF8)
