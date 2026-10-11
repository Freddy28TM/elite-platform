#!/bin/bash
# Radare2 Analysis Helper

BINARY=$1

if [ -z "$BINARY" ]; then
    echo "Usage: $0 <binary>"
    exit 1
fi

if [ ! -f "$BINARY" ]; then
    echo "Error: $BINARY not found"
    exit 1
fi

R2_OPTS="-q -e bin.relocs.apply=true"

echo "════════════════════════════════════════════════════════════"
echo "     RADARE2 ANALYSIS: $BINARY"
echo "════════════════════════════════════════════════════════════"
echo ""

echo "▸ FILE INFO:"
r2 $R2_OPTS -c "iI; q" "$BINARY" 2>/dev/null

echo ""
echo "▸ FUNCTIONS:"
r2 $R2_OPTS -c "aaa; afl; q" "$BINARY" 2>/dev/null

echo ""
echo "▸ STRINGS (interesting):"
r2 $R2_OPTS -c "izz; q" "$BINARY" 2>/dev/null | head -30

echo ""
echo "════════════════════════════════════════════════════════════"
echo "     INTERACT: r2 -e bin.relocs.apply=true $BINARY"
echo "════════════════════════════════════════════════════════════"
