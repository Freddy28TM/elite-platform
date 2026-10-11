#!/bin/bash

echo "════════════════════════════════════════════════════════════"
echo "     ECHO COMMAND LAB"
echo "════════════════════════════════════════════════════════════"
echo ""

echo "▸ 1. Print simple text"
echo "  Command: echo Hello World"
echo "  Result:"
echo "Hello World"
echo ""

echo "▸ 2. Print with quotes"
echo "  Command: echo \"Hello World\""
echo "  Result:"
echo "Hello World"
echo ""

echo "▸ 3. Print variable"
echo "  Command: echo \$HOME"
echo "  Result: $HOME"
echo ""

echo "▸ 4. Print command result"
echo "  Command: echo \"Today is \$(date)\""
echo "  Result: Today is $(date)"
echo ""

echo "▸ 5. Write to file (overwrite)"
echo "  Command: echo 'line 1' > /tmp/echo-test.txt"
echo "line 1" > /tmp/echo-test.txt
echo "  File content:"
cat /tmp/echo-test.txt
echo ""

echo "▸ 6. Append to file"
echo "  Command: echo 'line 2' >> /tmp/echo-test.txt"
echo "line 2" >> /tmp/echo-test.txt
echo "  File content:"
cat /tmp/echo-test.txt
echo ""

echo "▸ 7. Print multiple lines"
echo "  Command: echo -e 'Line1\\nLine2\\nLine3'"
echo -e 'Line1\nLine2\nLine3'
echo ""

echo "▸ 8. Print without trailing newline"
echo "  Command: echo -n 'No newline'"
echo -n "No newline"
echo " (end)"
echo ""

echo "▸ 9. Print to standard error"
echo "  Command: echo 'error message' >&2"
echo "error message" >&2 2>/dev/null
echo "  (sent to stderr)"
echo ""

echo "▸ CLEANUP"
rm -f /tmp/echo-test.txt
echo "  ✓ Cleaned up"
echo ""

echo "════════════════════════════════════════════════════════════"
echo "     ECHO LAB COMPLETE"
echo "════════════════════════════════════════════════════════════"

