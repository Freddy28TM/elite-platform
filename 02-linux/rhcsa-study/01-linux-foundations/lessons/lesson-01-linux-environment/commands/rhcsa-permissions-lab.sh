#!/bin/bash

echo "════════════════════════════════════════════════════════════"
echo "     RHCSA PERMISSIONS LAB"
echo "════════════════════════════════════════════════════════════"
echo ""

# Setup
mkdir -p /tmp/perm-lab
cd /tmp/perm-lab

echo "▸ COMMAND 1: touch — Create files"
echo "  Command: touch file1.txt file2.txt file3.txt"
touch file1.txt file2.txt file3.txt
ls -la
echo ""

echo "▸ COMMAND 2: chmod — Change permissions"
echo "  Command: chmod 644 file1.txt"
chmod 644 file1.txt
echo "  Command: chmod 755 file2.txt"
chmod 755 file2.txt
echo "  Command: chmod 600 file3.txt"
chmod 600 file3.txt
ls -la
echo ""

echo "▸ COMMAND 3: chmod symbolic mode"
echo "  Command: chmod u+x file1.txt"
chmod u+x file1.txt
echo "  Command: chmod g-w file2.txt"
chmod g-w file2.txt
ls -la
echo ""

echo "▸ COMMAND 4: chown — Change owner"
echo "  (Requires sudo)"
echo "  Command: sudo chown root:root file1.txt"
sudo chown root:root file1.txt 2>/dev/null
ls -la file1.txt
echo ""

echo "▸ COMMAND 5: chgrp — Change group"
echo "  Command: sudo chgrp shadow file2.txt"
sudo chgrp shadow file2.txt 2>/dev/null
ls -la file2.txt
echo ""

echo "▸ PERMISSION REFERENCE"
echo "  ---  = 000 = no access"
echo "  r--  = 400 = read"
echo "  rw-  = 600 = read+write"
echo "  rwx  = 700 = read+write+execute"
echo "  r--r--r-- = 444 = read for all"
echo "  rw-r--r-- = 644 = standard file"
echo "  rwxr-xr-x = 755 = executable"
echo "  rwxrwxrwx = 777 = dangerous"
echo ""

echo "▸ CLEANUP"
cd /tmp
rm -rf /tmp/perm-lab
echo "  ✓ Lab cleaned up"
echo ""

echo "════════════════════════════════════════════════════════════"
echo "     PERMISSIONS LAB COMPLETE"
echo "════════════════════════════════════════════════════════════"

