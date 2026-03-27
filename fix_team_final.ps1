$file = 'C:\Users\kooro\Downloads\viziadigital.github.io-main\studio.html'
$t = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

$phoneIcon = '<svg fill="none" height="15" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" width="15"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07A19.5 19.5 0 0 1 4.69 12 19.79 19.79 0 0 1 1.61 3.41 2 2 0 0 1 3.6 1.24h3a2 2 0 0 1 2 1.72c.127.96.361 1.903.7 2.81a2 2 0 0 1-.45 2.11L7.91 8.77a16 16 0 0 0 6.29 6.29l.95-.95a2 2 0 0 1 2.11-.45c.907.339 1.85.573 2.81.7A2 2 0 0 1 22 16.92z"></path></svg>'
$tgIcon = '<svg fill="currentColor" height="15" viewBox="0 0 24 24" width="15"><path d="M12 0C5.373 0 0 5.373 0 12s5.373 12 12 12 12-5.373 12-12S18.627 0 12 0zm5.894 8.221-1.97 9.28c-.145.658-.537.818-1.084.508l-3-2.21-1.447 1.394c-.16.16-.295.295-.605.295l.213-3.053 5.56-5.023c.242-.213-.054-.333-.373-.12L7.14 13.63l-2.95-.924c-.64-.203-.657-.64.136-.954l11.57-4.461c.537-.194 1.006.131.998.93z"/></svg>'

$newTeamSection = '<section class="studio-team"><div class="studio-team-header"><h2 class="section-heading">Meet the team</h2><span class="studio-team-count">7 members</span></div><div class="studio-team-slider"><button class="stm-nav-btn stm-prev" aria-label="Previous">&#8592;</button><div class="studio-team-viewport"><div class="studio-team-track">' +

  '<div class="stm-card stm-card--founder"><div class="stm-photo-wrap"><img class="stm-photo" src="/assets/images/team-kyrylo.png"><div class="stm-hover-contacts"><a href="tel:+380681939241">' + $phoneIcon + '+38 (068) 193-9241</a><a href="https://t.me/kyrylokm">' + $tgIcon + 'Telegram</a></div></div><p class="stm-name">Kyrylo Klymenko</p><p class="stm-role">CEO / Director</p></div>' +

  '<div class="stm-card stm-card--founder"><div class="stm-photo-wrap"><img class="stm-photo stm-photo--bw" src="/assets/images/team-victoria.png"><div class="stm-hover-contacts"><a href="tel:+380969210887">' + $phoneIcon + '+380 96 921 08 87</a><a href="https://t.me/svinobijv">' + $tgIcon + 'Telegram</a></div></div><p class="stm-name">Victoria Svynobij</p><p class="stm-role">Producer</p></div>' +

  '<div class="stm-card"><div class="stm-photo-wrap"><img class="stm-photo" src="/assets/images/team-mikhail.png"></div><p class="stm-name">Mikhail T&#246;ssa</p><p class="stm-role">3D Artist</p></div>' +

  '<div class="stm-card"><div class="stm-photo-wrap"><img class="stm-photo" src="/assets/images/team-artem.png"></div><p class="stm-name">Artem Bashinskiy</p><p class="stm-role">3D Artist</p></div>' +

  '<div class="stm-card"><div class="stm-photo-wrap"><img class="stm-photo" src="/assets/images/team-vladislav.png"></div><p class="stm-name">Vladislav Bespalko</p><p class="stm-role">Motion Designer</p></div>' +

  '<div class="stm-card stm-card--empty"><div class="stm-photo-wrap stm-photo-wrap--empty"><span>+</span></div><p class="stm-name">Coming soon</p><p class="stm-role">&mdash;</p></div>' +

  '<div class="stm-card stm-card--empty"><div class="stm-photo-wrap stm-photo-wrap--empty"><span>+</span></div><p class="stm-name">Coming soon</p><p class="stm-role">&mdash;</p></div>' +

'</div></div></div></section>'

# Replace entire studio-team section
$t = [regex]::Replace($t, '<section class="studio-team">.*?</section>(?=<section>)', $newTeamSection, [System.Text.RegularExpressions.RegexOptions]::Singleline)

[System.IO.File]::WriteAllText($file, $t, [System.Text.Encoding]::UTF8)
Write-Host "done"
