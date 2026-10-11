#!/bin/bash
# Improved Bug Bounty Reconnaissance
# Usage: ./recon_v2.sh <target-domain>

TARGET=$1
OUTPUT_DIR="/data/elite-platform/bug-bounty/recon"

if [ -z "$TARGET" ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

mkdir -p "$OUTPUT_DIR/$TARGET"
OUT="$OUTPUT_DIR/$TARGET"

echo "════════════════════════════════════════════════════════════"
echo "     BUG BOUNTY RECON v2: $TARGET"
echo "════════════════════════════════════════════════════════════"
echo ""

# Step 1: Subdomain enumeration (multiple sources)
echo "[+] Step 1: Subdomain enumeration..."
subfinder -d "$TARGET" -silent > "$OUT/subs_subfinder.txt" 2>/dev/null
assetfinder --subs-only "$TARGET" > "$OUT/subs_assetfinder.txt" 2>/dev/null

# Merge
cat "$OUT"/subs_*.txt 2>/dev/null | sort -u > "$OUT/subdomains_raw.txt"
echo "    Raw: $(wc -l < "$OUT/subdomains_raw.txt")"

# Step 2: Clean garbage
echo "[+] Step 2: Cleaning subdomains..."
grep -vE '^[0-9]' "$OUT/subdomains_raw.txt" | \
grep -vE '\.w\.|\.colo\.|\.static\.|\.unused\.' | \
grep -vE '[0-9]{3,}' | \
grep -vE '^[a-z0-9]{15,}$' | \
grep -E "\.$TARGET$" | \
sort -u > "$OUT/subdomains_clean.txt"
echo "    Clean: $(wc -l < "$OUT/subdomains_clean.txt")"

# Step 3: Check live hosts (only clean subs)
echo "[+] Step 3: Checking live hosts..."
cat "$OUT/subdomains_clean.txt" | httpx -silent -o "$OUT/live_hosts.txt" 2>/dev/null
echo "    Live: $(wc -l < "$OUT/live_hosts.txt")"

# Step 4: URL discovery from live hosts
echo "[+] Step 4: URL discovery..."
if [ -s "$OUT/live_hosts.txt" ]; then
    cat "$OUT/live_hosts.txt" | gau --threads 5 > "$OUT/urls.txt" 2>/dev/null
    cat "$OUT/live_hosts.txt" | waybackurls >> "$OUT/urls.txt" 2>/dev/null
    sort -u "$OUT/urls.txt" -o "$OUT/urls.txt"
fi
echo "    URLs: $(wc -l < "$OUT/urls.txt" 2>/dev/null || echo 0)"

# Summary
echo ""
echo "════════════════════════════════════════════════════════════"
echo "     RECON COMPLETE: $TARGET"
echo "════════════════════════════════════════════════════════════"
echo ""
echo "▸ Live Hosts:"
cat "$OUT/live_hosts.txt" 2>/dev/null | head -20
echo ""
echo "▸ Results in: $OUT/"
