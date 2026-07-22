$c = [IO.File]::ReadAllText('index.html')
$c = [Regex]::Replace($c, '[^\x00-\x7F]', '')
[IO.File]::WriteAllText('index.html', $c)
