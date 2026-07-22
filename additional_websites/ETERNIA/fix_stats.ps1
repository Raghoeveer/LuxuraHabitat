$content = Get-Content 'index.html' -Raw

# Fix the stats block
$oldStatsBlock = @"
          <div class="stats-inner">
              <div class="stat-item">
                  <div class="stat-number">6.2</div>
                  <div class="stat-label">Acres Property</div>
              </div>
              <div class="stat-item">
                  <div class="stat-number">85%</div>
                  <div class="stat-label">Open Space</div>
              </div>
              <div class="stat-item">
                  <div class="stat-number">55+</div>
                  <div class="stat-label">Lifestyle Amenities</div>
              </div>
              <div class="stat-item">
                  <div class="stat-number">2</div>
                  <div class="stat-label">Grand Clubhouses</div>
              </div>
          </div>
"@

$newStatsBlock = @"
          <div class="stats-inner">
              <div class="stat-item">
                  <div class="stat-number">14</div>
                  <div class="stat-label">Acres Property</div>
              </div>
              <div class="stat-item">
                  <div class="stat-number">12</div>
                  <div class="stat-label">Iconic Towers</div>
              </div>
              <div class="stat-item">
                  <div class="stat-number">1124</div>
                  <div class="stat-label">Total Units</div>
              </div>
              <div class="stat-item">
                  <div class="stat-number">13/14</div>
                  <div class="stat-label">Floors Structure</div>
              </div>
          </div>
"@

# Since whitespace might not match exactly, we'll replace individual parts with Regex
$content = $content -replace '<div class="stat-number">6\.2</div>\s*<div class="stat-label">Acres Property</div>', '<div class="stat-number">14</div>
                  <div class="stat-label">Acres Property</div>'

$content = $content -replace '<div class="stat-number">85%</div>\s*<div class="stat-label">Open Space</div>', '<div class="stat-number">12</div>
                  <div class="stat-label">Iconic Towers</div>'

$content = $content -replace '<div class="stat-number">55\+</div>\s*<div class="stat-label">Lifestyle Amenities</div>', '<div class="stat-number">1124</div>
                  <div class="stat-label">Total Units</div>'

$content = $content -replace '<div class="stat-number">2</div>\s*<div class="stat-label">Grand Clubhouses</div>', '<div class="stat-number">13/14</div>
                  <div class="stat-label">Floors Structure</div>'

# Fix the leftover 6.2 strings
$content = $content -replace '6\.2-acre boutique residential enclave', '14-acre integrated township'
$content = $content -replace '6\.2-Acre Masterpiece', '14-Acre Masterpiece'

[System.IO.File]::WriteAllText('index.html', $content, [System.Text.Encoding]::UTF8)
