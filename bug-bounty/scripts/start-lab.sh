#!/bin/bash
set -u

echo "[+] Starting Bug Bounty Lab..."
echo

if ! docker info >/dev/null 2>&1; then
    echo "[!] Docker is not reachable."
    echo "    Expected Docker socket: /var/run/docker.sock"
    exit 1
fi

if docker container inspect juice-shop >/dev/null 2>&1; then
    docker start juice-shop >/dev/null 2>&1 || true
else
    docker run -d --name juice-shop -p 3000:3000 bkimminich/juice-shop
fi

if docker container inspect dvwa >/dev/null 2>&1; then
    docker start dvwa >/dev/null 2>&1 || true
else
    docker run -d --name dvwa -p 8081:80 vulnerables/web-dvwa
fi

echo
echo "[+] Lab Status:"
docker ps --filter "name=juice-shop" --filter "name=dvwa" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
echo
echo "Juice Shop -> http://localhost:3000"
echo "DVWA       -> http://localhost:8081"
echo "Burp       -> 127.0.0.1:8080"
