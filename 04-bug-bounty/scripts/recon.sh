#!/bin/bash
# Bug Bounty Reconnaissance Automation
# Usage: ./recon.sh <target-domain>

TARGET=$1
OUTPUT_DIR="${2:-/data/elite-platform/bug-bounty/recon}"

if [ -z "$TARGET" ]; then
    echo "Usage: $0 <domain>"
    echo "Example: $0 example.com"
    exit 1
fi

mkdir -p "$OUTPUT_DIR/$TARGET"
OUT="$OUTPUT_DIR/$TARGET"

echo "════════════════════════════════════════════════════════════"
echo "     BUG BOUNTY RECON: $TARGET"
echo "════════════════════════════════════════════════════════════"
echo ""

# Step 1: Subdomain enumeration
echo "[+] Step 1: Subdomain enumeration..."
subfinder -d "$TARGET" -silent > "$OUT/subdomains.txt" 2>/dev/null
assetfinder --subs-only "$TARGET" >> "$OUT/subdomains.txt" 2>/dev/null
amass enum -passive -d "$TARGET" >> "$OUT/subdomains.txt" 2>/dev/null
sort -u "$OUT/subdomains.txt" -o "$OUT/subdomains.txt"
echo "    Found: $(wc -l < "$OUT/subdomains.txt") subdomains"

# Step 2: Check live hosts
echo "[+] Step 2: Checking live hosts..."
cat "$OUT/subdomains.txt" | httpx -silent -o "$OUT/live_hosts.txt" 2>/dev/null
echo "    Live: $(wc -l < "$OUT/live_hosts.txt") hosts"

# Step 3: URL discovery
echo "[+] Step 3: URL discovery..."
cat "$OUT/live_hosts.txt" | gau --threads 5 > "$OUT/urls.txt" 2>/dev/null
cat "$OUT/live_hosts.txt" | waybackurls >> "$OUT/urls.txt" 2>/dev/null
sort -u "$OUT/urls.txt" -o "$OUT/urls.txt"
echo "    URLs: $(wc -l < "$OUT/urls.txt")"

# Step 4: Technology fingerprinting
echo "[+] Step 4: Technology fingerprinting..."
cat "$OUT/live_hosts.txt" | httpx -silent -tech-detect -o "$OUT/tech.txt" 2>/dev/null

# Summary
echo ""
echo "════════════════════════════════════════════════════════════"
echo "     RECON COMPLETE: $TARGET"
echo "════════════════════════════════════════════════════════════"
echo ""
echo "Results saved in: $OUT/"
