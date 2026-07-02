#!/bin/bash
# make-og.sh — regenerate the 1200×630 og.png share image from the live game scene
cd "$(dirname "$0")"
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
TMP=$(mktemp -d)
DRV='<script>setTimeout(function(){localStorage.removeItem("thua-so-khong-v1");document.getElementById("startBtn").click();},400);</script>'
python3 -c "
html=open('index.html').read()
open('$TMP/og.html','w').write(html.replace('</body>','''$DRV</body>'''))
"
"$CHROME" --headless --disable-gpu --no-sandbox --hide-scrollbars \
  --window-size=1200,630 --force-device-scale-factor=1 \
  --virtual-time-budget=4000 --screenshot="$PWD/og.png" "file://$TMP/og.html" >/dev/null 2>&1
rm -rf "$TMP"; ls -la og.png
