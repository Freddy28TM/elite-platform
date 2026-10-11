#!/bin/bash

echo "=== Bug Bounty Lab Status ==="
echo

if ! docker info >/dev/null 2>&1; then
    echo "[!] Docker is not reachable."
    echo "    DOCKER_HOST=${DOCKER_HOST:-<unset>}"
    exit 1
fi

echo "=== Docker ==="
echo "DOCKER_HOST=${DOCKER_HOST:-<unset>}"
echo
echo "=== Containers ==="
docker ps -a --filter "name=juice-shop" --filter "name=dvwa" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
echo
echo "=== Listening Ports ==="
ss -tlnp 2>/dev/null | grep -E ":(3000|8080|8081)\b" || echo "No lab/Burp ports detected."
echo
echo "=== Disk Space ==="
df -h /
