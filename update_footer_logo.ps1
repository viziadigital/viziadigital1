$files = Get-ChildItem 'C:\Users\kooro\Downloads\viziadigital.github.io-main' -Recurse -Include '*.html' | Where-Object { $_.FullName -notlike '*\ua\*' }
$old = '<a class="footer-brand-logo" href="/">Vizia</a>'
$new = '<a class="footer-brand-logo" href="/"><img alt="Vizia" src="/assets/images/logo.svg"></a>'
foreach ($f in $files) {
  $t = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
  if ($t.Contains($old)) {
    $t = $t.Replace($old, $new)
    [System.IO.File]::WriteAllText($f.FullName, $t, [System.Text.Encoding]::UTF8)
    Write-Host "logo updated: $($f.Name)"
  }
}
