#!/bin/bash
# Subdomain Enumeration Automation
# Usage: ./subdomain_enum.sh <domain>

DOMAIN=$1
OUTPUT_DIR="${2:-/data/elite-platform/bug-bounty/recon/subdomains}"

if [ -z "$DOMAIN" ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

mkdir -p "$OUTPUT_DIR/$DOMAIN"
OUT="$OUTPUT_DIR/$DOMAIN"

echo "════════════════════════════════════════════════════════════"
echo "     SUBDOMAIN ENUMERATION: $DOMAIN"
echo "════════════════════════════════════════════════════════════"
echo ""

# Passive enumeration
echo "[+] Passive enumeration..."

# Subfinder
echo "    Running subfinder..."
subfinder -d "$DOMAIN" -silent > "$OUT/subfinder.txt" 2>/dev/null

# Assetfinder
echo "    Running assetfinder..."
assetfinder --subs-only "$DOMAIN" > "$OUT/assetfinder.txt" 2>/dev/null

# Amass
echo "    Running amass (passive)..."
timeout 120 amass enum -passive -d "$DOMAIN" > "$OUT/amass.txt" 2>/dev/null

# Merge results
echo "[+] Merging results..."
cat "$OUT"/*.txt 2>/dev/null | sort -u > "$OUT/all_subdomains.txt"

# Count
TOTAL=$(wc -l < "$OUT/all_subdomains.txt")
echo ""
echo "[+] Total unique subdomains: $TOTAL"
echo ""
echo "[+] Top 20 subdomains:"
head -20 "$OUT/all_subdomains.txt"

echo ""
echo "[+] Results saved to: $OUT/"
