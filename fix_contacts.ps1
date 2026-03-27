$files = Get-ChildItem 'C:\Users\kooro\Downloads\viziadigital.github.io-main' -Recurse -Include '*.html' |
  Where-Object { $_.FullName -notlike '*\ua\*' -and $_.Name -ne 'studio.html' }

# Old contact block patterns to replace
$oldPatterns = @(
  # contacts-photo.png + Kyrylo
  @{
    old = 'src="/assets/images/contacts-photo.png"><div><p class="contacts-contact-name">Kyrylo Klymenko</p><p>Founder</p>'
    new = 'src="/assets/images/team-victoria.png" style="filter:grayscale(1)"><div><p class="contacts-contact-name">Victoria Svynobij</p><p>Producer</p>'
  }
)

$phoneIcon = '<svg fill="none" height="16" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" width="16"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07A19.5 19.5 0 0 1 4.69 12 19.79 19.79 0 0 1 1.61 3.41 2 2 0 0 1 3.6 1.24h3a2 2 0 0 1 2 1.72c.127.96.361 1.903.7 2.81a2 2 0 0 1-.45 2.11L7.91 8.77a16 16 0 0 0 6.29 6.29l.95-.95a2 2 0 0 1 2.11-.45c.907.339 1.85.573 2.81.7A2 2 0 0 1 22 16.92z"></path></svg>'
$tgIcon = '<svg fill="currentColor" height="16" viewBox="0 0 24 24" width="16"><path d="M12 0C5.373 0 0 5.373 0 12s5.373 12 12 12 12-5.373 12-12S18.627 0 12 0zm5.894 8.221-1.97 9.28c-.145.658-.537.818-1.084.508l-3-2.21-1.447 1.394c-.16.16-.295.295-.605.295l.213-3.053 5.56-5.023c.242-.213-.054-.333-.373-.12L7.14 13.63l-2.95-.924c-.64-.203-.657-.64.136-.954l11.57-4.461c.537-.194 1.006.131.998.93z"/></svg>'
$waIcon = '<svg fill="currentColor" height="16" viewBox="0 0 24 24" width="16"><path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 0 1-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 0 1-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 0 1 2.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0 0 12.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 0 0 5.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 0 0-3.48-8.413z"/></svg>'
$emailIcon = '<svg fill="none" height="16" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" width="16"><rect height="16" rx="2" width="20" x="2" y="4"></rect><path d="m22 7-8.97 5.7a1.94 1.94 0 0 1-2.06 0L2 7"></path></svg>'

$newList = '<ul class="contacts-contact-list">' +
  '<li><a href="mailto:contact@vizia.digital">' + $emailIcon + 'contact@vizia.digital</a></li>' +
  '<li><a href="tel:+380969210887">' + $phoneIcon + '+380 96 921 08 87</a></li>' +
  '<li><a href="https://t.me/svinobijv">' + $tgIcon + 'Telegram</a></li>' +
  '<li><a href="https://wa.me/+380969210887">' + $waIcon + 'WhatsApp</a></li>' +
  '</ul>'

foreach ($f in $files) {
  $t = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
  $changed = $false

  # Replace photo + name
  foreach ($p in $oldPatterns) {
    if ($t.Contains($p.old)) {
      $t = $t.Replace($p.old, $p.new)
      $changed = $true
    }
  }

  # Replace contact list (any existing list → Victoria's)
  $pattern = '<ul class="contacts-contact-list">.*?</ul>'
  $newText = [regex]::Replace($t, $pattern, $newList, [System.Text.RegularExpressions.RegexOptions]::Singleline)
  if ($newText -ne $t) { $t = $newText; $changed = $true }

  if ($changed) {
    [System.IO.File]::WriteAllText($f.FullName, $t, [System.Text.Encoding]::UTF8)
    Write-Host "updated: $($f.Name)"
  } else {
    Write-Host "skipped: $($f.Name)"
  }
}
