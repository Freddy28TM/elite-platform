# Lab Architecture — Complete Design

The blueprint of the Elite Cybersecurity Platform.

**Author:** Freddy28TM
**Last Updated:** 2026-10-11

---

## Hardware

| Component | Spec |
|-----------|------|
| CPU | AMD Ryzen 7 PRO 4750U (8 cores, 16 threads) |
| RAM | 14 GB DDR4 |
| Storage | 476 GB NVMe SSD |
| GPU | AMD Radeon Vega (integrated) |
| Network | WiFi (wlp1s0) |

**Verdict:** Capable of running VMs, Docker, and local AI.

---

## Storage Layout

| Partition | Size | Mount | Purpose |
|-----------|------|-------|---------|
| nvme0n1p5 | 43 GB | / | Parrot OS system |
| nvme0n1p2 | 425 GB | /data | All lab work |

**Rule:** Nothing heavy goes on /. Everything goes on /data.


---

## Directory Structure

### /data/ (All Work)

| Folder | Purpose |
|--------|---------|
| cybersecurity/ | All security work |
| development/ | Programming projects |
| digital-products/ | Product development |
| research/ | Research projects |
| archives/ | Old audits and backups |
| wordlists/ | SecLists, custom wordlists |
| vm-images/ | Virtual machine images |
| evidence/ | Bug bounty evidence |
| samples/ | Malware, test binaries |
| backups/ | System and project backups |

### /data/cybersecurity/elite-platform/

| Folder | Purpose |
|--------|---------|
| reverse-engineering/ | Binary analysis lab |
| bug-bounty/ | Bug bounty tooling |
| blue-team/ | Detection, IR, forensics |
| red-team/ | Offensive operations |
| networking/ | Protocol analysis |
| forensics/ | Digital forensics |
| infrastructure/ | Lab infrastructure |
| grc/ | Compliance templates |
| docs/ | Documentation |
| scripts/ | Automation |
| tools/ | External tools |
| templates/ | Report templates |
| configs/ | Configuration files |
| logs/ | Activity logs |


---

## Symlink Strategy

Home directory (~) is clean. Only symlinks.

| Symlink in ~ | Points to |
|-------------|-----------|
| ai | /data/ai |
| cybersecurity | /data/cybersecurity |
| development | /data/development |
| Digital-Products | /data/digital-products |
| research | /data/research |
| wordlists | /data/wordlists |
| vm-images | /data/vm-images |
| evidence | /data/evidence |
| samples | /data/samples |
| backups | /data/backups |
| tools | /data/tools |
| projects | /data/projects |

**Why this matters:**
- Navigation is intuitive: `cd ~/cybersecurity`
- Storage is on /data (large partition)
- System stays clean (43 GB is enough for OS)

---

## Network Architecture

### Physical

| Interface | Type | IP |
|-----------|------|-----|
| wlp1s0 | WiFi | 192.168.100.x |
| eth0 | Ethernet | When connected |

### Docker Networks (Planned)

| Network | Purpose | Subnet |
|---------|---------|--------|
| lab-attack | Attack simulation | 172.20.0.0/24 |
| lab-defense | Defense targets | 172.21.0.0/24 |
| lab-dmz | DMZ services | 172.22.0.0/24 |

### VM Network Plan

| VM | RAM | Disk | Purpose |
|----|-----|------|---------|
| Kali | 4 GB | 40 GB | Attack VM |
| Ubuntu-Server | 2 GB | 20 GB | Target |
| Windows-10 | 4 GB | 40 GB | Target |
| CentOS-Stream | 2 GB | 20 GB | RHCSA practice |
| Windows-Server | 4 GB | 50 GB | AD lab |


---

## Virtual Machines

### Purpose

Simulate real-world scenarios without physical hardware.

### Recommended VMs

| VM | Purpose | Priority |
|----|---------|----------|
| Kali Linux | Offensive testing | High |
| Ubuntu Server | Practice target | High |
| Windows 10 | Client attacks | High |
| CentOS Stream 9 | RHCSA practice | High |
| Metasploitable | Vulnerable target | Medium |
| Windows Server | AD + blue team | Medium |
| DVWA | Web app testing | Medium |
| OWASP Juice Shop | Modern web target | Medium |

### Storage

All VMs live in /data/vm-images/ (symlinked from ~/vm-images).

### Hypervisor Options

| Hypervisor | Pros | Cons |
|-----------|------|------|
| VirtualBox | Easy, GUI | Slower |
| KVM/QEMU | Fast, native | CLI only |
| VMware | Stable | Licensing |

**Recommendation:** KVM for speed, VirtualBox for convenience.

---

## Docker Containers

### Purpose

Lightweight services for learning and testing.

### Recommended Containers

| Container | Purpose | Command |
|-----------|---------|---------|
| Wazuh | SIEM + HIDS | docker run -d wazuh/wazuh-manager |
| Zeek | Network analysis | docker run -d zeek/zeek |
| Suricata | IDS | docker run -d jasonish/suricata |
| DVWA | Web target | docker run -d vulnerables/web-dvwa |
| Juice Shop | Modern target | docker run -d bkimminich/juice-shop |
| Portainer | Docker GUI | docker run -d portainer/portainer-ce |

### Storage

Docker data lives in /var/lib/docker by default.

**Recommendation:** Move Docker data to /data if it grows beyond 20 GB.

---

## Backup Strategy

### What to Backup

| Data | Frequency | Method |
|------|-----------|--------|
| Git repos | Daily | Push to GitHub |
| Documents | Weekly | tar to /data/backups |
| VM images | Monthly | rsync to external |
| Wordlists | Once | Already in /data |
| Configs | On change | git |

### Backup Locations

| Location | Purpose |
|----------|---------|
| /data/backups/ | Local backups |
| GitHub | Code and docs |
| External USB | VM images (when available) |

### Critical Rule

**Nothing unique lives on /. If / dies, only the OS is lost.**


---

## Access Patterns

### Daily Workflow

cd ~/cybersecurity/elite-platform/
git pull
# Work here
git add .
git commit -m "Daily work"
git push

### New Project

mkdir /data/cybersecurity/projects/new-project
cd /data/cybersecurity/projects/new-project
# Work here

### Working with VMs

cd ~/vm-images
# Manage VMs with KVM or VirtualBox

### Working with Docker

docker ps
docker exec -it <container> bash

---

## Growth Plan

### Phase 1 (Current) - Foundation

- Storage organized
- Reverse engineering lab (done)
- Bug bounty tools (partial)
- Documentation (in progress)

### Phase 2 - Expand Services

- Deploy Wazuh SIEM
- Deploy Zeek + Suricata
- Set up VM networks
- Complete documentation

### Phase 3 - Specialize

- Active Directory lab
- Cloud lab (AWS/Azure free tier)
- Mobile lab (Android/iOS)
- OSINT infrastructure
- WiFi hardware setup
- Drone lab setup

### Phase 4 - Automate

- CI/CD for tooling
- Automated recon
- Custom tooling

### Phase 5 - Scale

- Network hardware (routers, switches)
- Physical lab expansion
- Community contributions

---

## Lab Rules

1. **Nothing heavy on /** - Always use /data
2. **Symlink, do not move** - Home stays clean
3. **Commit daily** - GitHub is your backup
4. **Document as you learn** - Future you will thank you
5. **Practice, do not just read** - Commands in muscle memory
6. **One command at a time** - Master, then move on
7. **No overwhelm** - Essential tools only

---

## System Map

Hardware (Ryzen 7 PRO, 14 GB, 476 GB NVMe)
    |
Parrot OS 7.4
    |
+-----------+--------------+
|           |              |
/ (43 GB)   /data (425 GB) |
|           |              |
System      All work       |
            |              |
+-----------+--------------+
            |
    +-------+-------+-------+-------+
    |       |       |       |       |
    ai   cybersecurity development research archives
    |       |
    |       +-- elite-platform
    |           |
    |           +-- reverse-engineering
    |           +-- bug-bounty
    |           +-- red-team
    |           +-- blue-team
    |           +-- forensics
    |           +-- docs
    |           +-- tools
    |
    +-- models
    +-- agents
    +-- projects
    +-- scripts

---

## Future Additions

| Feature | Purpose | Timeline |
|---------|---------|----------|
| External SSD | More VM storage | When needed |
| Raspberry Pi cluster | Network lab | When ready |
| Cloud lab (AWS) | Cloud security | After OSCP |
| SDR (Software Defined Radio) | WiFi/drone lab | When ready |
| WiFi adapter (monitor mode) | WiFi pentesting | When ready |

---

## Quick Reference

| Task | Command |
|------|---------|
| Navigate to security | cd ~/cybersecurity |
| Check disk | df -h |
| Check space | du -sh /data/* |
| Docker status | docker ps |
| Git status | cd ~/cybersecurity/elite-platform && git status |

---

**The architecture is the foundation. Everything else is built on top.**

**Last Updated:** 2026-10-11
