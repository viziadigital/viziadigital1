$behanceBtn = '<a class="footer-social-btn" href="https://www.behance.net/viziadigital" target="_blank" rel="noopener"><svg fill="currentColor" height="14" viewBox="0 0 24 24" width="14"><path d="M22 7h-7V5h7v2zm1.726 10c-.442 1.297-2.029 3-5.101 3-3.074 0-5.564-1.729-5.564-5.675 0-3.91 2.325-5.92 5.466-5.92 3.082 0 4.964 1.782 5.375 4.426.078.506.109 1.188.095 2.14H15.97c.13 1.2.517 1.95 1.57 2.163.972.196 1.813-.078 2.286-.945h3.9zm-5.26-4c.01-.707-.155-1.967-1.64-1.967-1.366 0-1.698 1.067-1.703 1.967h3.344zM7.26 9.068c.49 0 1.153.034 1.697.295 1.106.531 1.485 1.593 1.485 2.81 0 1.47-.726 2.384-1.828 2.754.955.32 2.134 1.09 2.134 2.933 0 2.254-1.616 3.41-4.042 3.41H0V5h7.26V9.068zm-3.99 2.396V13.5h2.437c.658 0 1.084-.438 1.084-1.023 0-.615-.393-.94-1.043-.95H3.27v-.063zm0 4.34v2.392h2.65c.662 0 1.112-.468 1.112-1.199 0-.713-.474-1.193-1.166-1.193H3.27z"/></svg>Behance</a>'

$instagramBtn = '<a class="footer-social-btn" href="https://www.instagram.com/vizia.digital/" target="_blank" rel="noopener"><svg fill="currentColor" height="14" viewBox="0 0 24 24" width="14"><path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zM12 0C8.741 0 8.333.014 7.053.072 2.695.272.273 2.69.073 7.052.014 8.333 0 8.741 0 12c0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98C8.333 23.986 8.741 24 12 24c3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98C15.668.014 15.259 0 12 0zm0 5.838a6.162 6.162 0 1 0 0 12.324 6.162 6.162 0 0 0 0-12.324zM12 16a4 4 0 1 1 0-8 4 4 0 0 1 0 8zm6.406-11.845a1.44 1.44 0 1 0 0 2.881 1.44 1.44 0 0 0 0-2.881z"/></svg>Instagram</a>'

$newBtns = $behanceBtn + $instagramBtn

$files = Get-ChildItem -Path 'C:\Users\kooro\Downloads\viziadigital.github.io-main' -Filter '*.html' -Recurse |
  Where-Object { $_.FullName -notmatch '\\ua\\' }

foreach ($f in $files) {
  $t = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
  # Insert after WhatsApp button, before closing </div> of footer-social-links
  $newT = $t -replace '(WhatsApp</a>\s*</div>)', ('WhatsApp</a>' + $newBtns + '</div>')
  if ($newT -ne $t) {
    [System.IO.File]::WriteAllText($f.FullName, $newT, [System.Text.Encoding]::UTF8)
    Write-Host "updated: $($f.Name)"
  }
}
Write-Host "done"
