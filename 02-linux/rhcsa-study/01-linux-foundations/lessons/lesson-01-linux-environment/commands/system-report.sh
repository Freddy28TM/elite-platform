#!/bin/bash

echo "════════════════════════════════════════════════════════════"
echo "     SYSTEM IDENTIFICATION REPORT"
echo "════════════════════════════════════════════════════════════"
echo ""
echo "▸ Current User:"
whoami
echo ""
echo "▸ Current Directory:"
pwd
echo ""
echo "▸ Hostname:"
hostname
echo ""
echo "▸ Operating System:"
grep PRETTY_NAME /etc/os-release
echo ""
echo "▸ Kernel Release:"
uname -r
echo ""
echo "▸ System Architecture:"
uname -m
echo ""
echo "▸ Full System Info:"
uname -a
echo ""
echo "════════════════════════════════════════════════════════════"
