#!/bin/bash

echo "════════════════════════════════════════════════════════════"
echo "     USER AND GROUP INFORMATION"
echo "════════════════════════════════════════════════════════════"
echo ""
echo "▸ Current User (whoami):"
whoami
echo ""
echo "▸ User ID and Groups (id):"
id
echo ""
echo "▸ Group Membership (groups):"
groups
echo ""
echo "▸ User Database Entry (getent passwd):"
getent passwd fredrick
echo ""
echo "▸ Group Database Entry (getent group):"
getent group fredrick
echo ""
echo "════════════════════════════════════════════════════════════"
