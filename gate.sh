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
  S.hui=1; ba.ban=2; ba.started=false; ba.known=true; nextSeason(); var lifted=(ba.ban===3&&ba.seen.ban===true);
  ba.ban=3; nextSeason(); var notPast3=(ba.ban===3);
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

rm -rf "$TMP"
[ "$FAIL" -ne 0 ] && { echo; echo "🚫 GATES FAILED — DO NOT SHIP."; exit 1; }
echo; echo "🟢 ALL GATES GREEN."
