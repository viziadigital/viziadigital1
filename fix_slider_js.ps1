$file = 'C:\Users\kooro\Downloads\viziadigital.github.io-main\studio.html'
$t = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

# Remove old slider JS (the compact inline script we added before)
$t = [regex]::Replace($t, '<script>\(function\(\)\{var track=document\.querySelector\("\.studio-team-track"\).*?\}\)\(\);</script>', '', [System.Text.RegularExpressions.RegexOptions]::Singleline)

# Add new correct slider JS before smooth-scroll
$newJs = '<script>
(function() {
  var viewport = document.querySelector(".studio-team-viewport");
  var track = document.querySelector(".studio-team-track");
  var prev = document.querySelector(".stm-prev");
  var next = document.querySelector(".stm-next");
  if (!track || !viewport) return;
  var cards = Array.from(track.querySelectorAll(".stm-card"));
  var total = cards.length;
  var current = 0;
  var gap = 16;

  function visibleCount() {
    return window.innerWidth <= 600 ? 2 : window.innerWidth <= 900 ? 3 : 4;
  }
  function maxIndex() { return Math.max(0, total - visibleCount()); }

  function setCardWidths() {
    var v = visibleCount();
    var w = (viewport.offsetWidth - gap * (v - 1)) / v;
    cards.forEach(function(c) { c.style.width = w + "px"; });
  }

  function update() {
    var w = cards[0].offsetWidth;
    track.style.transform = "translateX(-" + (current * (w + gap)) + "px)";
    prev.disabled = current === 0;
    next.disabled = current >= maxIndex();
  }

  prev.addEventListener("click", function() { if (current > 0) { current--; update(); } });
  next.addEventListener("click", function() { if (current < maxIndex()) { current++; update(); } });

  function init() {
    if (current > maxIndex()) current = maxIndex();
    setCardWidths();
    update();
  }

  init();
  window.addEventListener("resize", init);
})();
</script>'

$t = $t -replace '(<script src="/scripts/smooth-scroll\.js")', ($newJs + '$1')

[System.IO.File]::WriteAllText($file, $t, [System.Text.Encoding]::UTF8)
Write-Host "done"
