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

rm -rf "$TMP"
[ "$FAIL" -ne 0 ] && { echo; echo "🚫 GATES FAILED — DO NOT SHIP."; exit 1; }
echo; echo "🟢 ALL GATES GREEN."
