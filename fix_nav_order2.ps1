$files = Get-ChildItem -Path 'C:\Users\kooro\Downloads\viziadigital.github.io-main' -Filter '*.html' -Recurse |
  Where-Object { $_.FullName -notmatch '\\ua\\' }

foreach ($f in $files) {
  $t = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
  # Match Projects and Studio li items with optional whitespace/newlines between them
  $newT = [regex]::Replace(
    $t,
    '(<li[^>]*><a href="/works\.html">Projects</a></li>)(\s*)(<li[^>]*><a href="/studio\.html">Studio</a></li>)',
    '$3$2$1',
    [System.Text.RegularExpressions.RegexOptions]::Singleline
  )
  if ($newT -ne $t) {
    [System.IO.File]::WriteAllText($f.FullName, $newT, [System.Text.Encoding]::UTF8)
    Write-Host "updated: $($f.Name)"
  } else {
    Write-Host "skip: $($f.Name)"
  }
}
Write-Host "done"
