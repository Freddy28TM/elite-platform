#!/bin/bash
# Clean subdomain list — remove garbage
# Usage: ./clean_subdomains.sh <domain>

DOMAIN=$1
if [ -z "$DOMAIN" ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

INPUT="/data/elite-platform/bug-bounty/recon/$DOMAIN/subdomains.txt"
OUTPUT="/data/elite-platform/bug-bounty/recon/$DOMAIN/subdomains_clean.txt"

if [ ! -f "$INPUT" ]; then
    echo "Error: $INPUT not found"
    exit 1
fi

echo "[+] Original subdomains: $(wc -l < "$INPUT")"

# Remove:
# - IP-based subdomains (containing 3+ dots or ending with digits)
# - Wildcard patterns (w., colo., static.)
# - Very long random strings
# - Duplicates

grep -vE '^[0-9]' "$INPUT" | \
grep -vE '\.w\.' | \
grep -vE '\.colo\.' | \
grep -vE '\.static\.' | \
grep -vE '[0-9]{3,}' | \
grep -vE '^[a-z0-9]{15,}$' | \
sort -u > "$OUTPUT"

echo "[+] Cleaned subdomains: $(wc -l < "$OUTPUT")"
echo ""
echo "[+] Preview:"
head -30 "$OUTPUT"
