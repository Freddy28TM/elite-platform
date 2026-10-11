#!/bin/bash

echo "════════════════════════════════════════════════════════════"
echo "     RHCSA PROCESSES LAB"
echo "════════════════════════════════════════════════════════════"
echo ""

echo "▸ COMMAND 1: ps aux"
echo "  Purpose: List all running processes"
echo "  Command: ps aux | head -5"
ps aux | head -5
echo ""

echo "▸ COMMAND 1b: ps aux | wc -l"
echo "  Purpose: Count total processes"
echo "  Command: ps aux | wc -l"
ps aux | wc -l
echo ""

echo "▸ COMMAND 2: top (batch mode)"
echo "  Purpose: Live process view"
echo "  Command: top -bn1 | head -10"
top -bn1 | head -10
echo ""

echo "▸ COMMAND 3: Finding a PID"
echo "  Purpose: Find process by name"
echo "  Command: pgrep -a firefox"
pgrep -a firefox 2>/dev/null || echo "  (Firefox not running)"
echo ""

echo "▸ COMMAND 4: systemctl"
echo "  Purpose: Manage system services"
echo "  Command: systemctl --no-pager list-units --type=service --state=running | head -10"
systemctl --no-pager list-units --type=service --state=running | head -10
echo ""

echo "▸ COMMAND 5: journalctl"
echo "  Purpose: View system logs"
echo "  Command: journalctl --no-pager -n 5"
journalctl --no-pager -n 5 2>/dev/null || echo "  (requires sudo for some logs)"
echo ""

echo "════════════════════════════════════════════════════════════"
echo "     LAB COMPLETE"
echo "════════════════════════════════════════════════════════════"

