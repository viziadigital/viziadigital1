$t = [System.IO.File]::ReadAllText('C:\Users\kooro\Downloads\viziadigital.github.io-main\studio.html', [System.Text.Encoding]::UTF8)
$start = $t.IndexOf('studio-team-slider')
$end = $t.IndexOf('How we work')
$chunk = $t.Substring($start - 5, $end - $start + 20)
# Count opening and closing divs
$opens = ([regex]::Matches($chunk, '<div')).Count
$closes = ([regex]::Matches($chunk, '</div>')).Count
Write-Host "Opens: $opens  Closes: $closes  (should be equal)"
Write-Host ""
Write-Host "Last 200 chars before 'How we work':"
Write-Host $t.Substring($end - 200, 200)
