# Elite Cybersecurity Platform

A comprehensive, self-contained cybersecurity lab built on Parrot OS.

**Author:** Freddy28TM
**Platform:** Parrot OS 7.4
**Hardware:** AMD Ryzen 7 PRO 4750U | 14 GB RAM | 476 GB SSD
**Repository:** https://github.com/Freddy28TM/elite-platform

---

## Mission

Professional, self-hosted cybersecurity lab covering:

- **Offensive Security** — Bug bounty, pentesting, red team
- **Defensive Security** — Detection, IR, forensics, blue team
- **Linux Administration** — Systems, networking, automation
- **Specialized Domains** — Cloud, mobile, OSINT, drone, WiFi
- **AI Integration** — Local models for research and automation

Everything runs locally. No cloud dependencies. Full control.

---

## Certification Path

Primary focus: **RHCSA to OSCP**

| Phase | Certification | Focus |
|-------|--------------|-------|
| 1 | RHCSA | Linux administration |
| 2 | OSCP | Offensive security |
| 3 | Specialized | Blue team, cloud, mobile |

Full roadmaps in docs/.

---

## Architecture

Hardware: AMD Ryzen 7 PRO 4750U | 14 GB RAM | 476 GB SSD
Parrot OS: 43 GB (/) - System partition
Data: 425 GB (/data) - All lab work

/data/
- ai/                 AI models, agents, projects
- cybersecurity/      All security work
- development/        Programming projects
- digital-products/   Product development
- research/           Research projects
- archives/           Backups of old work
- wordlists/          SecLists and custom wordlists
- vm-images/          Virtual machines
- evidence/           Bug bounty evidence
- samples/            Malware samples
- backups/            System and project backups

Home (~) contains only symlinks to /data.

---

## Domain Breakdown

| Domain | Purpose | Key Tools |
|--------|---------|-----------|
| Reverse Engineering | Binary analysis, exploit dev | Ghidra, radare2, GDB + Pwndbg |
| Bug Bounty | Web/API/mobile hunting | subfinder, httpx, nuclei, Burp Suite |
| Red Team | Offensive operations | Metasploit, C2, custom tooling |
| Blue Team | Detection, IR, forensics | Zeek, Suricata, Wazuh, Volatility |
| Networking | Protocol, traffic analysis | Wireshark, tcpdump, nmap |
| GRC | ISO 27001, compliance | Templates, documentation |
| Infrastructure | Lab environments | Docker, VM tooling |

---

## Documentation

| File | Purpose |
|------|---------|
| docs/00-architecture.md | Complete lab design |
| docs/01-linux-administrator.md | RHCSA path + essential commands |
| docs/02-blue-team-certs.md | Blue team roadmap |
| docs/03-red-team-certs.md | OSCP and beyond |
| docs/04-tool-inventory.md | Every tool documented |
| docs/05-workflow.md | Daily/weekly usage |
| docs/06-setup-from-scratch.md | Reproduce this lab |
| docs/07-resources.md | Books, courses, labs |
| docs/08-specialized-domains.md | Cloud, Mobile, OSINT, Drone, WiFi, Forensics |

---

## Learning Philosophy

**Essential commands only.**

5-15 essential commands per topic. Master these first.

Example: Linux navigation starts with 5 commands:

| Command | Purpose |
|---------|---------|
| cd | Change directory |
| ls | List files |
| pwd | Show current directory |
| mkdir | Create directory |
| cp | Copy files |

Everything else learned on-demand.

---

## Quick Start

git clone https://github.com/Freddy28TM/elite-platform.git
cd elite-platform
./setup.sh
cat docs/00-architecture.md
cat docs/01-linux-administrator.md

---

## Current Status

| Component | Status |
|-----------|--------|
| Reverse Engineering Lab | Complete (Phase 1) |
| Bug Bounty Platform | Partial (Phase 2) |
| RHCSA Study Path | Documenting |
| OSCP Study Path | Documenting |
| Blue Team Lab | Planned |
| Specialized Domains | Planned |

---

## Requirements

- OS: Parrot OS 7.4 or Debian 13+
- RAM: 8 GB minimum, 16 GB recommended
- Storage: 100 GB minimum, 400 GB+ recommended
- Docker: For containerized labs
- Python 3.13+: For automation

---

## License

MIT - See LICENSE

---

## Roadmap

Short-term (this month):
- Complete RHCSA study materials
- Complete RHCSA study materials
- Set up multi-agent AI lab

Mid-term (3 months):
- Achieve RHCSA certification
- Build bug bounty automation pipeline
- Document blue team lab

Long-term (12 months):
- Achieve OSCP certification
- Complete specialized domain labs
- Contribute tooling back to community

---

Built with focus. No overwhelm. One command at a time.
