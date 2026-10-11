#!/bin/bash

echo "════════════════════════════════════════════════════════════"
echo "     FIND COMMAND LAB"
echo "════════════════════════════════════════════════════════════"
echo ""

echo "▸ 1. Find by name"
echo "  Command: find /etc -name 'hostname' 2>/dev/null"
find /etc -name "hostname" 2>/dev/null
echo ""

echo "▸ 2. Find by name (wildcard)"
echo "  Command: find /etc -name '*.conf' 2>/dev/null | head -5"
find /etc -name "*.conf" 2>/dev/null | head -5
echo ""

echo "▸ 3. Find by type (file)"
echo "  Command: find /etc -type f -name 'hosts' 2>/dev/null"
find /etc -type f -name "hosts" 2>/dev/null
echo ""

echo "▸ 4. Find by type (directory)"
echo "  Command: find /etc -type d -name 'ssh' 2>/dev/null"
find /etc -type d -name "ssh" 2>/dev/null
echo ""

echo "▸ 5. Find by size"
echo "  Command: find /var/log -size +1M 2>/dev/null | head -5"
find /var/log -size +1M 2>/dev/null | head -5
echo ""

echo "▸ 6. Find by permission (SUID)"
echo "  Command: find /usr/bin -perm -4000 -type f 2>/dev/null | head -5"
find /usr/bin -perm -4000 -type f 2>/dev/null | head -5
echo ""

echo "▸ 7. Find by modification time"
echo "  Command: find /tmp -mtime -1 2>/dev/null | head -5"
find /tmp -mtime -1 2>/dev/null | head -5
echo ""

echo "▸ 8. Find and execute"
echo "  Command: find /tmp -name '*.tmp' -delete 2>/dev/null"
echo "  (would delete temp files)"
echo ""

echo "▸ 9. Find with multiple criteria"
echo "  Command: find /etc -type f -name '*.conf' -size +10k 2>/dev/null | head -5"
find /etc -type f -name "*.conf" -size +10k 2>/dev/null | head -5
echo ""

echo "▸ 10. Find in current directory"
echo "  Command: find . -name '*.md' 2>/dev/null | head -5"
cd /data/cybersecurity/elite-platform/02-linux/rhcsa-study/
find . -name "*.md" 2>/dev/null | head -5
echo ""

echo "════════════════════════════════════════════════════════════"
echo "     FIND LAB COMPLETE"
echo "════════════════════════════════════════════════════════════"

