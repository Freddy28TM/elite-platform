#!/bin/bash

echo "════════════════════════════════════════════════════════════"
echo "     SHELL BASICS LAB"
echo "════════════════════════════════════════════════════════════"
echo ""

echo "▸ Your Shell:"
echo "  Command: echo \$SHELL"
echo "  Result: $SHELL"
echo ""

echo "▸ Your User:"
echo "  Command: whoami"
echo "  Result: $(whoami)"
echo ""

echo "▸ Your Home Directory:"
echo "  Command: echo \$HOME"
echo "  Result: $HOME"
echo ""

echo "▸ Your PATH (where commands are found):"
echo "  Command: echo \$PATH"
echo "  Result: $PATH"
echo ""

echo "▸ Current Directory:"
echo "  Command: pwd"
echo "  Result: $(pwd)"
echo ""

echo "▸ Manual Page for ls (first 15 lines):"
echo "  Command: man ls | head -15"
man ls 2>/dev/null | head -15
echo ""

echo "▸ Quick Help for ls (first 10 lines):"
echo "  Command: ls --help | head -10"
ls --help | head -10
echo ""

echo "════════════════════════════════════════════════════════════"
echo "     SHELL BASICS COMPLETE"
echo "════════════════════════════════════════════════════════════"

