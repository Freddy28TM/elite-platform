#!/bin/bash
# Dynamic Analysis Helper
# Usage: ./dynamic_analyze.sh <binary> [args]

BINARY=$1
ARGS="${@:2}"

if [ -z "$BINARY" ]; then
    echo "Usage: $0 <binary> [args]"
    exit 1
fi

if [ ! -f "$BINARY" ]; then
    echo "Error: $BINARY not found"
    exit 1
fi

echo "════════════════════════════════════════════════════════════"
echo "     DYNAMIC ANALYSIS: $BINARY"
echo "════════════════════════════════════════════════════════════"
echo ""

echo "▸ SYSTEM CALLS (strace):"
strace -f -o /tmp/strace.log "$BINARY" $ARGS 2>/dev/null
echo "  Total syscalls: $(wc -l < /tmp/strace.log)"
echo "  First 10:"
head -10 /tmp/strace.log | sed 's/^/    /'
echo ""

echo "▸ LIBRARY CALLS (ltrace):"
ltrace -f -o /tmp/ltrace.log "$BINARY" $ARGS 2>/dev/null
echo "  Total libcalls: $(wc -l < /tmp/ltrace.log)"
echo "  First 10:"
head -10 /tmp/ltrace.log | sed 's/^/    /'
echo ""

echo "════════════════════════════════════════════════════════════"
