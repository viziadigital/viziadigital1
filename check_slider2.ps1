$t = [System.IO.File]::ReadAllText('C:\Users\kooro\Downloads\viziadigital.github.io-main\studio.html', [System.Text.Encoding]::UTF8)
$matches = [regex]::Matches($t, '<script>', [System.Text.RegularExpressions.RegexOptions]::None)
Write-Host "script tags count: " $matches.Count
Write-Host "has viewport.offsetWidth: " ($t -match 'viewport\.offsetWidth')
Write-Host "has setCardWidths: " ($t -match 'setCardWidths')
Write-Host "old compact JS gone: " (-not ($t -match 'var track=document\.querySelector'))
