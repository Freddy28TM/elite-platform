#!/bin/bash

echo "════════════════════════════════════════════════════════════"
echo "     CAT COMMAND LAB"
echo "════════════════════════════════════════════════════════════"
echo ""

# Setup
mkdir -p /tmp/cat-lab
cd /tmp/cat-lab

echo "▸ 1. Create test files"
echo "  Commands: echo 'line 1' > file1.txt && echo 'line 2' > file2.txt"
echo "line 1" > file1.txt
echo "line 2" > file2.txt
echo "  Files created"
echo ""

echo "▸ 2. View single file"
echo "  Command: cat file1.txt"
cat file1.txt
echo ""

echo "▸ 3. View multiple files (concatenate)"
echo "  Command: cat file1.txt file2.txt"
cat file1.txt file2.txt
echo ""

echo "▸ 4. Show line numbers"
echo "  Command: cat -n file1.txt"
cat -n file1.txt
echo ""

echo "▸ 5. Show line numbers (non-blank only)"
echo "  Command: cat -b file1.txt"
printf "line 1\n\nline 3\n" > file3.txt
cat -b file3.txt
echo ""

echo "▸ 6. Show end of lines"
echo "  Command: cat -E file1.txt"
cat -E file1.txt
echo ""

echo "▸ 7. Show tabs"
echo "  Command: cat -T file1.txt"
printf "col1\tcol2\n" > file4.txt
cat -T file4.txt
echo ""

echo "▸ 8. Squeeze blank lines"
echo "  Command: cat -s file3.txt"
cat -s file3.txt
echo ""

echo "▸ 9. Create file with cat"
echo "  Command: cat > newfile.txt (type, Ctrl+D to end)"
echo "created via cat" > newfile.txt
cat newfile.txt
echo ""

echo "▸ 10. Append to file with cat"
echo "  Command: cat >> newfile.txt"
echo "appended line" >> newfile.txt
cat newfile.txt
echo ""

echo "▸ CLEANUP"
cd /tmp
rm -rf /tmp/cat-lab
echo "  ✓ Cleaned up"
echo ""

echo "════════════════════════════════════════════════════════════"
echo "     CAT LAB COMPLETE"
echo "════════════════════════════════════════════════════════════"

