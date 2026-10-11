# Setup From Scratch — Complete Lab Rebuild

How to rebuild this lab from a blank laptop.

**Use case:** New laptop, disk failure, migration, or fresh start.

---

## Requirements

| Item | Minimum | Recommended |
|------|---------|-------------|
| CPU | 4 cores | 8+ cores |
| RAM | 8 GB | 16+ GB |
| Storage | 100 GB | 476 GB+ |
| USB drive | 8 GB | 16 GB+ |

---

## Step 1 — Download Parrot OS

| Source | URL |
|--------|-----|
| Official | https://parrotsec.org/download/ |
| Version | Parrot Security 7.4 (echo) or later |
| Format | ISO (for USB) |

**Download the Security edition, not Home edition.**

---

## Step 2 — Create Bootable USB

### On Linux

sudo dd if=Parrot-security-7.4_amd64.iso of=/dev/sdX bs=4M status=progress
sync

**Replace `/dev/sdX` with your USB device. Verify with `lsblk` first.**

### On Windows

Use Rufus or Balena Etcher.

---

## Step 3 — Boot from USB

1. Insert USB
2. Reboot laptop
3. Press F12 / F2 / Esc during startup
4. Select USB from boot menu
5. Choose "Try Parrot OS" or "Install"

---

## Step 4 — Partition the Disk

### Recommended Layout

| Partition | Size | Type | Mount |
|-----------|------|------|-------|
| p1 | 100 MB | EFI | /boot/efi |
| p2 | 425 GB | ext4 | /data |
| p5 | 43 GB | ext4 | / |

**Why split / and /data:**
- System stays clean on /
- All work on /data
- Easy to reinstall OS without losing data

### Partitioning Steps

1. Choose "Manual partitioning" during install
2. Create p1: EFI, 100 MB
3. Create p2: ext4, ~90% of disk, mount /data
4. Create p5: ext4, ~43 GB, mount /
5. Apply and continue

---

## Step 5 — Install Parrot OS

| Option | Choice |
|--------|--------|
| Username | fredrick |
| Hostname | parrot |
| Full name | Fredrick |
| Password | (strong) |
| Time zone | Your location |
| Keyboard | Your layout |

**Let the installer finish. Reboot when done.**


---

## Step 6 — Create /data Domain Folders

After install, open terminal and create the folder structure.

sudo mkdir -p /data/{cybersecurity,development,digital-products,research,archives,wordlists,vm-images,evidence,samples,backups}
sudo chown -R fredrick:fredrick /data/{cybersecurity,development,digital-products,research,archives,wordlists,vm-images,evidence,samples,backups}

# Verify
ls -la /data/

---

## Step 7 — Create Home Symlinks

Link home folders to /data for easy navigation.

cd ~
ln -sf /data/cybersecurity ~/cybersecurity
ln -sf /data/development ~/development
ln -sf /data/digital-products ~/Digital-Products
ln -sf /data/research ~/research
ln -sf /data/wordlists ~/wordlists
ln -sf /data/vm-images ~/vm-images
ln -sf /data/evidence ~/evidence
ln -sf /data/samples ~/samples
ln -sf /data/backups ~/backups
ln -sf /data/archives ~/archives

# Verify
ls -la ~ | grep "\->"

---

## Step 8 — Clone Elite Platform

cd /data/cybersecurity
git clone https://github.com/Freddy28TM/elite-platform.git
cd elite-platform

# Verify structure
ls -la

---

## Step 9 — Install Essential Tools

### System Update

sudo apt update
sudo apt full-upgrade -y
sudo apt install -y build-essential git curl wget vim nano

### Python Environment

sudo apt install -y python3 python3-pip python3-venv

### Common Tools

sudo apt install -y nmap masscan wireshark burpsuite metasploit-framework

### Bug Bounty Tools (Go-based)

go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install github.com/projectdiscovery/httpx/cmd/httpx@latest
go install github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
go install github.com/tomnomnom/assetfinder@latest
go install github.com/lc/gau/v2/cmd/gau@latest

### Reverse Engineering Tools

sudo apt install -y radare2 gdb strace ltrace

### Verify Installation

which nmap subfinder httpx nuclei ffuf git go python3


---

## Step 10 — Configure Git

git config --global user.name "Freddy28TM"
git config --global user.email "freddymaina2812@gmail.com"
git config --global init.defaultBranch main
git config --global core.editor "nano"

# Verify
git config --list

---

## Step 11 — Configure GDB (Pwndbg)

echo "source /data/tools/reverse-engineering/pwndbg/gdbinit.py" >> ~/.gdbinit
echo "set disassembly-flavor intel" >> ~/.gdbinit
echo "set pagination off" >> ~/.gdbinit

---

## Step 12 — Download Wordlists

cd /data/wordlists
git clone --depth 1 https://github.com/danielmiessler/SecLists.git

# Verify
du -sh /data/wordlists/SecLists/

---

## Step 13 — Verification Script

Create a script to verify the lab is healthy.

cat > ~/verify-lab.sh << 'VERIFY'
#!/bin/bash

echo "================================"
echo "  LAB VERIFICATION"
echo "================================"
echo ""

echo "[*] Disk Usage:"
df -h / /data
echo ""

echo "[*] Home Symlinks:"
ls -la ~ | grep "\->"
echo ""

echo "[*] Tools Check:"
for tool in nmap httpx nuclei ffuf go python3 git; do
    if which $tool > /dev/null 2>&1; then
        echo "  ✓ $tool"
    else
        echo "  ✗ $tool"
    fi
done
echo ""

echo "[*] Domains:"
ls /data/
echo ""

echo "[*] Elite Platform:"
ls /data/cybersecurity/elite-platform/ | head -10
echo ""

echo "================================"
echo "  VERIFICATION COMPLETE"
echo "================================"
VERIFY

chmod +x ~/verify-lab.sh
echo "Run: ~/verify-lab.sh"

---

## Step 14 — Disaster Recovery Checklist

If laptop fails, here is the recovery order:

| Step | Action | Time |
|------|--------|------|
| 1 | Get new laptop | Varies |
| 2 | Download Parrot OS ISO | 15 min |
| 3 | Create bootable USB | 10 min |
| 4 | Install Parrot OS | 30 min |
| 5 | Create domain folders | 5 min |
| 6 | Create symlinks | 2 min |
| 7 | Clone GitHub repo | 5 min |
| 8 | Install tools | 30 min |
| 9 | Restore from backup | 15 min |
| 10 | Verify | 5 min |

**Total recovery time:** ~2 hours

**Critical:** GitHub backup means code/docs are safe. Only local tools and VMs need reinstall.

---

## What to Back Up Regularly

| Item | Where | Frequency |
|------|-------|-----------|
| Git repos | GitHub | Daily |
| Documents | /data/backups | Weekly |
| VM images | External SSD | Monthly |
| Wordlists | GitHub or /data | Once |
| Config files | Git (.bashrc, .gdbinit) | On change |

---

## Fresh Install Checklist

- [ ] Parrot OS installed
- [ ] /data partition mounted
- [ ] Domain folders created
- [ ] Home symlinks working
- [ ] Elite-platform cloned
- [ ] Git configured
- [ ] Tools installed
- [ ] Wordlists downloaded
- [ ] Verification script passes
- [ ] Backup strategy in place

---

## Notes

- **Test this guide** once before you actually need it
- **Practice recovery** on a VM
- **Keep the ISO** on an external drive
- **Push to GitHub** after every session

**A lab is only as good as your ability to rebuild it.**

**Last Updated:** 2026-10-11
