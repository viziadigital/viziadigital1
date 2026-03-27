$file = 'C:\Users\kooro\Downloads\viziadigital.github.io-main\studio.html'
$t = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

# Rename studio-team-grid div to studio-team-track and wrap it in slider+viewport
$t = $t -replace '<div class="studio-team-grid">', '<div class="studio-team-slider"><button class="stm-nav-btn stm-prev" aria-label="Previous">&#8592;</button><div class="studio-team-viewport"><div class="studio-team-track">'

# Close the two extra wrappers: after the last card's </div> before </section>
# Use regex to find the closing of the track div + section
$t = [regex]::Replace($t, '(<div class="studio-team-track">.*?)(</div>)(</section>)(?=<section>)', '$1$2</div></div>$3', [System.Text.RegularExpressions.RegexOptions]::Singleline)

# Add slider JS before smooth-scroll script tag
$sliderJs = '<script>(function(){var track=document.querySelector(".studio-team-track");var prev=document.querySelector(".stm-prev");var next=document.querySelector(".stm-next");if(!track)return;var cards=Array.from(track.querySelectorAll(".stm-card"));var total=cards.length;var current=0;function visibleCount(){return window.innerWidth<=600?2:window.innerWidth<=900?3:4;}function maxIndex(){return Math.max(0,total-visibleCount());}function update(){var gap=16;var cardWidth=cards[0].offsetWidth;track.style.transform="translateX(-"+(current*(cardWidth+gap))+"px)";prev.disabled=current===0;next.disabled=current>=maxIndex();}prev.addEventListener("click",function(){if(current>0){current--;update();}});next.addEventListener("click",function(){if(current<maxIndex()){current++;update();}});update();window.addEventListener("resize",function(){if(current>maxIndex())current=maxIndex();update();});})();</script>'

$t = $t -replace '(<script src="/scripts/smooth-scroll\.js")', ($sliderJs + '$1')

[System.IO.File]::WriteAllText($file, $t, [System.Text.Encoding]::UTF8)
Write-Host "done"
