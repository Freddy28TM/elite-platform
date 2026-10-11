#!/bin/bash

echo "════════════════════════════════════════════════════════════"
echo "     GREP COMMAND LAB"
echo "════════════════════════════════════════════════════════════"
echo ""

# Setup
mkdir -p /tmp/grep-lab
cd /tmp/grep-lab

# Create test file
cat > logfile.txt << 'LOG'
2026-10-11 10:00:00 INFO Server started
2026-10-11 10:01:00 ERROR Failed to connect
2026-10-11 10:02:00 INFO User logged in
2026-10-11 10:03:00 WARNING Disk space low
2026-10-11 10:04:00 ERROR Database timeout
2026-10-11 10:05:00 INFO Request received
2026-10-11 10:06:00 ERROR Authentication failed
LOG

echo "▸ 1. Basic search"
echo "  Command: grep ERROR logfile.txt"
grep ERROR logfile.txt
echo ""

echo "▸ 2. Case-insensitive search"
echo "  Command: grep -i error logfile.txt"
grep -i error logfile.txt
echo ""

echo "▸ 3. Show line numbers"
echo "  Command: grep -n ERROR logfile.txt"
grep -n ERROR logfile.txt
echo ""

echo "▸ 4. Invert match (not matching)"
echo "  Command: grep -v ERROR logfile.txt"
grep -v ERROR logfile.txt
echo ""

echo "▸ 5. Count matches"
echo "  Command: grep -c ERROR logfile.txt"
grep -c ERROR logfile.txt
echo ""

echo "▸ 6. Multiple patterns"
echo "  Command: grep -E 'ERROR|WARNING' logfile.txt"
grep -E 'ERROR|WARNING' logfile.txt
echo ""

echo "▸ 7. Search in directory (recursive)"
echo "  Command: grep -r ERROR /tmp/grep-lab/"
grep -r ERROR /tmp/grep-lab/
echo ""

echo "▸ 8. Show filenames"
echo "  Command: grep -l ERROR *.txt"
grep -l ERROR *.txt
echo ""

echo "▸ 9. Search with context"
echo "  Command: grep -A 1 ERROR logfile.txt"
echo "  (shows 1 line After each match)"
grep -A 1 ERROR logfile.txt
echo ""

echo "▸ 10. Search with pipe"
echo "  Command: cat logfile.txt | grep ERROR"
cat logfile.txt | grep ERROR
echo ""

echo "▸ CLEANUP"
cd /tmp
rm -rf /tmp/grep-lab
echo "  ✓ Cleaned up"
echo ""

echo "════════════════════════════════════════════════════════════"
echo "     GREP LAB COMPLETE"
echo "════════════════════════════════════════════════════════════"

