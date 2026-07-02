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
  selectPerson(0); actNerve();
  selectPerson(1); actLink(); completeLink(0);   // the apprenticeship beat
  nextSeason(); nextSeason(); nextSeason(); nextSeason();
  // deterministic wiring only — gan is entropy-decayed by design, so don't assert it
  var ok = S.season===4 && S.apprentice===true && S.cast[0].known && S.cast[1].known && S.un.link===true && S.cast[0].tai>=9;
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

rm -rf "$TMP"
[ "$FAIL" -ne 0 ] && { echo; echo "🚫 GATES FAILED — DO NOT SHIP."; exit 1; }
echo; echo "🟢 ALL GATES GREEN."
