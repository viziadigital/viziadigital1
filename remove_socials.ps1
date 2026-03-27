$files = Get-ChildItem -Path 'C:\Users\kooro\Downloads\viziadigital.github.io-main' -Filter '*.html' -Recurse |
  Where-Object { $_.FullName -notmatch '\\ua\\' }

foreach ($f in $files) {
  $t = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
  # Remove Telegram footer social btn
  $newT = [regex]::Replace($t, '<a class="footer-social-btn" href="https://t\.me/[^"]*">.*?Telegram</a>', '', [System.Text.RegularExpressions.RegexOptions]::Singleline)
  # Remove WhatsApp footer social btn
  $newT = [regex]::Replace($newT, '<a class="footer-social-btn" href="https://wa\.me/[^"]*">.*?WhatsApp</a>', '', [System.Text.RegularExpressions.RegexOptions]::Singleline)
  if ($newT -ne $t) {
    [System.IO.File]::WriteAllText($f.FullName, $newT, [System.Text.Encoding]::UTF8)
    Write-Host "updated: $($f.Name)"
  }
}
Write-Host "done"
