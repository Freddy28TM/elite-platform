#!/bin/bash
# Binary Information Collector
# Usage: ./bin_info.sh <binary> [output_dir]

BINARY=$1
OUTPUT_DIR=${2:-"./analysis"}
BASENAME=$(basename "$BINARY")
TIMESTAMP=$(date +%Y%m%d-%H%M%S)

if [ -z "$BINARY" ]; then
    echo "Usage: $0 <binary> [output_dir]"
    exit 1
fi

if [ ! -f "$BINARY" ]; then
    echo "Error: $BINARY not found"
    exit 1
fi

mkdir -p "$OUTPUT_DIR/${BASENAME}_${TIMESTAMP}"
OUT="$OUTPUT_DIR/${BASENAME}_${TIMESTAMP}"

echo "[+] Analyzing: $BINARY"
echo "[+] Output: $OUT"

# File information
file "$BINARY" > "$OUT/file_info.txt"

# Hash values
md5sum "$BINARY" > "$OUT/hashes.txt"
sha1sum "$BINARY" >> "$OUT/hashes.txt"
sha256sum "$BINARY" >> "$OUT/hashes.txt"

# Strings
strings -a -n 4 "$BINARY" > "$OUT/strings.txt"
strings -a -n 4 -e l "$BINARY" > "$OUT/strings_utf16.txt" 2>/dev/null

# ELF headers
readelf -a "$BINARY" > "$OUT/elf_headers.txt" 2>/dev/null
readelf -S "$BINARY" > "$OUT/sections.txt" 2>/dev/null
nm -a "$BINARY" > "$OUT/symbols.txt" 2>/dev/null
readelf --dyn-syms "$BINARY" > "$OUT/dynamic_symbols.txt" 2>/dev/null

# Disassembly
objdump -d -M intel "$BINARY" > "$OUT/disasm_intel.asm" 2>/dev/null

# Security mitigations
{
    echo "=== SECURITY MITIGATIONS ==="
    echo ""
    
    # NX
    if readelf -l "$BINARY" 2>/dev/null | grep -q "GNU_STACK.*RWE"; then
        echo "[!] NX: DISABLED"
    else
        echo "[+] NX: Enabled"
    fi
    
    # PIE
    if readelf -h "$BINARY" 2>/dev/null | grep -q "DYN"; then
        echo "[+] PIE: Enabled"
    else
        echo "[!] PIE: Disabled"
    fi
    
    # Stack Canary
    if readelf -s "$BINARY" 2>/dev/null | grep -q "__stack_chk_fail"; then
        echo "[+] Stack Canary: Enabled"
    else
        echo "[!] Stack Canary: Disabled"
    fi
    
    # RELRO
    if readelf -l "$BINARY" 2>/dev/null | grep -q "GNU_RELRO"; then
        if readelf -d "$BINARY" 2>/dev/null | grep -q "BIND_NOW"; then
            echo "[+] RELRO: Full"
        else
            echo "[~] RELRO: Partial"
        fi
    else
        echo "[!] RELRO: Disabled"
    fi
} > "$OUT/security_mitigations.txt"

# Dangerous functions
{
    echo "=== DANGEROUS FUNCTIONS ==="
    echo ""
    DISASM=$(objdump -d "$BINARY" 2>/dev/null)
    for func in strcpy strcat sprintf gets scanf system exec popen malloc free memcpy; do
        count=$(echo "$DISASM" | grep -c "call.*<$func" 2>/dev/null | head -1)
        count=${count:-0}
        if [ "$count" -gt 0 ] 2>/dev/null; then
            echo "[!] $func: $count references"
        fi
    done
} > "$OUT/dangerous_functions.txt"

echo ""
echo "[+] Analysis complete! Results in: $OUT"
echo ""
echo "=== SECURITY SUMMARY ==="
cat "$OUT/security_mitigations.txt"
echo ""
cat "$OUT/dangerous_functions.txt"
