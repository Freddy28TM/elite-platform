#!/bin/bash
echo "[+] Stopping Bug Bounty Lab..."
docker stop juice-shop dvwa 2>/dev/null
echo "[+] Lab stopped."
docker ps -a --filter "name=juice-shop" --filter "name=dvwa" --format "table {{.Names}}\t{{.Status}}"
