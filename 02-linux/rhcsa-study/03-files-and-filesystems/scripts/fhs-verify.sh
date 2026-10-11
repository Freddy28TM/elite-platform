#!/usr/bin/env bash
# fhs-verify.sh - Verify Filesystem Hierarchy Standard layout on this system
# Part of RHCSA Module 03, Part 01
set -euo pipefail

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

pass() { echo -e "${GREEN}[PASS]${NC} $*"; }
fail() { echo -e "${RED}[FAIL]${NC} $*"; }
info() { echo -e "${YELLOW}[INFO]${NC} $*"; }

echo "=== FHS Verification - $(date) ==="
echo

info "Checking usr-merge symlinks..."
for link in /bin /sbin /lib /lib64; do
  if [[ -L "$link" ]]; then
    pass "$link -> $(readlink "$link")"
  else
    fail "$link is not a symlink"
  fi
done
echo

info "Checking virtual filesystems..."
for fs in proc sysfs devtmpfs; do
  if mount | grep -q "type $fs"; then
    pass "$fs mounted"
  else
    fail "$fs not mounted"
  fi
done
echo

info "Checking volatile directories (tmpfs)..."
for d in /tmp /run; do
  fstype=$(findmnt -no FSTYPE "$d" 2>/dev/null || echo unknown)
  if [[ "$fstype" == "tmpfs" ]]; then
    pass "$d is tmpfs (volatile)"
  else
    fail "$d is $fstype (expected tmpfs)"
  fi
done
echo

info "Checking essential binaries resolve..."
for b in ls cp mv rm cat bash grep find; do
  if path=$(command -v "$b" 2>/dev/null); then
    pass "$b -> $(readlink -f "$path")"
  else
    fail "$b not found"
  fi
done
echo

info "Checking essential directories exist..."
for d in /etc /var /home /root /boot /usr /opt /srv /mnt /media; do
  if [[ -d "$d" ]]; then
    pass "$d exists"
  else
    fail "$d missing"
  fi
done
echo

info "Disk usage snapshot:"
df -hT / /var /tmp /run 2>/dev/null | awk 'NR==1 || /^\// {print "  " $0}'
echo

echo "=== Done ==="
