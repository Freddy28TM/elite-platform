#!/bin/bash

echo "════════════════════════════════════════════════════════════"
echo "     FILESYSTEM TOUR"
echo "════════════════════════════════════════════════════════════"
echo ""

for dir in / /root /home /etc /usr /var /tmp /opt /dev /proc /sys /run /boot /media /mnt /srv /lost+found; do
    if [ -d "$dir" ]; then
        echo "▸ $dir"
        ls -ld "$dir" 2>/dev/null | awk '{print "    " $1, $3, $4}'
    else
        echo "▸ $dir — not accessible"
    fi
done
echo ""
echo "════════════════════════════════════════════════════════════"
