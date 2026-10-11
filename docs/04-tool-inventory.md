# Tool Inventory — Every Tool Documented

What's installed, what it does, how to use it.

---

## Philosophy

**40 tools across 8 categories.** Master one category at a time.

Each tool has:
- Purpose (what it does)
- Category (where it belongs)
- One example command

---

## Category 1 — Reconnaissance (6 tools)

| Tool | Purpose | Example |
|------|---------|---------|
| subfinder | Subdomain enum | subfinder -d target.com -silent |
| assetfinder | Subdomain enum | assetfinder --subs-only target.com |
| httpx | HTTP probing | cat subs.txt | httpx -silent |
| gau | URL discovery | gau target.com |
| waybackurls | Historical URLs | cat subs.txt | waybackurls |
| amass | Comprehensive enum | amass enum -passive -d target.com |

**When to use:** Before any scan. Recon is 60% of bug bounty.

---

## Category 2 — Scanning (5 tools)

| Tool | Purpose | Example |
|------|---------|---------|
| nmap | Port scanning | nmap -sV -sC -p- 10.10.10.5 |
| nuclei | Vuln scanning | nuclei -u http://target |
| ffuf | Web fuzzing | ffuf -u http://target/FUZZ -w list |
| nikto | Web server scan | nikto -h http://target |
| whatweb | Tech fingerprint | whatweb http://target |

**When to use:** After recon. Scan only live targets.

---

## Category 3 — Exploitation (5 tools)

| Tool | Purpose | Example |
|------|---------|---------|
| msfconsole | Metasploit | msfconsole -q |
| sqlmap | SQL injection | sqlmap -u "http://target?id=1" |
| hydra | Brute force | hydra -l admin -P pass.txt ssh://target |
| searchsploit | Exploit search | searchsploit apache 2.4.49 |
| nc | Reverse shells | nc -lvnp 4444 |

**When to use:** After finding a vulnerability. Exploit responsibly.


---

## Category 4 — Reverse Engineering (5 tools)

| Tool | Purpose | Example |
|------|---------|---------|
| ghidra | Decompiler GUI | ghidra |
| radare2 | CLI analysis | r2 -A binary |
| gdb | Debugger | gdb binary |
| pwndbg | GDB enhancement | Loads via .gdbinit |
| ropper | ROP gadget finder | ropper -f binary |

**When to use:** Analyzing binaries, CTF pwn challenges, malware.

---

## Category 5 — Blue Team / Detection (5 tools)

| Tool | Purpose | Example |
|------|---------|---------|
| Wireshark | Packet analysis | wireshark |
| tcpdump | CLI packet capture | tcpdump -i eth0 -w cap.pcap |
| Zeek | Network monitor | zeek -i eth0 |
| Suricata | IDS/IPS | suricata -i eth0 -c config.yaml |
| Wazuh | HIDS/SIEM | Docker container |

**When to use:** Detection, monitoring, incident response.

---

## Category 6 — Forensics (4 tools)

| Tool | Purpose | Example |
|------|---------|---------|
| Autopsy | Disk forensics GUI | autopsy |
| Volatility | Memory forensics | vol.py -f mem.dump imageinfo |
| exiftool | Metadata analysis | exiftool image.jpg |
| sleuthkit | CLI disk forensics | fls -r disk.img |

**When to use:** After an incident. Preserve, analyze, report.

---

## Category 7 — Utility (5 tools)

| Tool | Purpose | Example |
|------|---------|---------|
| git | Version control | git status |
| docker | Containers | docker ps |
| tmux | Terminal multiplexer | tmux new -s work |
| jq | JSON parser | cat data.json | jq '.name' |
| ssh | Remote access | ssh user@host |

**When to use:** Daily. These are your workhorses.

---

## Category 8 — Language Environments (5 tools)

| Tool | Purpose | Example |
|------|---------|---------|
| python3 | Scripting | python3 script.py |
| go | Go compiler | go build |
| bash | Shell scripting | bash script.sh |
| pip | Python packages | pip install requests |
| venv | Python env | python3 -m venv .venv |

**When to use:** Automation, tool building, custom scripts.


---

## Installation Reference

Where each tool lives on this system.

| Tool | Path | Source |
|------|------|--------|
| nmap | /usr/bin/nmap | apt |
| wireshark | /usr/bin/wireshark | apt |
| burpsuite | /usr/bin/burpsuite | apt |
| msfconsole | /usr/bin/msfconsole | apt |
| ghidra | /usr/bin/ghidra | apt |
| radare2 | /usr/bin/r2 | apt |
| gdb | /usr/bin/gdb | apt |
| subfinder | ~/go/bin/subfinder | go |
| httpx | ~/go/bin/httpx | go |
| nuclei | ~/go/bin/nuclei | go |
| ffuf | /usr/bin/ffuf | apt |
| gau | ~/go/bin/gau | go |
| SecLists | /data/wordlists/SecLists | git |

---

## Common Command Patterns

### Recon Pipeline

subfinder -d target.com -silent | httpx -silent | nuclei -silent

### Web Fuzzing Workflow

ffuf -u http://target/FUZZ -w /data/wordlists/SecLists/Discovery/Web-Content/common.txt

### Port Scan Workflow

nmap -sV -sC -oN scan.txt 10.10.10.5

### Git Daily

cd ~/cybersecurity/elite-platform
git pull
git status
git add .
git commit -m "message"
git push

### Docker Workflow

docker ps
docker run -it image bash
docker stop container

---

## Tool Priority (Learn Order)

### Tier 1 — Learn First (Week 1-4)

| Tool | Why |
|------|-----|
| nmap | Every engagement starts here |
| git | Daily version control |
| bash | Automation foundation |
| python3 | Scripting |

### Tier 2 — Learn Next (Week 5-12)

| Tool | Why |
|------|-----|
| httpx | Recon essential |
| nuclei | Vuln scanning |
| ffuf | Web fuzzing |
| burpsuite | Web testing core |

### Tier 3 — Specialize (Month 4+)

| Tool | Why |
|------|-----|
| ghidra | RE specialization |
| sqlmap | Advanced web |
| Wireshark | Network analysis |
| Volatility | Forensics |

---

## Adding New Tools

When you install a new tool, document it here.

**Template:**

| Tool | Purpose | Example |
|------|---------|---------|
| name | what it does | name --help |

**Then commit:**

git add docs/04-tool-inventory.md
git commit -m "Add [tool] to inventory"
git push

---

## Tool Count Summary

| Category | Count |
|----------|-------|
| Reconnaissance | 6 |
| Scanning | 5 |
| Exploitation | 5 |
| Reverse Engineering | 5 |
| Blue Team | 5 |
| Forensics | 4 |
| Utility | 5 |
| Languages | 5 |
| **Total** | **40** |

---

## Master Rule

**You do not need 400 tools. You need 40 mastered.**

Master each tool in its category. Then, and only then, add more.

---

**Last Updated:** 2026-10-11
