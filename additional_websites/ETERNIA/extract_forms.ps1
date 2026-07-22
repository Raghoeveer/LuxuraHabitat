$content = Get-Content 'index.html' -Raw
$forms = [regex]::Matches($content, '(?s)<form.*?</form>')
$i = 1
foreach ($f in $forms) {
    Set-Content -Path "form_$i.txt" -Value $f.Value
    $i++
}
