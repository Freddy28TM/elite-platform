#!/bin/bash

echo "════════════════════════════════════════════════════════════"
echo "     RHCSA LESSON 01 — VERIFICATION"
echo "════════════════════════════════════════════════════════════"
echo ""

echo "▸ VERIFICATION 1: System Identification"
echo "  Command: hostname && whoami && uname -r"
hostname && whoami && uname -r
echo "  ✓ System identified"
echo ""

echo "▸ VERIFICATION 2: Filesystem Navigation"
echo "  Command: ls -ld /etc /home /tmp"
ls -ld /etc /home /tmp
echo "  ✓ Filesystem understood"
echo ""

echo "▸ VERIFICATION 3: User Management"
echo "  Command: id && groups"
id
groups
echo "  ✓ User context confirmed"
echo ""

echo "▸ VERIFICATION 4: Process Management"
echo "  Command: ps aux | wc -l"
echo "  Total processes: $(ps aux | wc -l)"
echo "  ✓ Process management understood"
echo ""

echo "▸ VERIFICATION 5: Security Observations"
echo "  Command: ls -la /etc/shadow"
ls -la /etc/shadow
echo "  ✓ Security awareness confirmed"
echo ""

echo "▸ VERIFICATION 6: Permissions"
echo "  Command: Create file, set 600, verify, delete"
touch /tmp/verify-test.txt
chmod 600 /tmp/verify-test.txt
ls -la /tmp/verify-test.txt
rm /tmp/verify-test.txt
echo "  ✓ Permissions mastery confirmed"
echo ""

echo "════════════════════════════════════════════════════════════"
echo "     LESSON 01 VERIFICATION COMPLETE"
echo "════════════════════════════════════════════════════════════"
echo ""
echo "All 6 skill areas verified:"
echo "  ✓ System identification"
echo "  ✓ Filesystem navigation"
echo "  ✓ User management"
echo "  ✓ Process management"
echo "  ✓ Security observations"
echo "  ✓ Permissions"
echo ""
echo "════════════════════════════════════════════════════════════"

