$files = Get-ChildItem -Path 'C:\Users\kooro\Downloads\viziadigital.github.io-main' -Filter '*.html' -Recurse |
  Where-Object { $_.FullName -notmatch '\\ua\\' }

foreach ($f in $files) {
  $t = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
  # Swap Projects and Studio nav items (preserving any class attributes like text-underline)
  $newT = [regex]::Replace(
    $t,
    '(<li[^>]*><a href="/works\.html">Projects</a></li>)(<li[^>]*><a href="/studio\.html">Studio</a></li>)',
    '$2$1'
  )
  if ($newT -ne $t) {
    [System.IO.File]::WriteAllText($f.FullName, $newT, [System.Text.Encoding]::UTF8)
    Write-Host "updated: $($f.Name)"
  }
}
Write-Host "done"
