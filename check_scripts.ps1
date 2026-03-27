$t = [System.IO.File]::ReadAllText('C:\Users\kooro\Downloads\viziadigital.github.io-main\studio.html', [System.Text.Encoding]::UTF8)
$matches = [regex]::Matches($t, '<script[^>]*>')
Write-Host "script tags: " $matches.Count
foreach ($m in $matches) {
  $pos = $m.Index
  Write-Host "  at pos $pos : " $m.Value " ..." $t.Substring($pos, [Math]::Min(80, $t.Length - $pos))
}
