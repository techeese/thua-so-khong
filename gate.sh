#!/bin/bash
# gate.sh — release gates for Thừa Số Không. exit 0 = safe to ship.
set -u
cd "$(dirname "$0")"
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
FAIL=0
pass(){ printf '✅ %s\n' "$*"; }
fail(){ printf '❌ %s\n' "$*"; FAIL=1; }

# Gate 0: the thesis band — diagnosis beats spreading beats idling
node check.js >/tmp/tsk-check.out 2>&1 && pass "band: $(tail -1 /tmp/tsk-check.out)" || fail "band: $(cat /tmp/tsk-check.out | tail -3)"

# Gate 1: every script block parses
node -e '
const fs=require("fs");const html=fs.readFileSync("index.html","utf8");
const blocks=[...html.matchAll(/<script>([\s\S]*?)<\/script>/g)];
for(const b of blocks) new Function(b[1]);
console.log(blocks.length);
' >/dev/null 2>/tmp/tsk-syn.err && pass "syntax: all script blocks parse" || fail "syntax: $(head -3 /tmp/tsk-syn.err)"

# Gate 2: fresh headless run — talk, act, link, 4 seasons, no JS errors
TMP=$(mktemp -d)
python3 - "$TMP" <<'PYEOF'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r'''
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  selectPerson(0); actNerve();                    // the opening is two people now
  selectPerson(2);
  S.nudged=true; nextSeason(); nextSeason();      // Chú Ba walks in at season 2
  selectPerson(1); actLink(); completeLink(0);    // the apprenticeship beat
  nextSeason(); nextSeason();
  // deterministic wiring only — stats are year-variant-jittered and entropy-decayed by design, so don't assert values
  var ok = S.season===4 && S.apprentice===true && S.cast[0].known && S.cast[1].known && S.un.link===true;
  document.title=(ok?"GATE_OK":"GATE_BAD")+" s="+S.season+" appr="+S.apprentice+" nganTai="+S.cast[0].tai+" link="+S.un.link;
}catch(e){ document.title="THREW: "+e.message; } },600);
</script>'''
open(tmp+"/g.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=6000 --dump-dom "file://$TMP/g.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "GATE_OK" && pass "fresh: $T" || fail "fresh: $T"

# Gate 3: a poisoned save is sanitized, not fatal
python3 - "$TMP" <<'PYEOF'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
seed='<script>localStorage.setItem("thua-so-khong-v1",\'{"v":1,"meta":{"lang":"vi"},"s":{"season":5,"acts":null,"luat":"x","von":99,"cast":[{"tai":null,"gan":50,"ban":-3}],"ships":[{"x":null}],"pairs":"bad"}}\');</script>'
drv=r'''
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ if(document.title.indexOf("JSERR")!==0)
  document.title="NAN_OK s="+S.season+" acts="+S.acts+" tai0="+S.cast[0].tai; },800);
</script>'''
open(tmp+"/n.html","w").write(html.replace("<body>","<body>"+seed,1).replace("</body>",drv+"</body>"))
PYEOF
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=5000 --dump-dom "file://$TMP/n.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "NAN_OK" && pass "nan-safe: $T" || fail "nan-safe: $T"

# Gate 5: full 16-season playthrough, VI and EN — zero JS errors, game ends, chronicle written
for LANG5 in vi en; do
python3 - "$TMP" "$LANG5" <<'PYEOF5'
import sys
tmp=sys.argv[1]; lang=sys.argv[2]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1"); localStorage.removeItem("thua-so-khong-chronicle");
  if("__LANG__"==="en") setLang("en");
  document.getElementById("startBtn").click();
  // a plausible player: meet people, tend the runt, link, hụi, build, season on
  for(var seas=0; seas<16; seas++){
    for(var i=0;i<7;i++){ if(S.cast[i]&&!S.cast[i].known&&(S.cast[i].arrives===undefined||S.season>=S.cast[i].arrives)&&!S.cast[i].gone) selectPerson(i); }
    var un=S.cast.filter(function(p){return p.known&&!p.started&&!p.gone;});
    un.sort(function(a,b){return Math.min(a.tai,a.gan,a.ban)-Math.min(b.tai,b.gan,b.ban);});
    if(un.length){ var tgt=un[0]; selectPerson(tgt.id);
      var mk=Math.min(tgt.tai,tgt.gan,tgt.ban);
      if(mk===tgt.gan) actNerve(); else if(mk===tgt.tai) actTeach(); else if(S.un.link&&un.length>1){ actLink(); completeLink(un[1].id); } else actTeach(); }
    if(S.un.hui&&S.acts>0&&S.hui<3) actHui();
    if(S.un.build&&!S.built&&S.acts>0) actBuild();
    if(S.acts>0&&un.length){ selectPerson(un[0].id); actNerve(); }
    S.nudged=true; nextSeason();
    if(S.over) break;
  }
  // the finale runs on timers (lantern beats then endGame) — assert after they finish
  setTimeout(function(){ try{
    var chron=[]; try{ chron=JSON.parse(localStorage.getItem("thua-so-khong-chronicle")||"[]"); }catch(e){}
    var ovl=document.getElementById("endOvl");
    var ok=S.over===true && ovl && ovl.className.indexOf("show")>=0 && chron.length===1 && document.getElementById("endTtl").textContent.length>1;
    document.title=(ok?"FULL_OK":"FULL_BAD")+" lang=__LANG__ over="+S.over+" chron="+chron.length+" ttl="+document.getElementById("endTtl").textContent;
  }catch(e2){ document.title="THREW2: "+e2.message; } },9000);
}catch(e){ document.title="THREW: "+e.message; } },700);
</script>"""
open(tmp+"/f.html","w").write(html.replace("</body>",drv.replace("__LANG__",lang)+"</body>"))
PYEOF5
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=20000 --dump-dom "file://$TMP/f.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "FULL_OK" && pass "full-run($LANG5): $T" || fail "full-run($LANG5): $T"
done

# Gate 6: the xóm has a voice — a PACED run must actually produce ambient bubbles.
# Two ways this layer dies silently: the roll lands inside the season banner's beat (it did, for
# every version up to v0.27 — 15/15 calls preempted, 0 bubbles), or chatter() stops being reached.
# Paced because a tight sync loop fires every season's timer at one virtual instant; and the render
# loop is driven by hand because headless virtual time starves rAF (~10 frames in 112s), which
# leaves stale bubbles on screen and trips chatter's own bubbles>=2 guard. Both are artifacts.
python3 - "$TMP" <<'PYEOF6'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r'''
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
var CALLS=0,PRE=0,AMB=0;
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1"); localStorage.removeItem("thua-so-khong-chronicle");
  document.getElementById("startBtn").click();
  setInterval(function(){ try{ drawScene(performance.now()); }catch(e){} },100);
  var _c=window.chatter;
  window.chatter=function(){ CALLS++; if(performance.now()<beatUntil) PRE++;
    var n0=bubbles.length; try{ return _c.apply(this,arguments); } finally{ AMB+=Math.max(0,bubbles.length-n0); } };
  (function step(i){
    if(S.over||i>=16){ document.title=(PRE===0&&AMB>=1?"AMB_OK":"AMB_BAD")+" calls="+CALLS+" preempted="+PRE+" bubbles="+AMB; return; }
    for(var k=0;k<7;k++){ var c=S.cast[k]; if(c&&!c.known&&(c.arrives===undefined||S.season>=c.arrives)&&!c.gone) selectPerson(k); }
    var un=S.cast.filter(function(p){return p.known&&!p.started&&!p.gone;});
    if(un.length){ selectPerson(un[0].id); actNerve(); }
    S.nudged=true; nextSeason();
    setTimeout(function(){ step(i+1); },7000);
  })(0);
}catch(e){ document.title="THREW: "+e.message; } },600);
</script>'''
open(tmp+"/a.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF6
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=140000 --dump-dom "file://$TMP/a.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "AMB_OK" && pass "ambient voice: $T" || fail "ambient voice: $T"

# Gate 7: the zero bites — a factor at 1 reads 0% on the sheet and in the per-verb hints, and cannot bloom until it is raised.
python3 - "$TMP" <<'PYEOF7'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  var ng=S.cast[0]; ng.tai=9; ng.gan=1; ng.ban=9; S.von=10; ng.seen={tai:true,gan:true,ban:true};   // v0.33: the row must be learned before the sheet reads it   // nine times zero times nine — teach and link both have room, both still read 0%
  selectPerson(0);
  var c0=chance(ng), sheet0=document.getElementById("multLine").textContent, hint0=document.getElementById("teachHint").textContent, hintN=document.getElementById("nerveHint").textContent;
  var blooms=0; for(var i=0;i<400;i++){ if(Math.random()<chance(ng)) blooms++; }
  actNerve(); var c1=chance(ng);
  var ok = c0===0 && blooms===0 && /0%/.test(sheet0) && /→ 0%/.test(hint0) && !/→ 0%/.test(hintN) && c1>0;
  document.title=(ok?"ZERO_OK":"ZERO_BAD")+" c0="+c0+" rolls="+blooms+" sheet0="+(/0%/.test(sheet0))+" teachHint="+hint0.slice(-6)+" nerveHint="+hintN.slice(-6)+" c1="+c1.toFixed(2);
}catch(e){ document.title="THREW: "+e.message; } },600);
</script>"""
open(tmp+"/z.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF7
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=5000 --dump-dom "file://$TMP/z.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "ZERO_OK" && pass "zero bites: $T" || fail "zero bites: $T"

# Gate 8: capital is a factor — the same person sprouts ~2.7× likelier on a full river than a thin one, and a
# 640-product workshop is a stall on a river ≤3, a shop on ≤6, a brand only when the water is high.
python3 - "$TMP" <<'PYEOF8'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  var p=S.cast[2]; p.tai=8; p.gan=8; p.ban=8; p.mom=0;
  S.von=1; var c1=chance(p); S.von=10; var c10=chance(p);
  var sh={pid:2}; p.tai=10; p.gan=8; p.ban=8;   // product 640 — a brand by product alone
  S.von=2; var t2=shipTier(sh); S.von=5; var t5=shipTier(sh); S.von=9; var t9=shipTier(sh);
  var ratio=c10/c1;
  var ok = ratio>2.5 && ratio<2.9 && t2===1 && t5===2 && t9===3;
  document.title=(ok?"RIVER_OK":"RIVER_BAD")+" c1="+c1.toFixed(3)+" c10="+c10.toFixed(3)+" ratio="+ratio.toFixed(2)+" tiers@2/5/9="+t2+"/"+t5+"/"+t9;
}catch(e){ document.title="THREW: "+e.message; } },600);
</script>"""
open(tmp+"/r.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF8
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=5000 --dump-dom "file://$TMP/r.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "RIVER_OK" && pass "capital is a factor: $T" || fail "capital is a factor: $T"

# Gate 9: the print fits a phone — nothing outside the roster may cross a 390px edge, and no two
# speech bubbles may print over each other however many neighbours talk at once.
# (Headless Chrome floors --window-size at ~500px, so 390 is forced with an injected body width — see LANDMINES.)
python3 - "$TMP" <<'PYEOF9'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<style>body{width:390px;margin:0 auto}</style>
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
var _rects=[],_origDB=null;
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  for(var s=0;s<6;s++){ try{ S.acts=3; nextSeason(); }catch(e){} }
  S.cast.forEach(function(p){ p.known=true; });
  _origDB=drawBubble;
  drawBubble=function(x,y,lay,taken){ _origDB(x,y,lay,taken); if(taken) _rects=taken.slice(); };
  var spk=S.cast.filter(function(p){return !p.gone;}).slice(0,4);   // four neighbours talking at once, all crowded together
  spk.forEach(function(p,i){ p.x=300+i*46; p.drawX=300+i*46; p.y=390; bubble(p,"Bộ sách của tôi — học trò cũ quay lại mua hết rồi."); });
  S.banner={txt:"Hạ 2027",until:performance.now()+30000};
  try{ selectPerson(1); }catch(e){}
  setTimeout(function(){
    var over=0,i,j;
    for(i=0;i<_rects.length;i++) for(j=i+1;j<_rects.length;j++){ var a=_rects[i],b=_rects[j];
      if(a.x<b.x+b.w&&a.x+a.w>b.x&&a.y<b.y+b.h&&a.y+a.h>b.y) over++; }
    var bd=document.body, Lf=bd.getBoundingClientRect().left, R=Lf+390, ov=0;
    var all=document.querySelectorAll("body *");
    for(var k=0;k<all.length;k++){ var rr=all[k].getBoundingClientRect();
      if(rr.width>0&&!all[k].closest(".roster")&&(rr.right>R+1||rr.left<Lf-1)) ov++; }
    var bfs=Math.round(32*LKF);
    var ok = bd.scrollWidth<=390 && ov===0 && over===0 && _rects.length>=2 && bfs>32;
    document.title=(ok?"PHONE_OK":"PHONE_BAD")+" bodySW="+bd.scrollWidth+" hOver="+ov+" printed="+_rects.length+" overlaps="+over+" bannerPx="+bfs;
  },900);
}catch(e){ document.title="THREW: "+e.message; } },500);
</script>"""
open(tmp+"/p.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF9
T=$("$CHROME" --headless --disable-gpu --no-sandbox --window-size=600,900 --virtual-time-budget=9000 --dump-dom "file://$TMP/p.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "PHONE_OK" && pass "the print fits a phone: $T" || fail "the print fits a phone: $T"

# Gate 10: the pot — hốt hụi pays one member from the river: river −1, that sprout +0.06 momentum, once a season, never past a zero.
python3 - "$TMP" <<'PYEOF9'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  S.un.hui=true; S.hui=1; S.von=5; S.acts=3; S.constraint=0; S.yearCard=2;
  selectPerson(0); var okZero=!potOk(S.cast[0]);                 // Bé Ngân's GAN is 1 — nothing pushes past a zero
  selectPerson(2); var mai=S.cast[2]; mai.tai=6; mai.gan=4; mai.ban=7; mai.mom=0; mai.seen={tai:true,gan:true,ban:true}; renderSheet();   // v0.33: the pot needs a known row
  var shown=document.getElementById("potBtn").style.display!=="none", hint0=document.getElementById("potHint").textContent;
  var acts0=S.acts; actPot();
  var a1=(S.von===4&&Math.abs(mai.mom-0.06)<1e-9&&S.acts===acts0-1&&S.potSeason===true&&!potOk(mai));
  actPot(); var a2=(S.von===4&&Math.abs(mai.mom-0.06)<1e-9);   // a second take this season does nothing
  S.nudged=true; nextSeason(); var a3=(S.potSeason===false);
  var ok=okZero&&shown&&/→ \d+%/.test(hint0)&&a1&&a2&&a3;
  document.title=(ok?"POT_OK":"POT_BAD")+" zeroBlocked="+okZero+" shown="+shown+" hint="+hint0.slice(-6)+" take="+a1+" twice="+a2+" reset="+a3+" von="+S.von+" mom="+mai.mom;
}catch(e){ document.title="THREW: "+e.message; } },600);
</script>"""
open(tmp+"/p.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF9
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=6000 --dump-dom "file://$TMP/p.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "POT_OK" && pass "the pot: $T" || fail "the pot: $T"

# Gate 11: the factors are hidden until touched — a fresh talk shows "? × ? × ?" and no per-verb answer; one hand on GAN
# reveals GAN alone; the row's answers appear only once all three are known; a bloom shows everything.
python3 - "$TMP" <<'PYEOF11'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  selectPerson(0); var ng=S.cast[0];
  var v0=[document.getElementById("valTai").textContent,document.getElementById("valGan").textContent,document.getElementById("valBan").textContent].join("");
  var m0=document.getElementById("multLine").textContent, h0=document.getElementById("nerveHint").textContent;
  var lbl0=(zeroOf(ng)===null);                            // GAN 1 sits unnamed until touched
  S.acts=3; actNerve();
  var v1=[document.getElementById("valTai").textContent,document.getElementById("valGan").textContent,document.getElementById("valBan").textContent];
  var h1=document.getElementById("nerveHint").textContent;
  actTeach(); selectPerson(2); S.un.link=true; selectPerson(0); actLink(); completeLink(2);   // touch the other two
  var all=seenAll(ng), h2=document.getElementById("nerveHint").textContent;
  var ok = v0==="???" && /\? × \? × \?/.test(m0) && h0.indexOf("→")<0 && lbl0
        && v1[0]==="?" && v1[1]===String(ng.gan) && v1[2]==="?" && h1.indexOf("→")<0
        && all && /→ \d+%/.test(h2);
  document.title=(ok?"HIDDEN_OK":"HIDDEN_BAD")+" v0="+v0+" mult0="+/\? × \? × \?/.test(m0)+" hint0="+(h0.indexOf("→")<0)+" unnamed="+lbl0+" afterNerve="+v1.join("/")+" all="+all+" hint2="+h2.slice(-6);
}catch(e){ document.title="THREW: "+e.message; } },600);
</script>"""
open(tmp+"/h.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF11
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=6000 --dump-dom "file://$TMP/h.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "HIDDEN_OK" && pass "hidden until touched: $T" || fail "hidden until touched: $T"

# Gate 12: a hand in the wrong place gets an answer — teach Bé Ngân (her strongest factor, while GAN sits at 1) and she says so in her
# own voice ~0.9s later; a second teach says nothing more; nerve (the zero) draws no such line.
python3 - "$TMP" <<'PYEOF12'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
function wrongCount(){ return bubbles.filter(function(b){ return b.p===S.cast[0] && b.lay.lines.join(" ").indexOf(STR.wrongTai[L].slice(1,12))>=0; }).length; }
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  var ng=S.cast[0]; ng.tai=8; ng.gan=1; ng.ban=4;
  selectPerson(0); S.acts=3;
  actTeach(); var w0=wrongCount();                       // nothing yet — the answer follows the float
  setTimeout(function(){ var w1=wrongCount();
    actTeach(); setTimeout(function(){ var w2=wrongCount();
      actNerve(); setTimeout(function(){ var w3=wrongCount(), nerveWrong=bubbles.some(function(b){ return b.p===S.cast[0] && b.lay.lines.join(" ").indexOf(STR.wrongGan[L].slice(1,10))>=0; });
        var ok = w0===0 && w1===1 && w2===1 && w3===1 && !nerveWrong;
        document.title=(ok?"VOICE_OK":"VOICE_BAD")+" beforeDelay="+w0+" afterTeach="+w1+" secondTeach="+w2+" afterNerve="+w3+" nerveWrong="+nerveWrong;
      },1200); },1200); },1200);
}catch(e){ document.title="THREW: "+e.message; } },600);
</script>"""
open(tmp+"/v.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF12
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=8000 --dump-dom "file://$TMP/v.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "VOICE_OK" && pass "the wrong place answers: $T" || fail "the wrong place answers: $T"

# Gate 13: the names stay readable — six villagers jammed into 150px of the far bank must produce no
# label printed over another villager's label, and no label crossing the printed frame.
# Overlap is measured on the TRUE ink box (actualBoundingBox*), not an estimate: a coarser box counts
# each villager's own name/hint pair as a collision and the number stops meaning anything.
python3 - "$TMP" <<'PYEOF12'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
var _lbl=[],_pid=-1;
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  for(var s=0;s<7;s++){ try{ S.acts=3; nextSeason(); }catch(e){} }
  var _oh=haloText;
  haloText=function(txt,x,y){ var m=ctx.measureText(txt);
    _lbl.push({x:x-m.width/2,y:y-m.actualBoundingBoxAscent,w:m.width,
               h:m.actualBoundingBoxAscent+m.actualBoundingBoxDescent,pid:_pid}); return _oh(txt,x,y); };
  var _op=person;
  person=function(p,now){ _pid=p.id; try{ return _op(p,now); } finally{ _pid=-1; } };
  var crowd=S.cast.filter(function(p){return !p.gone;});
  crowd.forEach(function(p,i){ p.known=true; p.started=false; p.amb=0; p.beh=1;
    p.tai=2; p.gan=1; p.ban=8; p.x=760+i*30; p.hx=p.x; p.drawX=p.x; p.y=430; p.hy=430; });
  bubbles=[]; S.banner=null; S.sel=crowd[0].id;
  setTimeout(function(){
    _lbl.length=0; drawScene(performance.now());
    var cross=0,bleed=0,i,j;
    for(i=0;i<_lbl.length;i++){ var l=_lbl[i]; if(l.x<9||l.x+l.w>W-9) bleed++;
      for(j=i+1;j<_lbl.length;j++){ var a=_lbl[i],b=_lbl[j];
        if(a.pid===b.pid&&a.pid>=0) continue;   // a villager's own name over their own hint is the design's line spacing
        if(a.x<b.x+b.w&&a.x+a.w>b.x&&a.y<b.y+b.h&&a.y+a.h>b.y) cross++; } }
    var ok = cross===0 && bleed===0 && _lbl.length>=4;
    document.title=(ok?"LABEL_OK":"LABEL_BAD")+" labels="+_lbl.length+" cross="+cross+" bleed="+bleed;
  },800);
}catch(e){ document.title="THREW: "+e.message; } },500);
</script>"""
open(tmp+"/l.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF12
T=$("$CHROME" --headless --disable-gpu --no-sandbox --window-size=600,900 --virtual-time-budget=9000 --dump-dom "file://$TMP/l.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "LABEL_OK" && pass "the names stay readable: $T" || fail "the names stay readable: $T"

# Gate 17: the girl's clock — Bé Ngân with NERVE under 3 at season 11 walks to the road and is gone; with NERVE ≥3 she stays.
python3 - "$TMP" <<'PYEOF13'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  S.nudged=true; S.season=10; var ng=S.cast[0]; ng.known=true; ng.gan=1; ng.started=false;
  S.cast.forEach(function(q){ if(q!==ng){ q.known=false; q.started=true; } });   // she is a witness: any other bloom this tick lifts her GAN by 1, two carry her to 3 — so nobody else may bloom (a real flake, seen twice)
  nextSeason(); var leaving=!!ng.leaving, s11=S.season;
  setTimeout(function(){ var gone1=!!ng.gone;
    // control: a fresh xóm where she dared
    fresh(); S.nudged=true; S.season=10; var ng2=S.cast[0]; ng2.known=true; ng2.gan=5; ng2.started=false; S.cast.forEach(function(q){ if(q!==ng2){ q.known=false; q.started=true; } }); nextSeason();
    setTimeout(function(){ var ok=leaving&&s11===11&&gone1&&!ng2.gone&&!ng2.leaving;
      document.title=(ok?"CLOCK_OK":"CLOCK_BAD")+" leaving="+leaving+" s="+s11+" gone="+gone1+" daredStays="+(!ng2.gone&&!ng2.leaving);
    },5200); },5200);
}catch(e){ document.title="THREW: "+e.message; } },600);
</script>"""
open(tmp+"/c.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF13
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=14000 --dump-dom "file://$TMP/c.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "CLOCK_OK" && pass "the girl's clock: $T" || fail "the girl's clock: $T"

# Gate 14: the TÀI zero walks — a low-TÀI neighbour (Anh Tú at 2) picks the LEARN errand often and it carries him to the most
# skilled pair of hands; a high-TÀI neighbour (Bé Ngân at 8) never picks it.
python3 - "$TMP" <<'PYEOF14'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  S.season=5; var tu=S.cast[5], ng=S.cast[0]; tu.known=true; tu.tai=2; tu.started=false; ng.tai=8;
  var n=3000, c11=0, c11ng=0;
  for(var i=0;i<n;i++){ if(pickBeh(tu)===11) c11++; if(pickBeh(ng)===11) c11ng++; }
  var ms=learnMaster(tu); execBeh(tu,11,performance.now());
  var msh=null; S.ships.forEach(function(sh){ if(sh.pid===ms.id) msh=sh; });
  var ex=(msh?msh.x:ms.hx)+(tu.hx<ms.hx?-34:34), near=Math.abs(tu.tx-ex)<40;
  var ok = c11/n>0.2 && c11ng===0 && tu.beh===11 && !!ms && ms.tai>=6 && near;
  document.title=(ok?"LEARN_OK":"LEARN_BAD")+" tuShare="+(c11/n).toFixed(2)+" nganShare="+(c11ng/n).toFixed(2)+" master="+(ms?ms.name:"none")+" beh="+tu.beh+" near="+near;
}catch(e){ document.title="THREW: "+e.message; } },600);
</script>"""
open(tmp+"/l.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF14
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=5000 --dump-dom "file://$TMP/l.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "LEARN_OK" && pass "the TÀI zero walks: $T" || fail "the TÀI zero walks: $T"

# Gate 16: the strip says it scrolls — the roster is wider than a phone, and a chip cut off by the box
# edge reads as a cut-off chip, not as "there is more of the xóm this way". The chips at a live edge
# fade into the paper; each edge shows ONLY while there is more that way. Asserted as the three states
# a player can be in, because the cue is a mask driven by real scroll position.
python3 - "$TMP" <<'PYEOF16'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<style>body{width:390px;margin:0 auto}</style>
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  for(var s=0;s<8;s++){ try{ S.acts=3; nextSeason(); }catch(e){} }
  S.cast.forEach(function(p){ p.known=true; });
  render();
  var r=document.getElementById("roster"), more=r.scrollWidth-r.clientWidth;
  function st(sl){ r.scrollLeft=sl; rosterEdges();
    return (r.classList.contains("mL")?"L":"-")+(r.classList.contains("mR")?"R":"-"); }
  var a=st(0), b=st(Math.round(more/2)), c=st(r.scrollWidth);
  var ok = more>40 && a==="-R" && b==="LR" && c==="L-";
  document.title=(ok?"STRIP_OK":"STRIP_BAD")+" more="+more+" atStart="+a+" mid="+b+" atEnd="+c;
}catch(e){ document.title="THREW: "+e.message; } },700);
</script>"""
open(tmp+"/s.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF16
T=$("$CHROME" --headless --disable-gpu --no-sandbox --window-size=600,900 --virtual-time-budget=9000 --dump-dom "file://$TMP/s.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "STRIP_OK" && pass "the strip says it scrolls: $T" || fail "the strip says it scrolls: $T"

# Gate 15: strangers walk — with nobody yet spoken to, the errand governor still sends someone on the road (the road precedes the label).
python3 - "$TMP" <<'PYEOF15'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  S.season=4; S.sel=-1; S.luat=6; S.cast.forEach(function(p){ p.known=false; p.behForce=0; p.arriveT=0; p.vUntil=0; p.amb=0; });
  beatUntil=0; nextErrandAt=0;
  var t0=performance.now(), sent=0, unknownSent=0;
  for(var i=0;i<40;i++){ nextErrandAt=0; beatUntil=0; errandTick(t0+i*20000);
    S.cast.forEach(function(p){ if(p.amb&&!p._c){ p._c=1; sent++; if(!p.known) unknownSent++; } }); }
  var ok = sent>=3 && unknownSent===sent;
  document.title=(ok?"STRANGER_OK":"STRANGER_BAD")+" sent="+sent+" unknownSent="+unknownSent;
}catch(e){ document.title="THREW: "+e.message; } },600);
</script>"""
open(tmp+"/s.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF15
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=5000 --dump-dom "file://$TMP/s.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "STRANGER_OK" && pass "strangers walk: $T" || fail "strangers walk: $T"

# Gate 18: the ceiling — the weakest factor caps a life: 10×2×10 at a full river sprouts ≤4 %/season, 10×3×10 ≤8 %, and the sheet says which factor caps it.
python3 - "$TMP" <<'PYEOF16'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  var p=S.cast[2]; p.seen={tai:true,gan:true,ban:true}; p.mom=0; S.von=10;
  p.tai=10; p.gan=2; p.ban=10; var c2=chance(p);
  p.gan=3; var c3=chance(p);
  p.gan=8; var c8=chance(p);
  p.gan=3; selectPerson(2); renderSheet(); var ml=document.getElementById("multLine").textContent, says=/GAN 3 (chặn ở|caps it at) 8%/.test(ml);
  var ok = Math.abs(c2-0.04)<1e-9 && Math.abs(c3-0.08)<1e-9 && c8>0.5 && says;
  document.title=(ok?"CEIL_OK":"CEIL_BAD")+" c2="+c2+" c3="+c3+" c8="+c8.toFixed(2)+" says="+says;
}catch(e){ document.title="THREW: "+e.message; } },600);
</script>"""
open(tmp+"/e.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF16
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=5000 --dump-dom "file://$TMP/e.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "CEIL_OK" && pass "the ceiling: $T" || fail "the ceiling: $T"

# Gate 19: the intro yields — while the intro card is up, the xóm must not ALSO point at a villager.
# The card says "hãy chạm vào một người và trò chuyện" in words and sits over the pulsing ring that
# says it in pictures. The ring must be gone before Begin and back after it (charter 4: beats own the
# screen, everything else yields — and a hint you cannot see is not a hint).
python3 - "$TMP" <<'PYEOF19'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
var HINT=0,_of=null;
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  _of=ctx.fillText.bind(ctx);
  ctx.fillText=function(t,x,y){ if(/chạm để trò chuyện|tap to talk/.test(String(t))) HINT++; return _of(t,x,y); };
  var intro=document.getElementById("intro");
  var openBefore=intro.classList.contains("show");
  HINT=0; drawScene(performance.now()); var during=HINT;
  document.getElementById("startBtn").click();
  HINT=0; drawScene(performance.now()); var after=HINT;
  var ringBack = after>0 && !S.cast.some(function(p){return p.known;});
  var ok = openBefore===true && during===0 && ringBack;
  document.title=(ok?"INTRO_OK":"INTRO_BAD")+" cardUp="+openBefore+" hintWhileCardUp="+during+" hintAfterBegin="+after;
}catch(e){ document.title="THREW: "+e.message; } },700);
</script>"""
open(tmp+"/i.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF19
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=6000 --dump-dom "file://$TMP/i.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "INTRO_OK" && pass "the intro yields: $T" || fail "the intro yields: $T"

# Gate 20: the pot respects the ceiling — a row a 3 already caps refuses the pot and says which factor caps it; a row with room takes it;
# and the hụi button prints what one coin does to the river's multiplier.
python3 - "$TMP" <<'PYEOF17'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  S.un.hui=true; S.hui=1; S.von=5; S.acts=3; S.constraint=0; S.yearCard=2; S.potSeason=false;
  var mai=S.cast[2]; mai.seen={tai:true,gan:true,ban:true}; mai.mom=0; mai.started=false; mai.known=true;
  mai.tai=10; mai.gan=3; mai.ban=10; selectPerson(2); renderSheet();
  var refused=!potOk(mai), why=document.getElementById("potHint").textContent, saysCap=/GAN 3 (chặn|caps)/.test(why);
  var von0=S.von; actPot(); var untouched=(S.von===von0&&(mai.mom||0)===0);
  mai.tai=6; mai.gan=5; mai.ban=7; renderSheet(); var okRoom=potOk(mai);
  var hc=document.getElementById("huiCost").textContent, showsMul=/×0\.65→0\.72/.test(hc);
  var ok=refused&&saysCap&&untouched&&okRoom&&showsMul;
  document.title=(ok?"POTCEIL_OK":"POTCEIL_BAD")+" refused="+refused+" saysCap="+saysCap+" untouched="+untouched+" roomOk="+okRoom+" huiCost="+hc;
}catch(e){ document.title="THREW: "+e.message; } },600);
</script>"""
open(tmp+"/pc.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF17
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=5000 --dump-dom "file://$TMP/pc.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "POTCEIL_OK" && pass "the pot respects the ceiling: $T" || fail "the pot respects the ceiling: $T"

# Gate 21: the world is honest about the ceiling and lifts BẠN — a sprout the ceiling binds gains no momentum over a season while one with
# room does; and once you have paid into the hụi, the circle raises the loneliest known neighbour's BẠN by 1 (never past 3), and not before.
python3 - "$TMP" <<'PYEOF21'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  S.nudged=true; S.season=3; S.von=10; S.luat=6; S.luatNext=6; S.hui=0; S.constraint=0;
  var mai=S.cast[2], vu=S.cast[3], ba=S.cast[1]; [mai,vu,ba].forEach(function(q){ q.known=true; q.started=false; q.arriveT=0; q.mom=0; });
  mai.tai=10; mai.gan=3; mai.ban=10;      // capped at 8 % — no room for momentum
  vu.tai=6; vu.gan=5; vu.ban=7;           // min 5: ceiling 25 %, base ~19 % — room
  ba.ban=2; ba.tai=9; ba.gan=3;           // the loneliest
  var trials=0, maiMom=0, vuMom=0, baBan0=ba.ban;
  // roll many season ticks on frozen copies of the same state to average the dice: momentum only accrues on a failed roll
  S.cast.forEach(function(q){ if(q!==mai&&q!==vu&&q!==ba){ q.known=false; q.started=true; } });   // nobody else blooms or witnesses — the rows must stay pinned across trials
  for(var i=0;i<12;i++){ mai.tai=10; mai.gan=3; mai.ban=10; vu.tai=6; vu.gan=5; vu.ban=7; mai.mom=0; vu.mom=0; mai.started=false; vu.started=false; ba.started=false; S.hui=0; nextSeason(); if(S.over) break; trials++; maiMom+=mai.mom||0; vuMom+=vu.mom||0; S.season=3; }
  var noLiftWithoutHui=(ba.ban===baBan0);
  // isolate the subject: the circle lifts THE loneliest, so anyone else still sitting at ban<=2 can
  // take the lift instead and the assertion flakes (observed lifted=false on identical code). The
  // twelve trials above drift the rest of the cast, so put every other neighbour out of the running.
  S.cast.forEach(function(q){ if(q!==ba&&q.ban<=2) q.ban=4; });
  // and pin the subject's own dice: at 9×3×2 on a river of 10, chance(ba) is the ceiling 4 %/season, and a bloom
  // in the lift season sets started=true BEFORE the circle looks — the lift filter is !started, so lifted read
  // false on identical code about one run in 25. Only ba's roll is pinned; every other roll in the season is live.
  var C0=chance; chance=function(q){ return q===ba?0:C0(q); };
  S.hui=1; ba.ban=2; ba.started=false; ba.known=true; nextSeason(); var lifted=(ba.ban===3&&ba.seen.ban===true);
  ba.ban=3; nextSeason(); var notPast3=(ba.ban===3); chance=C0;
  var ok = trials>=6 && maiMom===0 && vuMom>0 && noLiftWithoutHui && lifted && notPast3;
  document.title=(ok?"WORLD_OK":"WORLD_BAD")+" trials="+trials+" maiMom="+maiMom.toFixed(2)+" vuMom="+vuMom.toFixed(2)+" noLiftWithoutHui="+noLiftWithoutHui+" lifted="+lifted+" notPast3="+notPast3;
}catch(e){ document.title="THREW: "+e.message; } },600);
</script>"""
open(tmp+"/w.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF21
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=9000 --dump-dom "file://$TMP/w.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "WORLD_OK" && pass "the world is honest about the ceiling: $T" || fail "the world is honest about the ceiling: $T"

# Gate 22: the ending card owns the screen — the finale's lantern beats keep their voices, but once the
# card is actually up nothing prints behind it. 107 speech bubbles were still painting under it when
# this was measured. Asserted non-vacuously: bubbles pushed while the card is up are cleared, and the
# same push with the card hidden survives — so the guard is conditional, not a blanket mute.
python3 - "$TMP" <<'PYEOF22'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1"); localStorage.removeItem("thua-so-khong-chronicle");
  document.getElementById("startBtn").click();
  for(var seas=0; seas<16; seas++){
    for(var i=0;i<7;i++){ if(S.cast[i]&&!S.cast[i].known&&(S.cast[i].arrives===undefined||S.season>=S.cast[i].arrives)&&!S.cast[i].gone) selectPerson(i); }
    var un=S.cast.filter(function(p){return p.known&&!p.started&&!p.gone;});
    if(un.length){ selectPerson(un[0].id); actNerve(); }
    S.nudged=true; nextSeason(); if(S.over) break;
  }
  setTimeout(function(){ try{
    var ov=document.getElementById("endOvl"), shown=ov&&ov.classList.contains("show");
    var atCard=bubbles.length;                                   // what the finale left behind
    var who=S.cast[0];
    bubbles=[]; bubble(who,"một hai ba"); bubble(who,"bốn năm sáu"); var pushed=bubbles.length;
    drawScene(performance.now()); var afterWithCard=bubbles.length;
    ov.classList.remove("show");                                 // same push, card down
    bubbles=[]; bubble(who,"một hai ba"); drawScene(performance.now()); var afterNoCard=bubbles.length;
    ov.classList.add("show");
    var ok = shown===true && pushed>=2 && afterWithCard===0 && afterNoCard>=1;
    document.title=(ok?"ENDQUIET_OK":"ENDQUIET_BAD")+" cardUp="+shown+" leftByFinale="+atCard
      +" pushed="+pushed+" afterWithCard="+afterWithCard+" afterCardDown="+afterNoCard;
  }catch(e2){ document.title="THREW2: "+e2.message; } },9500);
}catch(e){ document.title="THREW: "+e.message; } },600);
</script>"""
open(tmp+"/e.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF22
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=24000 --dump-dom "file://$TMP/e.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "ENDQUIET_OK" && pass "the ending card owns the screen: $T" || fail "the ending card owns the screen: $T"

# Gate 23: the law's number is printed — under a heavy sky a young roof's sheet says ⬛ 15% this season, an established one 5%, a tarped one 🛡 0%;
# under a clear sky nothing; and the shelter button says how many roofs one hand covers.
python3 - "$TMP" <<'PYEOF23'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  S.season=6; S.acts=3; S.un.probe=true; S.probeSeen=false;
  var mai=S.cast[2], vu=S.cast[3]; mai.known=true; vu.known=true; mai.started=true; vu.started=true;
  S.ships.push({x:420,y:300,owner:mai.name,pid:2,age:1,shel:0}); S.ships.push({x:300,y:420,owner:vu.name,pid:3,age:5,shel:0});
  S.luat=6; selectPerson(2); var clear=document.getElementById("multLine").textContent, noneClear=!/⬛|🛡/.test(clear);
  S.luat=2; render(); selectPerson(2); var young=document.getElementById("multLine").textContent, y15=/⬛ 15%/.test(young);
  selectPerson(3); var old=document.getElementById("multLine").textContent, o5=/⬛ 5%/.test(old);
  // the button prints the LIVE count of covered roofs (actShel tarps every one), and this harness
  // pushes two ships — so "1 roof" was a stale magic number. Assert the stated intent instead:
  // the number on the button equals the number one hand would actually cover.
  var cost0=document.getElementById("shelCost").textContent;
  var realN=S.ships.filter(shelCovers).length;
  var printedN=parseInt((cost0.match(/·\s*(\d+)/)||[0,-1])[1],10);
  var covers1=(realN>=1 && printedN===realN);
  actShel(); selectPerson(2); var tarped=document.getElementById("multLine").textContent, t0=/🛡 0%/.test(tarped);
  selectPerson(3); var tarpedOld=document.getElementById("multLine").textContent, t0old=/🛡 0%/.test(tarpedOld);   // v0.48: the established roof is tarped by the same hand
  var ok=noneClear&&y15&&o5&&covers1&&t0&&t0old&&realN===2;
  document.title=(ok?"LAW_OK":"LAW_BAD")+" clear="+noneClear+" young15="+y15+" old5="+o5+" shelCost="+cost0+" printed="+printedN+" real="+realN+" tarped0="+t0+" oldTarped0="+t0old;
}catch(e){ document.title="THREW: "+e.message; } },600);
</script>"""
open(tmp+"/law.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF23
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=5000 --dump-dom "file://$TMP/law.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "LAW_OK" && pass "the law's number is printed: $T" || fail "the law's number is printed: $T"

# Gate 24: the Sổ tay keeps its way out — the card was one long scroller, so the heading and the
# Đóng button scrolled away with the text: 1025px of card in an 813px window left the only exit at
# y=1009, off-screen, and the undiscoverable margin-tap as the only visible way out. The body scrolls,
# the title and the button stay, and the body's live edge fades so it says it has more.
python3 - "$TMP" <<'PYEOF24'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  for(var s=0;s<9;s++){ try{ S.acts=3; S.nudged=true; nextSeason(); }catch(e){} }
  helpToggle(true);
  setTimeout(function(){
    var b=document.getElementById("helpBody"), cl=document.getElementById("helpClose"), h2=document.getElementById("helpTtl");
    function inView(e){ var r=e.getBoundingClientRect(); return r.top>=0 && r.bottom<=innerHeight+1 && r.height>0; }
    function at(t){ b.scrollTop=t; helpEdges(); return (b.classList.contains("mT")?"T":"-")+(b.classList.contains("mB")?"B":"-"); }
    var more=b.scrollHeight-b.clientHeight;
    var top=at(0),        vT=inView(cl)&&inView(h2);
    var mid=at(Math.round(more/2)), vM=inView(cl)&&inView(h2);
    var end=at(b.scrollHeight),     vE=inView(cl)&&inView(h2);
    at(0);
    // the log is the third strip on the same helper (roster · Sổ tay · log): 24 lines kept, about four
    // shown, and it taps open to a page — cursor:pointer was its only hint, which a thumb cannot see.
    var lg=document.getElementById("log");
    function lat(t){ lg.scrollTop=t; logEdges(); return (lg.classList.contains("mT")?"T":"-")+(lg.classList.contains("mB")?"B":"-"); }
    var lmore=lg.scrollHeight-lg.clientHeight;
    var lTop=lat(0), lMid=lat(Math.round(lmore/2)), lEnd=lat(lg.scrollHeight); lat(0);
    var logOk = lmore>40 && lTop==="-B" && lMid==="TB" && lEnd==="T-";
    var ok = more>80 && top==="-B" && mid==="TB" && end==="T-" && vT && vM && vE && logOk;
    document.title=(ok?"SOTAY_OK":"SOTAY_BAD")+" more="+more+" top="+top+" mid="+mid+" end="+end
      +" exitAlwaysVisible="+(vT&&vM&&vE)+" || log more="+lmore+" "+lTop+"/"+lMid+"/"+lEnd;
  },600);
}catch(e){ document.title="THREW: "+e.message; } },700);
</script>"""
open(tmp+"/h.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF24
T=$("$CHROME" --headless --disable-gpu --no-sandbox --window-size=1000,900 --virtual-time-budget=9000 --dump-dom "file://$TMP/h.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "SOTAY_OK" && pass "the Sổ tay keeps its way out: $T" || fail "the Sổ tay keeps its way out: $T"

# Gate 25: elbow room — two villagers standing on the same spot must not print on the same spot.
# Gated as the MECHANISM, not as a play-through statistic: a seeded whole-run metric was tried and
# abandoned here (see LANDMINES) because the game's deferred beats run on wall-clock setTimeout and
# the number moved with machine load — 0.1016 then 0.1589 on identical seeds, and worse when the timer
# queue was forced onto the harness clock. This asserts the separation directly, and asserts that it
# is draw-time only: p.x must be untouched, so the sim, the errands and the thesis band never see it.
python3 - "$TMP" <<'PYEOF25'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  var a=S.cast[0], b=S.cast[1], c=S.cast[2];
  [a,b,c].forEach(function(p){ p.known=true; p.gone=false; p.arrives=undefined; p.amb=0; p.vUntil=0; });
  // three of them on one square of paper, standing still
  a.x=a.tx=a.hx=500; a.y=a.ty=a.hy=400;
  b.x=b.tx=b.hx=500; b.y=b.ty=b.hy=400;
  c.x=c.tx=c.hx=500; c.y=c.ty=c.hy=400;
  var simX=[a.x,b.x,c.x];
  // pin the wander: without this p.x drifts because they simply walk, and simUntouched would be
  // measuring ordinary wandering rather than whether the separation writes to the simulation.
  for(var i=0;i<60;i++){ [a,b,c].forEach(function(p){ p.tx=p.x; p.ty=p.y; p.vUntil=0; }); drawScene(1000+i*16); }
  var dx=[a.drawX,b.drawX,c.drawX];
  function gap(i,j){ return Math.abs(dx[i]-dx[j]); }
  var minGap=Math.min(gap(0,1),gap(0,2),gap(1,2));
  var simUntouched=(a.x===simX[0]&&b.x===simX[1]&&c.x===simX[2]);
  var onPaper=dx.every(function(v){ return v>=30 && v<=W-30; });
  var ok = minGap>=26 && simUntouched && onPaper;
  document.title=(ok?"ELBOW_OK":"ELBOW_BAD")+" minGap="+minGap.toFixed(1)+" simUntouched="+simUntouched
    +" onPaper="+onPaper+" drawX="+dx.map(function(v){return Math.round(v);}).join(",");
}catch(e){ document.title="THREW: "+e.message; } },600);
</script>"""
open(tmp+"/el.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF25
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=7000 --dump-dom "file://$TMP/el.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "ELBOW_OK" && pass "elbow room: $T" || fail "elbow room: $T"

# Gate 26: the hand that crosses a threshold says so — a bloomed 7×5×8=280 shows "→ 350 ↑bậc 2" on the hand that lifts the product past 300 at a
# river that can carry a shop, plain "→ 350" when the river holds it at a stall, and no arrow on a hand that stays under 300.
python3 - "$TMP" <<'PYEOF24'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  var mai=S.cast[2]; mai.known=true; mai.started=true; mai.seen={tai:true,gan:true,ban:true}; mai.tai=7; mai.gan=5; mai.ban=8;   // 280
  S.ships.push({x:420,y:300,owner:mai.name,pid:2,age:2}); S.von=5; S.acts=3; selectPerson(2); renderSheet();
  var t1=document.getElementById("teachHint").textContent, n1=document.getElementById("nerveHint").textContent;   // teach → 9×5×8=360 ↑tier 2 · nerve → 7×7×8=392 ↑tier 2
  S.von=2; renderSheet(); var t2=document.getElementById("teachHint").textContent;                                  // river ≤3 holds a stall: no arrow
  mai.tai=4; mai.gan=5; mai.ban=8; S.von=5; renderSheet(); var t3=document.getElementById("teachHint").textContent;  // 160 → 240: under 300, no arrow
  var ok=/→ 360 ↑(bậc|tier) 2/.test(t1)&&/→ 392 ↑(bậc|tier) 2/.test(n1)&&/→ 360$/.test(t2)&&/→ 240$/.test(t3);
  document.title=(ok?"RUNG_OK":"RUNG_BAD")+" teach="+t1.slice(-16)+" nerve="+n1.slice(-16)+" held="+t2.slice(-8)+" under="+t3.slice(-8);
}catch(e){ document.title="THREW: "+e.message; } },600);
</script>"""
open(tmp+"/rung.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF24
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=5000 --dump-dom "file://$TMP/rung.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "RUNG_OK" && pass "the hand that crosses a threshold says so: $T" || fail "the hand that crosses a threshold says so: $T"

# Gate 27: the middle hand misses too — Chú Ba at 9×3×2: a failure night (GAN 3, not his weakest) draws his answer; a link (BẠN 2, the zero) draws none.
python3 - "$TMP" <<'PYEOF27'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
function said(p,str){ return bubbles.some(function(b){ return b.p===p && b.lay.lines.join(" ").indexOf(str.slice(1,10))>=0; }); }
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  S.season=3; var ba=S.cast[1], mai=S.cast[2]; ba.known=true; mai.known=true; ba.tai=9; ba.gan=3; ba.ban=2; ba.started=false; ba.seen={tai:false,gan:false,ban:false};
  S.acts=3; selectPerson(1); actNerve();
  setTimeout(function(){ var midAnswered=said(ba,STR.wrongGan[L]);
    ba.seen={tai:false,gan:false,ban:false}; S.un.link=true; S.acts=3; selectPerson(1); actLink(); completeLink(2);
    setTimeout(function(){ var zeroAnswered=said(ba,STR.wrongBan[L]);
      var ok=midAnswered&&!zeroAnswered;
      document.title=(ok?"MIDDLE_OK":"MIDDLE_BAD")+" middleAnswered="+midAnswered+" zeroAnswered="+zeroAnswered;
    },1200); },1200);
}catch(e){ document.title="THREW: "+e.message; } },600);
</script>"""
open(tmp+"/mid.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF27
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=6000 --dump-dom "file://$TMP/mid.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "MIDDLE_OK" && pass "the middle hand misses too: $T" || fail "the middle hand misses too: $T"

# Gate 28: the pot's price is printed — at river 4 with a 400-product shop standing, the pot hint says the multiplier drops ×0.58→0.51 and
# ↓tier for 1 roof; at river 5 the same hint carries the multiplier delta and no tier warning.
python3 - "$TMP" <<'PYEOF28'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  S.un.hui=true; S.hui=1; S.acts=3; S.constraint=0; S.yearCard=2; S.potSeason=false;
  var mai=S.cast[2], vu=S.cast[3]; vu.known=true; vu.started=true; vu.tai=8; vu.gan=5; vu.ban=10;   // 400 — a shop if the river carries it
  S.ships.push({x:300,y:420,owner:vu.name,pid:3,age:3});
  mai.known=true; mai.started=false; mai.seen={tai:true,gan:true,ban:true}; mai.mom=0; mai.tai=6; mai.gan=5; mai.ban=7;
  S.von=4; selectPerson(2); renderSheet(); var h4=document.getElementById("potHint").textContent;
  S.von=5; renderSheet(); var h5=document.getElementById("potHint").textContent;
  var ok=/×0\.58→0\.51/.test(h4)&&/↓(bậc|tier) 1/.test(h4)&&/×0\.65→0\.58/.test(h5)&&!/↓/.test(h5);
  document.title=(ok?"PRICE_OK":"PRICE_BAD")+" at4="+h4+" | at5="+h5;
}catch(e){ document.title="THREW: "+e.message; } },600);
</script>"""
open(tmp+"/price.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF28
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=5000 --dump-dom "file://$TMP/price.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "PRICE_OK" && pass "the pot's price is printed: $T" || fail "the pot's price is printed: $T"

# Gate 29: speech has its own lane — with three stat floats on screen and no beat, chatter() still produces a speech bubble; with two SPEECH
# bubbles up it still refuses (the two-slot rule stands, it just counts speech). Randomness pinned for the probe only.
python3 - "$TMP" <<'PYEOF29'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  S.season=3; S.luat=6; S.cast.forEach(function(p){ p.known=true; }); gossipQ.length=0; S.pairs=[]; beatUntil=0;
  var R=Math.random; Math.random=function(){ return 0.9; };   // skips the 40% no-show, skips gossip/pairs, lands on a chat line
  bubbles.length=0; floatOn(S.cast[0],"+1 GAN"); floatOn(S.cast[1],"+1 GAN"); floatOn(S.cast[2],"+1 GAN");
  var s0=speechCount(); chatter(); var s1=speechCount();                    // floats up → speech still lands
  bubble(S.cast[3],"a"); bubble(S.cast[4],"b"); var s2=speechCount(); chatter(); var s3=speechCount();   // two speech up → refused
  Math.random=R;
  var ok = s0===0 && s1===1 && s2===3 && s3===3 && bubbles.length===6;
  document.title=(ok?"LANE_OK":"LANE_BAD")+" floatsUpThenSpeech="+s0+"→"+s1+" twoSpeechRefused="+s2+"→"+s3+" total="+bubbles.length;
}catch(e){ document.title="THREW: "+e.message; } },600);
</script>"""
open(tmp+"/lane.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF29
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=5000 --dump-dom "file://$TMP/lane.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "LANE_OK" && pass "speech has its own lane: $T" || fail "speech has its own lane: $T"

# Gate 30: an unread factor does not look like a zero — the sheet drew an unseen factor as width:0,
# an EMPTY track, which is emptier than a factor genuinely sitting at 1. In a game about which factor
# is at zero, that is the one thing a bar must not say wrongly. Unread hatches the whole track; reading
# it at its true value of 1 removes the hatch and shows a real width. Both halves asserted.
python3 - "$TMP" <<'PYEOF30'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  var p=S.cast[1]; p.known=true; p.started=false;
  p.seen={tai:true,gan:true,ban:false}; p.tai=9; p.gan=10; p.ban=1;
  selectPerson(1);
  setTimeout(function(){
    function trk(id){ return document.getElementById(id).parentNode; }
    function hatched(id){ return getComputedStyle(trk(id)).backgroundImage.indexOf("gradient")>=0; }
    var unreadHatched=hatched("barBan"), readPlain=!hatched("barTai");
    var wUnread=document.getElementById("barBan").style.width, vUnread=document.getElementById("valBan").textContent;
    see(p,"ban"); renderSheet();
    var afterHatched=hatched("barBan"), wAfter=document.getElementById("barBan").style.width,
        vAfter=document.getElementById("valBan").textContent;
    var ok = unreadHatched && readPlain && !afterHatched && wAfter==="10%" && vAfter==="1" && vUnread==="?";
    document.title=(ok?"UNREAD_OK":"UNREAD_BAD")+" unreadHatched="+unreadHatched+" readPlain="+readPlain
      +" unread(w="+wUnread+",v="+vUnread+") afterReveal(hatched="+afterHatched+",w="+wAfter+",v="+vAfter+")";
  },350);
}catch(e){ document.title="THREW: "+e.message; } },600);
</script>"""
open(tmp+"/ur.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF30
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=7000 --dump-dom "file://$TMP/ur.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "UNREAD_OK" && pass "an unread factor is not a zero: $T" || fail "an unread factor is not a zero: $T"

# Gate 31: the roster's dots say WHICH factor — the three dots record which factors your hands have
# touched, but they were drawn in one grey, so nothing said which dot was which and the only
# explanation was a title tooltip a thumb cannot reach. They now carry the sheet's own factor colours
# (TÀI indigo · GAN đỏ son · BẠN leaf), filled for touched and hollow for not, with a lighter key on
# the selected chip's ink ground. Asserted against the sheet's bars, so the two can never drift apart.
python3 - "$TMP" <<'PYEOF31'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  for(var s=0;s<4;s++){ S.acts=3; S.nudged=true; nextSeason(); }
  S.cast.forEach(function(p){ p.known=true; p.started=false; });
  S.cast[0].seen={tai:true,gan:false,ban:true};
  selectPerson(2); renderRoster();
  setTimeout(function(){ try{
    var chip=document.querySelector('.rc[data-id="0"]'), sel=document.querySelector('.rc.sel');
    if(!chip){ document.title="DOTS_BAD nochip"; return; }
    var ds=chip.querySelectorAll(".sd i"), selDs=sel?sel.querySelectorAll(".sd i"):[];
    function col(e){ return getComputedStyle(e).color; }
    function filled(e){ var b=getComputedStyle(e).backgroundColor; return b!=="rgba(0, 0, 0, 0)"&&b!=="transparent"; }
    // the dots must match the SHEET's bars for the same factors — one vocabulary, not two
    var barCol=["barTai","barGan","barBan"].map(function(id){ return getComputedStyle(document.getElementById(id)).backgroundColor; });
    var dotCol=[col(ds[0]),col(ds[1]),col(ds[2])];
    var matchesSheet=dotCol.every(function(c,i){ return c===barCol[i]; });
    var distinct=new Set(dotCol).size;
    var ok = ds.length===3 && distinct===3 && matchesSheet
             && filled(ds[0]) && !filled(ds[1]) && filled(ds[2])
             && (!selDs.length || col(selDs[0])!==dotCol[0]);
    document.title=(ok?"DOTS_OK":"DOTS_BAD")+" n="+ds.length+" distinct="+distinct
      +" matchesSheetBars="+matchesSheet+" filled="+[filled(ds[0]),filled(ds[1]),filled(ds[2])].join(",")
      +" selKeyDiffers="+(selDs.length?(col(selDs[0])!==dotCol[0]):"n/a");
  }catch(e2){ document.title="THREW2: "+e2.message; } },300);
}catch(e){ document.title="THREW: "+e.message; } },600);
</script>"""
open(tmp+"/dt.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF31
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=7000 --dump-dom "file://$TMP/dt.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "DOTS_OK" && pass "the roster's dots say which factor: $T" || fail "the roster's dots say which factor: $T"

# Gate 32: the partner's gain is on the chip — with Kết nối armed on Bé Ngân, Cô Mai's chip (no bonds) reads +2 BẠN and Anh Vũ's (one bond) reads +1 BẠN;
# disarmed, neither shows a gain.
python3 - "$TMP" <<'PYEOF30'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
function chip(id){ var c=document.querySelector('#roster .rc[data-id="'+id+'"]'); return c?c.textContent:""; }
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  S.season=2; S.cast[0].known=true; S.cast[2].known=true; S.cast[3].known=true; S.un.link=true; S.acts=3;
  S.pairs=[[3,4]];   // Anh Vũ already has one bond (with Chị Hoa)
  selectPerson(0); render(); var mai0=chip(2), vu0=chip(3), off=!/\+\d/.test(mai0)&&!/\+\d/.test(vu0);
  actLink(); render(); var mai1=chip(2), vu1=chip(3);
  var ok=off&&/\+2 (BẠN|ALLIES)/.test(mai1)&&/\+1 (BẠN|ALLIES)/.test(vu1)&&S.linking===0;
  document.title=(ok?"PARTNER_OK":"PARTNER_BAD")+" off="+off+" mai="+mai1+" vu="+vu1;
}catch(e){ document.title="THREW: "+e.message; } },600);
</script>"""
open(tmp+"/partner.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF30
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=5000 --dump-dom "file://$TMP/partner.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "PARTNER_OK" && pass "the partner's gain is on the chip: $T" || fail "the partner's gain is on the chip: $T"

# Gate 33: a ceiling is not an empty hand — a verb switched off because its factor already stands at 10
# looked EXACTLY like a verb switched off because you had no hands left (same opacity, same greyed
# hint), and it still promised "+2 TÀI" it could not deliver. Two different facts wore one face. The
# ceiling now names itself and keeps doing so when the hands run out, because it is the permanent one.
python3 - "$TMP" <<'PYEOF33'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  for(var s=0;s<5;s++){ S.acts=3; S.nudged=true; nextSeason(); }
  var p=S.cast[0]; p.known=true; p.started=false; p.seen={tai:true,gan:true,ban:true};
  p.tai=10; p.gan=5; p.ban=5;
  selectPerson(0);
  function st(id){ var e=document.getElementById(id), cs=getComputedStyle(e), h=e.querySelector("small");
    return {op:+(+cs.opacity).toFixed(2), maxed:e.classList.contains("maxed"), hint:h?h.textContent.trim():""}; }
  S.acts=3; render(); renderSheet();
  var cap=st("teachBtn"), live=st("nerveBtn");
  S.acts=0; render(); renderSheet();
  var capNo=st("teachBtn"), noHand=st("nerveBtn");
  setLang("en"); S.acts=3; render(); renderSheet();
  var capEn=st("teachBtn");
  var ok = cap.maxed && /10/.test(cap.hint) && !/\+2/.test(cap.hint)          // the ceiling names itself, promises nothing
        && !live.maxed && /\+2/.test(live.hint) && live.op>0.9                // a live verb still offers its delta
        && !noHand.maxed && /\+2/.test(noHand.hint)                           // an empty hand does not erase what the verb would do
        && cap.op!==noHand.op && capNo.maxed && capNo.op===cap.op             // and the ceiling outranks the empty hand
        && /maxed/.test(capEn.hint);                                          // bilingual, like every player-facing string
  document.title=(ok?"CEILV_OK":"CEILV_BAD")+" capped='"+cap.hint+"'@"+cap.op+" live='"+live.hint+"'@"+live.op
    +" noHands='"+noHand.hint+"'@"+noHand.op+" cappedNoHands@"+capNo.op+" en='"+capEn.hint+"'";
}catch(e){ document.title="THREW: "+e.message; } },700);
</script>"""
open(tmp+"/cv.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF33
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=8000 --dump-dom "file://$TMP/cv.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "CEILV_OK" && pass "a ceiling is not an empty hand: $T" || fail "a ceiling is not an empty hand: $T"

# Gate 34: every GAN move prints — an erased stall floats −3 GAN ⬛ on its owner (and reveals GAN), a stepped-down shop floats −2 GAN ⬛,
# and finishing your own roof floats +1 GAN 🛠 on everyone you have met.
python3 - "$TMP" <<'PYEOF33'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
function floats(p,str){ return bubbles.filter(function(b){ return b.p===p && b.lay.lines.join(" ").indexOf(str)>=0; }).length; }
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  S.nudged=true; S.season=6; S.luat=2; S.luatNext=2; S.acts=3;
  var mai=S.cast[2], vu=S.cast[3]; [mai,vu].forEach(function(q){ q.known=true; q.started=true; q.seen={tai:true,gan:true,ban:true}; });
  S.cast.forEach(function(q){ if(q!==mai&&q!==vu){ q.known=false; q.started=true; } });
  mai.tai=10; mai.gan=8; mai.ban=8;   // 640 → tier 2+ at a river ≥4: a step-down, not an erasure
  vu.tai=5; vu.gan=6; vu.ban=5;       // 150 → a stall: erased
  S.von=8; S.ships.push({x:420,y:300,owner:mai.name,pid:2,age:4,shel:0}); S.ships.push({x:300,y:420,owner:vu.name,pid:3,age:4,shel:0});
  var R=Math.random; Math.random=function(){ return 0.01; };   // the stamp falls on both (risk 5 %) and every other roll lands
  nextSeason(); Math.random=R;
  var down=floats(mai,"−2 GAN"), erased=floats(vu,"−3 GAN");
  // your roof: build four times with two known neighbours present
  S.un.build=true; S.build=3; S.built=false; S.acts=3; bubbles.length=0; mai.known=true; vu.known=true; actBuild();
  var lifted=floats(mai,"+1 GAN")+floats(vu,"+1 GAN");
  var ok=down===1&&erased===1&&lifted===2&&S.built;
  document.title=(ok?"GANMOVE_OK":"GANMOVE_BAD")+" stepDown="+down+" erased="+erased+" buildLift="+lifted+" built="+S.built;
}catch(e){ document.title="THREW: "+e.message; } },600);
</script>"""
open(tmp+"/gm.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF33
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=6000 --dump-dom "file://$TMP/gm.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "GANMOVE_OK" && pass "every GAN move prints: $T" || fail "every GAN move prints: $T"

# Gate 36: a partial row prints its bound — Bé Ngân after one failure night (GAN 3 seen, TÀI/BẠN unseen): the sheet says trần ≤ 8%, the nerve hand says
# trần ≤ 25% (GAN 5 would be the lowest seen), the teach hand (unseen factor) says nothing; still no "→ N%" anywhere until the row is known.
python3 - "$TMP" <<'PYEOF35'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  var ng=S.cast[0]; ng.tai=8; ng.gan=1; ng.ban=4; selectPerson(0); S.acts=3; actNerve();
  var ml=document.getElementById("multLine").textContent, nh=document.getElementById("nerveHint").textContent, th=document.getElementById("teachHint").textContent;
  var ok=/(trần|ceiling) ≤ 8%/.test(ml)&&/(trần|ceiling) ≤ 25%/.test(nh)&&!/(trần|ceiling)/.test(th)&&!/→ \d+%/.test(nh+th+ml);
  document.title=(ok?"BOUND_OK":"BOUND_BAD")+" sheet="+(/(trần|ceiling) ≤ 8%/.test(ml))+" nerve="+nh.slice(-14)+" teachSilent="+(!/(trần|ceiling)/.test(th))+" noPoint="+(!/→ \d+%/.test(nh+th+ml));
}catch(e){ document.title="THREW: "+e.message; } },600);
</script>"""
open(tmp+"/bound.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF35
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=5000 --dump-dom "file://$TMP/bound.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "BOUND_OK" && pass "a partial row prints its bound: $T" || fail "a partial row prints its bound: $T"

# Gate 35: you can tap what you can see — the machine half of the owner gate "390px hands · canvas tap
# targets all reachable". v0.45's elbow-room nudge moves a figure on the paper (drawX) without touching
# the simulation (p.x), and the hit test was still aimed at p.x: 13 CSS px adrift at 390, one tap in
# seven selecting the neighbour. This dispatches REAL click events on the canvas at each villager's
# DRAWN position and reads S.sel — an earlier draft reimplemented the hit test inside the probe and so
# passed on the broken build, which is worth remembering: a gate must exercise the shipped path.
python3 - "$TMP" <<'PYEOFTAP'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<style>html,body{width:390px;margin:0 auto}</style>
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  for(var s=0;s<7;s++){ S.acts=3; S.nudged=true; nextSeason(); }
  S.cast.forEach(function(p){ p.known=true; p.arriveT=0; });   // nobody mid arrival-slide
  var act=S.cast.filter(function(p){ return active(p)&&!p.gone; });
  // all on ONE spot: the nudge is at full stretch here, so drawX and p.x are furthest apart and a
  // hit test aimed at p.x cannot tell them apart at all — the sharpest form of the bug.
  act.slice(0,4).forEach(function(p){ p.x=p.tx=p.hx=500; p.y=p.ty=p.hy=420; p.amb=0; p.vUntil=0; });
  for(var f=0;f<60;f++){ act.forEach(function(p){ p.tx=p.x; p.ty=p.y; p.arriveT=0; }); drawScene(1000+f*16); }
  var cv2=document.getElementById("cv"), r=cv2.getBoundingClientRect();
  var kx=r.width/W, ky=r.height/H;
  var hitR=Math.max(34, 22*(W/r.width)), thumbCss=hitR*kx;
  S.linking=null;
  function tapLogical(lx,ly){
    var ev=new MouseEvent("click",{clientX:r.left+lx*kx, clientY:r.top+ly*ky, bubbles:true});
    cv2.dispatchEvent(ev);
  }
  var missed=0, detail=[];
  act.forEach(function(p){
    S.sel=-1; S.linking=null;
    var dx=(p.drawX!==undefined?p.drawX:p.x);
    tapLogical(dx, p.y);                       // tap the body you can actually see
    var got=S.sel;
    if(got!==p.id){ missed++; detail.push(p.id+"→"+got+"@off"+Math.abs(dx-p.x).toFixed(0)); }
  });
  var ok = thumbCss>=21.5 && missed===0 && act.length>=5;
  document.title=(ok?"TAP_OK":"TAP_BAD")+" thumbCss="+thumbCss.toFixed(1)+" villagers="+act.length
    +" tappedWhereDrawnMissed="+missed+(detail.length?(" :: "+detail.join(",")):"");
}catch(e){ document.title="THREW: "+e.message; } },700);
</script>"""
open(tmp+"/tp.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOFTAP
T=$("$CHROME" --headless --disable-gpu --no-sandbox --window-size=600,900 --virtual-time-budget=9000 --dump-dom "file://$TMP/tp.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "TAP_OK" && pass "you can tap what you can see: $T" || fail "you can tap what you can see: $T"

# Gate 37: the fate warnings do not tell — at season 9 Bé Ngân's medical-school line names GAN in the log only if her GAN has been touched;
# untouched, the log says she talks of medical school and nothing about the factor (her bubble is the clue either way).
python3 - "$TMP" <<'PYEOF37'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  function warnAt9(seen){ fresh(); S.nudged=true; S.season=8; var ng=S.cast[0]; ng.known=true; ng.gan=1; ng.started=false; ng.seen={tai:false,gan:seen,ban:false};
    S.cast.forEach(function(q){ if(q!==ng){ q.known=false; q.started=true; } }); S.nganWarned=false; nextSeason();
    var line=S.log.filter(function(m){ return /trường Y|medical school/.test(m.vi+m.en); })[0]; return line?(line.vi+" | "+line.en):"(none)"; }
  var unseen=warnAt9(false), seen=warnAt9(true);
  var ok = /trường Y\./.test(unseen) && !/GAN/.test(unseen) && /GAN/.test(seen) && /NERVE/.test(seen);
  document.title=(ok?"TELL_OK":"TELL_BAD")+" unseen="+unseen.slice(0,60)+" | seen="+seen.slice(0,80);
}catch(e){ document.title="THREW: "+e.message; } },600);
</script>"""
open(tmp+"/tell.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF37
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=6000 --dump-dom "file://$TMP/tell.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "TELL_OK" && pass "the fate warnings do not tell: $T" || fail "the fate warnings do not tell: $T"

# Gate 38: mechanic state survives a refresh — a guess-answer already given (wrongSaid) and the circle's first-time line (circleSeen) round-trip
# through save()/load(); a save without the fields (older schema) loads them as unset, not as garbage.
python3 - "$TMP" <<'PYEOF38'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  S.season=3; var ng=S.cast[0]; ng.known=true; ng.wrongSaid={tai:true,gan:false,ban:false}; S.circleSeen=true; save();
  var raw=JSON.parse(localStorage.getItem("thua-so-khong-v1")); var wsSaved=raw.s.cast[0].ws, csSaved=raw.s.cs;
  fresh(); var okLoad=load(); var ng2=S.cast[0];
  var round=okLoad&&ng2.wrongSaid&&ng2.wrongSaid.tai===true&&ng2.wrongSaid.gan===false&&S.circleSeen===true;
  // an older save shape: strip the fields and reload — unset, not garbage
  delete raw.s.cast[0].ws; delete raw.s.cs; localStorage.setItem("thua-so-khong-v1",JSON.stringify(raw)); fresh(); var okOld=load(); var ng3=S.cast[0];
  var oldOk=okOld&&ng3.wrongSaid&&ng3.wrongSaid.tai===false&&S.circleSeen===false;
  var ok=wsSaved===1&&csSaved===true&&round&&oldOk;
  document.title=(ok?"PERSIST_OK":"PERSIST_BAD")+" ws="+wsSaved+" cs="+csSaved+" roundtrip="+round+" oldSchema="+oldOk;
}catch(e){ document.title="THREW: "+e.message; } },600);
</script>"""
open(tmp+"/persist.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF38
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=5000 --dump-dom "file://$TMP/persist.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "PERSIST_OK" && pass "mechanic state survives a refresh: $T" || fail "mechanic state survives a refresh: $T"

# Gate 39: a card taller than the window still has a way out — the overlay did not scroll, so on a
# short viewport (a phone in landscape, a small laptop window) the ending card's own "Chơi lại" button
# sat off-screen with no way to reach it: measured UNREACHABLE at 533px and 433px tall. Asserted at
# three heights, and by scrolling the overlay rather than by trusting that it fits.
python3 - "$TMP" <<'PYEOFEND'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<style>html,body{width:390px;margin:0 auto}</style>
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1"); localStorage.removeItem("thua-so-khong-chronicle");
  document.getElementById("startBtn").click();
  for(var seas=0; seas<16; seas++){
    for(var i=0;i<7;i++){ var c=S.cast[i]; if(c&&!c.known&&(c.arrives===undefined||S.season>=c.arrives)&&!c.gone) selectPerson(i); }
    var un=S.cast.filter(function(p){return p.known&&!p.started&&!p.gone;});
    if(un.length){ selectPerson(un[0].id); actNerve(); }
    S.nudged=true; nextSeason(); if(S.over) break;
  }
  setTimeout(function(){ try{
    var ov=document.getElementById("endOvl"), card=ov.querySelector(".card");
    var again=[].slice.call(card.querySelectorAll("button")).filter(function(b){ return /Chơi lại|Play again/.test(b.textContent); })[0];
    if(!again){ document.title="ENDOUT_BAD noPlayAgainButton"; return; }
    function reachable(){ ov.scrollTop=ov.scrollHeight;
      var r=again.getBoundingClientRect(), ok=r.top>=0&&r.bottom<=innerHeight+1;
      ov.scrollTop=0; return ok; }
    var tall=card.getBoundingClientRect().height;
    var ok=reachable();
    document.title=(ok?"ENDOUT_OK":"ENDOUT_BAD")+" winH="+innerHeight+" cardH="+Math.round(tall)
      +" tallerThanWindow="+(tall>innerHeight)+" playAgainReachable="+ok;
  }catch(e2){ document.title="THREW2: "+e2.message; } },9500);
}catch(e){ document.title="THREW: "+e.message; } },600);
</script>"""
open(tmp+"/eo.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOFEND
ENDFAIL=0
for WH in 600,760 600,620 600,520; do
  T=$("$CHROME" --headless --disable-gpu --no-sandbox --window-size=$WH --virtual-time-budget=26000 --dump-dom "file://$TMP/eo.html" 2>/dev/null | grep -o "<title>[^<]*</title>" | head -1)
  echo "$T" | grep -q "ENDOUT_OK" || { ENDFAIL=1; ENDMSG="$WH → $T"; }
done
[ "$ENDFAIL" -eq 0 ] && pass "a card taller than the window still has a way out (390px @ 3 heights)" \
                     || fail "a card taller than the window still has a way out: $ENDMSG"

# Gate 40: the print fits a phone held sideways — the stylesheet caps the canvas at 70vh in landscape
# so the xóm and the hands both fit, but fit() wrote style.height INLINE and beat it, so the cap never
# took effect: a 303px-tall viewport got a 511px-tall canvas and you saw sky and roof-tops, with the
# river, the roster and every button below the fold. Asserts the cap holds in landscape AND that the
# print still fills its width in portrait, so honouring the cap cannot shrink the ordinary case.
python3 - "$TMP" <<'PYEOFLAND'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  for(var s=0;s<4;s++){ S.acts=3; S.nudged=true; nextSeason(); }
  var cv2=document.getElementById("cv"), r=cv2.getBoundingClientRect();
  var land=window.matchMedia("(orientation:landscape) and (max-height:520px)").matches;
  // the parent's clientWidth INCLUDES its padding; compare against the content box or this can never match
  var pp=getComputedStyle(cv2.parentElement);
  var avail=cv2.parentElement.clientWidth-parseFloat(pp.paddingLeft||0)-parseFloat(pp.paddingRight||0);
  var aspect=(r.width>0)?(r.width/r.height):0;
  var wantAspect=Math.abs(aspect-(W/H))<0.02;                 // never crop or stretch the block
  var capOk = land ? (r.height<=innerHeight*0.72 && r.height<=innerHeight) : true;
  var fillsOk = land ? true : (r.width>=avail-2);              // portrait/desktop still uses the full width
  var ok = wantAspect && capOk && fillsOk;
  document.title=(ok?"LAND_OK":"LAND_BAD")+" landscape="+land+" win="+innerWidth+"x"+innerHeight
    +" canvas="+Math.round(r.width)+"x"+Math.round(r.height)+" aspectOk="+wantAspect
    +" capOk="+capOk+" fillsWidthOk="+fillsOk;
}catch(e){ document.title="THREW: "+e.message; } },700);
</script>"""
open(tmp+"/ld.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOFLAND
LFAIL=0; LMSG=""
for WH in 844,390 740,360 600,900 1000,780; do
  T=$("$CHROME" --headless --disable-gpu --no-sandbox --window-size=$WH --virtual-time-budget=8000 --dump-dom "file://$TMP/ld.html" 2>/dev/null | grep -o "<title>[^<]*</title>" | head -1)
  echo "$T" | grep -q "LAND_OK" || { LFAIL=1; LMSG="$LMSG [$WH → $T]"; }
done
[ "$LFAIL" -eq 0 ] && pass "the print fits a phone held sideways (2 landscape · 2 upright)" \
                   || fail "the print fits a phone held sideways:$LMSG"

# Gate 41: witnessed courage stops at 5 — when a neighbour blooms, a known person at GAN 4 rises to 5 (float printed), a known person at GAN 5 stays 5
# (no float), and an unknown person is untouched.
python3 - "$TMP" <<'PYEOF39'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
function floats(p,str){ return bubbles.filter(function(b){ return b.p===p && b.lay.lines.join(" ").indexOf(str)>=0; }).length; }
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  S.nudged=true; S.season=4; S.luat=6; S.luatNext=6; S.von=10;
  var mai=S.cast[2], vu=S.cast[3], hoa=S.cast[4], tu=S.cast[5];
  S.cast.forEach(function(q){ q.started=true; q.known=false; });               // nobody else rolls or witnesses
  mai.started=false; mai.known=true; mai.tai=10; mai.gan=9; mai.ban=10; mai.mom=0;   // ~0.85 — she blooms this tick
  vu.started=false; vu.known=true; vu.gan=4; vu.tai=1; vu.ban=1;             // GAN 4 → 5 (a zero row: she cannot bloom, only witness)
  hoa.started=false; hoa.known=true; hoa.gan=5; hoa.tai=1; hoa.ban=1;        // GAN 5 → stays 5
  tu.started=false; tu.known=false; tu.gan=4; tu.tai=1; tu.ban=1;            // unknown → untouched
  var R=Math.random; Math.random=function(){ return 0.5; };                  // Mai's 0.85 lands; the zero rows return 0 regardless
  nextSeason(); Math.random=R;
  var ok = mai.started && vu.gan===5 && hoa.gan===5 && tu.gan===4;
  setTimeout(function(){ var f4=floats(vu,"+1 GAN"), f5=floats(hoa,"+1 GAN"); ok=ok&&f4===1&&f5===0;
    document.title=(ok?"WITNESS_OK":"WITNESS_BAD")+" bloomed="+mai.started+" vu4to="+vu.gan+" hoa5to="+hoa.gan+" tuUnknown="+tu.gan+" floats4="+f4+" floats5="+f5; },2000);
}catch(e){ document.title="THREW: "+e.message; } },600);
</script>"""
open(tmp+"/wit.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF39
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=6000 --dump-dom "file://$TMP/wit.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "WITNESS_OK" && pass "witnessed courage stops at 5: $T" || fail "witnessed courage stops at 5: $T"

# Gate 42: the year no one dared — with constraint 4 tied, the failure night is refused (no hand spent, GAN unchanged, button struck through),
# the intro offers the fourth tied hand, and a save carries constraint 4 back; without it the failure night works.
python3 - "$TMP" <<'PYEOF42'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  var offered=document.querySelectorAll('.con[data-c="4"]').length>=1;
  document.getElementById("startBtn").click();
  var ng=S.cast[0]; selectPerson(0); S.acts=3; S.constraint=4; renderSheet();
  var g0=ng.gan, a0=S.acts; actNerve(); var refused=(ng.gan===g0&&S.acts===a0), struck=document.getElementById("nerveBtn").style.textDecoration.indexOf("line-through")>=0;
  save(); fresh(); var okLoad=load(); var carried=(S.constraint===4);
  S.constraint=0; selectPerson(0); S.acts=3; renderSheet(); var g1=S.cast[0].gan; actNerve(); var works=(S.cast[0].gan===g1+2);
  var ok=offered&&refused&&struck&&okLoad&&carried&&works;
  document.title=(ok?"DARE_OK":"DARE_BAD")+" offered="+offered+" refused="+refused+" struck="+struck+" carried="+carried+" worksWithout="+works;
}catch(e){ document.title="THREW: "+e.message; } },600);
</script>"""
open(tmp+"/dare.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOF42
T=$("$CHROME" --headless --disable-gpu --no-sandbox --virtual-time-budget=5000 --dump-dom "file://$TMP/dare.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "DARE_OK" && pass "the year no one dared: $T" || fail "the year no one dared: $T"

# Gate 43: Reduce Motion is obeyed by the print, not just by one button — the OS setting reached exactly
# one CSS animation while the whole xóm kept drifting, raining, bobbing and throwing confetti. Runs the
# SAME probe twice, with and without --force-prefers-reduced-motion, and asserts the decoration stops
# AND that meaning still moves: the errand walks and the motes (coins to the đình, books off Cô Mai's
# roof) are how the xóm says what it is doing, so freezing everything would be the wrong fix.
python3 - "$TMP" <<'PYEOFCALM'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  for(var s=0;s<6;s++){ S.acts=3; S.nudged=true; nextSeason(); }
  S.cast.forEach(function(p){ p.known=true; p.arriveT=0; });
  var act=S.cast.filter(function(p){return active(p)&&!p.gone;});
  act.forEach(function(p){ p.tx=p.x; p.ty=p.y; p.vUntil=0; p.amb=0; });
  S.luat=2;                            // a heavy sky, so rain would spawn
  petals(400,300,26,["#D97C8E"]);      // a celebration burst
  motes.length=0; motes.push({x0:100,y0:100,x1:400,y1:300,t:-0.3,g:"🪙"});   // meaning in flight
  var maxAmb=0,maxParts=0,maxRain=0,maxMotes=0,bob=0,prev=null;
  for(var f=0;f<120;f++){
    act.forEach(function(p){ p.tx=p.x; p.ty=p.y; });
    drawScene(3000+f*16);
    maxAmb=Math.max(maxAmb,amb.length); maxParts=Math.max(maxParts,parts.length); maxRain=Math.max(maxRain,rain.length);
    maxMotes=Math.max(maxMotes,motes.length);   // the mote finishes its flight inside the window — take the peak, not the leftovers
    var p0=act[0], b=CALM?0:Math.sin((3000+f*16)*0.006+p0.ph)*0.8;
    if(prev!==null) bob+=Math.abs((p0.y+b)-prev);
    prev=p0.y+b;
  }
  document.title="CALM_R query="+(matchMedia("(prefers-reduced-motion: reduce)").matches)+" CALM="+CALM
    +" amb="+maxAmb+" parts="+maxParts+" rain="+maxRain+" bob="+bob.toFixed(1)+" motes="+maxMotes;
}catch(e){ document.title="THREW: "+e.message; } },700);
</script>"""
open(tmp+"/cm.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOFCALM
NORM=$("$CHROME" --headless --disable-gpu --no-sandbox --window-size=1000,780 --virtual-time-budget=9000 --dump-dom "file://$TMP/cm.html" 2>/dev/null | grep -o "CALM_R[^<]*" | head -1)
RED=$("$CHROME"  --headless --disable-gpu --no-sandbox --force-prefers-reduced-motion --window-size=1000,780 --virtual-time-budget=9000 --dump-dom "file://$TMP/cm.html" 2>/dev/null | grep -o "CALM_R[^<]*" | head -1)
CALMOK=1
echo "$NORM" | grep -q "CALM=false" || CALMOK=0
echo "$RED"  | grep -q "CALM=true"  || CALMOK=0
# normal: decoration is alive
echo "$NORM" | grep -qE "amb=[1-9]" || CALMOK=0
echo "$NORM" | grep -qE "parts=[1-9]" || CALMOK=0
# reduce: decoration is still, meaning still moves
echo "$RED" | grep -q "amb=0 parts=0 rain=0 bob=0.0" || CALMOK=0
echo "$RED" | grep -qE "motes=[1-9]" || CALMOK=0
[ "$CALMOK" -eq 1 ] && pass "Reduce Motion is obeyed by the print: [normal $NORM] [reduce $RED]" \
                    || fail "Reduce Motion is obeyed by the print: [normal $NORM] [reduce $RED]"

# Gate 44: the keyboard can see where it is, and the roster can be reached — the stylesheet said nothing
# about focus at all, so a keyboard got Chrome's 1px blue ring: foreign to a paper-and-ink print and
# nearly invisible on the red button and the ink-dark selected chip. And the ring had nowhere to land on
# the roster, whose chips were plain divs: 0 of 6 reachable by Tab. Asserts the ring is the xóm's own and
# thick, that it INVERTS on the dark grounds, that every chip is focusable, and — the clause that stops
# this being theatre — that Enter on a focused chip actually picks that villager.
python3 - "$TMP" <<'PYEOFFOCUS'
import sys
tmp=sys.argv[1]; html=open("index.html").read()
drv=r"""
<script>
window.onerror=function(m,s,l){document.title="JSERR: "+m+" @"+l;};
setTimeout(function(){ try{
  localStorage.removeItem("thua-so-khong-v1");
  document.getElementById("startBtn").click();
  for(var s=0;s<6;s++){ S.acts=3; S.nudged=true; nextSeason(); }
  S.cast.forEach(function(p){ p.known=true; });
  selectPerson(1); render(); renderSheet();
  setTimeout(function(){ try{
    var sel="a[href],button:not([disabled]),input,select,textarea,[tabindex]:not([tabindex='-1'])";
    var chips=document.querySelectorAll(".roster .rc"), chipF=0;
    chips.forEach(function(c){ if(c.matches(sel)) chipF++; });
    function ring(el){ el.focus({focusVisible:true}); var cs=getComputedStyle(el);
      return {w:parseFloat(cs.outlineWidth)||0, c:cs.outlineColor, halo:cs.boxShadow!=="none"}; }
    var onPaper=ring(document.getElementById("helpBtn"));      // ink ground is light here
    var onDark=ring(document.getElementById("nextBtn"));       // the red MÙA SAU button
    var inkish=/rgb\(43, 35, 32\)/.test(onPaper.c);
    var paperish=/rgb\(245, 234, 208\)/.test(onDark.c);
    var chip=document.querySelector('.rc[data-id="0"]'), operable=false;
    if(chip){ S.sel=-1; chip.focus();
      chip.dispatchEvent(new KeyboardEvent("keydown",{key:"Enter",bubbles:true}));
      operable=(S.sel===0); }
    var ok = chips.length>=5 && chipF===chips.length
          && onPaper.w>=3 && onDark.w>=3 && inkish && paperish && onPaper.halo && onDark.halo
          && operable;
    document.title=(ok?"FOCUS_OK":"FOCUS_BAD")+" chips="+chips.length+"/"+chipF
      +" onPaper="+onPaper.w+"px "+onPaper.c+" onDark="+onDark.w+"px "+onDark.c
      +" inverts="+(inkish&&paperish)+" enterPicks="+operable;
  }catch(e2){ document.title="THREW2: "+e2.message; } },400);
}catch(e){ document.title="THREW: "+e.message; } },700);
</script>"""
open(tmp+"/fk.html","w").write(html.replace("</body>",drv+"</body>"))
PYEOFFOCUS
T=$("$CHROME" --headless --disable-gpu --no-sandbox --window-size=1000,780 --virtual-time-budget=9000 --dump-dom "file://$TMP/fk.html" 2>/dev/null | grep -o "<title>[^<]*</title>")
echo "$T" | grep -q "FOCUS_OK" && pass "the keyboard can see where it is: $T" || fail "the keyboard can see where it is: $T"

rm -rf "$TMP"
[ "$FAIL" -ne 0 ] && { echo; echo "🚫 GATES FAILED — DO NOT SHIP."; exit 1; }
echo; echo "🟢 ALL GATES GREEN."
