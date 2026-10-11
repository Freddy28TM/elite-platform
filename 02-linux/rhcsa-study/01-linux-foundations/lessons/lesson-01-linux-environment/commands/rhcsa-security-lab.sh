#!/bin/bash

echo "════════════════════════════════════════════════════════════"
echo "     RHCSA SECURITY OBSERVATIONS"
echo "════════════════════════════════════════════════════════════"
echo ""

echo "▸ OBSERVATION 1: Sensitive file protection"
echo "  What: /etc/shadow stores password hashes"
echo "  Command: ls -la /etc/shadow"
ls -la /etc/shadow
echo "  Meaning: Only root and shadow group can read"
echo ""

echo "▸ OBSERVATION 2: Shared directory protection"
echo "  What: /tmp is shared but protected by sticky bit"
echo "  Command: ls -ld /tmp"
ls -ld /tmp
echo "  Meaning: Only file owners can delete their files"
echo ""

echo "▸ OBSERVATION 3: Restricted directories"
echo "  What: /lost+found is accessible only by root"
echo "  Command: ls -ld /lost+found"
ls -ld /lost+found
echo "  Meaning: Even listing is denied to normal users"
echo ""

echo "▸ OBSERVATION 4: SUID files (privilege escalation risk)"
echo "  What: Files that run as the file owner (usually root)"
echo "  Command: find /usr/bin -perm -4000 -type f 2>/dev/null | head -10"
find /usr/bin -perm -4000 -type f 2>/dev/null | head -10
echo "  Meaning: These files run as root when executed"
echo ""

echo "▸ OBSERVATION 5: World-writable files (risky)"
echo "  What: Files anyone can modify"
echo "  Command: find /tmp -perm -002 -type f 2>/dev/null | head -5"
find /tmp -perm -002 -type f 2>/dev/null | head -5
echo "  (Results may vary - empty is normal for a clean system)"
echo ""

echo "▸ OBSERVATION 6: Listening services (attack surface)"
echo "  What: Services waiting for network connections"
echo "  Command: ss -tlnp 2>/dev/null | head -10"
ss -tlnp 2>/dev/null | head -10
echo ""

echo "════════════════════════════════════════════════════════════"
echo "     SECURITY LAB COMPLETE"
echo "════════════════════════════════════════════════════════════"

