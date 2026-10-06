#!/bin/bash
# Elite Platform Setup Script

echo "================================================================"
echo "         ELITE CYBERSECURITY PLATFORM SETUP"
echo "================================================================"
echo ""

if [ ! -f /etc/parrot_version ]; then
    echo "[!] Warning: This platform is optimized for Parrot OS"
fi

if ! mountpoint -q /data; then
    echo "[!] /data is not mounted"
    exit 1
fi

echo "[+] Creating directory structure..."
mkdir -p ~/elite-platform/{reverse-engineering,networking,infrastructure,red-team,blue-team,bug-bounty,grc,tools,scripts,configs,documentation,logs}

echo "[+] Setting up symlinks..."
[ ! -L ~/wordlists ] && ln -s /data/wordlists ~/wordlists
[ ! -L ~/evidence ] && ln -s /data/evidence ~/evidence
[ ! -L ~/vm-images ] && ln -s /data/vm-images ~/vm-images
[ ! -L ~/samples ] && ln -s /data/samples ~/samples

echo "[+] Setup complete!"
echo "    Navigate to: cd ~/elite-platform"
