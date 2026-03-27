$f = 'C:\Users\kooro\Downloads\viziadigital.github.io-main\studio.html'
$t = [System.IO.File]::ReadAllText($f, [System.Text.Encoding]::UTF8)

$phoneIcon = '<svg fill="none" height="16" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" width="16"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07A19.5 19.5 0 0 1 4.69 12 19.79 19.79 0 0 1 1.61 3.41 2 2 0 0 1 3.6 1.24h3a2 2 0 0 1 2 1.72c.127.96.361 1.903.7 2.81a2 2 0 0 1-.45 2.11L7.91 8.77a16 16 0 0 0 6.29 6.29l.95-.95a2 2 0 0 1 2.11-.45c.907.339 1.85.573 2.81.7A2 2 0 0 1 22 16.92z"></path></svg>'
$tgIcon = '<svg fill="currentColor" height="16" viewBox="0 0 24 24" width="16"><path d="M12 0C5.373 0 0 5.373 0 12s5.373 12 12 12 12-5.373 12-12S18.627 0 12 0zm5.894 8.221-1.97 9.28c-.145.658-.537.818-1.084.508l-3-2.21-1.447 1.394c-.16.16-.295.295-.605.295l.213-3.053 5.56-5.023c.242-.213-.054-.333-.373-.12L7.14 13.63l-2.95-.924c-.64-.203-.657-.64.136-.954l11.57-4.461c.537-.194 1.006.131.998.93z"/></svg>'

# Build the complete new team section (all 5 in one grid)
$newTeamSection = '<section class="studio-team"><h2 class="section-heading">Meet the team</h2>' +
'<div class="studio-founders">' +

  # Kyrylo - founder
  '<div class="studio-founder-card">' +
    '<div class="studio-founder-photo-wrap"><img class="studio-team-member-photo" src="/assets/images/team-kyrylo.png"><span class="studio-founder-badge">Founder</span></div>' +
    '<div class="studio-founder-info">' +
      '<p class="studio-team-member-name">Kyrylo Klymenko</p>' +
      '<p class="studio-founder-role">Director</p>' +
      '<ul class="contacts-contact-list studio-founder-contacts">' +
        '<li><a href="tel:+380681939241">' + $phoneIcon + '+38 (068) 193-9241</a></li>' +
        '<li><a href="https://t.me/kyrylokm">' + $tgIcon + 'Telegram</a></li>' +
      '</ul>' +
    '</div>' +
  '</div>' +

  # Victoria - founder
  '<div class="studio-founder-card">' +
    '<div class="studio-founder-photo-wrap"><img class="studio-team-member-photo studio-team-member-photo--bw" src="/assets/images/team-victoria.png"><span class="studio-founder-badge">Founder</span></div>' +
    '<div class="studio-founder-info">' +
      '<p class="studio-team-member-name">Victoria Svynobij</p>' +
      '<p class="studio-founder-role">Producer</p>' +
      '<ul class="contacts-contact-list studio-founder-contacts">' +
        '<li><a href="tel:+380969210887">' + $phoneIcon + '+380 96 921 08 87</a></li>' +
        '<li><a href="https://t.me/svinobijv">' + $tgIcon + 'Telegram</a></li>' +
      '</ul>' +
    '</div>' +
  '</div>' +

  # Mikhail - team
  '<div class="studio-team-member"><img class="studio-team-member-photo" src="/assets/images/team-mikhail.png"><p class="studio-team-member-name">Mikhail T' + [char]0xF6 + 'ssa</p><p class="studio-team-member-role">3D Artist</p></div>' +

  # Artem - team
  '<div class="studio-team-member"><img class="studio-team-member-photo" src="/assets/images/team-artem.png"><p class="studio-team-member-name">Artem Bashinskiy</p><p class="studio-team-member-role">3D Artist</p></div>' +

  # Vladislav - team
  '<div class="studio-team-member"><img class="studio-team-member-photo" src="/assets/images/team-vladislav.png"><p class="studio-team-member-name">Vladislav Bespalko</p><p class="studio-team-member-role">Motion Designer</p></div>' +

'</div></section>'

# Find and replace the entire studio-team section
$pattern = '<section class="studio-team">.*?</section>'
$newText = [regex]::Replace($t, $pattern, $newTeamSection, [System.Text.RegularExpressions.RegexOptions]::Singleline)

if ($newText -ne $t) {
    [System.IO.File]::WriteAllText($f, $newText, [System.Text.Encoding]::UTF8)
    Write-Host 'team section replaced'
} else {
    Write-Host 'no match found'
}
