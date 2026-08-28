#!/usr/bin/env bash
# Exports every carousel slide to a real 1080x1350 PNG in ./export/
# Requires: the local server running  ->  node srv.js   (see README)
set -e
CHROME="/c/Program Files/Google/Chrome/Application/chrome.exe"
BASE="http://localhost:8899"
OUT="$(cd "$(dirname "$0")" && pwd)/export"
mkdir -p "$OUT"
for d in post-01-nesty-is-live post-02-visite-3d post-03-founding-partners; do
  n=$(grep -c '<section class="slide' "$d/carousel.html")
  for i in $(seq 1 "$n"); do
    f="$OUT/${d}_slide-$(printf %02d "$i").png"
    "$CHROME" --headless=new --disable-gpu --hide-scrollbars \
      --force-device-scale-factor=1 --window-size=1080,1350 \
      --virtual-time-budget=4000 --screenshot="$(cygpath -w "$f" 2>/dev/null || echo "$f")" \
      "$BASE/$d/carousel.html?slide=$i" >/dev/null 2>&1
    echo "  $(basename "$f")"
  done
done
echo "Done -> $OUT"
