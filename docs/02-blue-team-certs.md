# Blue Team Certifications — Defender Essentials

Focused guide for defensive security and incident response.

**Target:** Security Blue Team Level 1 (BTL1) → CySA+ → GCIH → GCIA
**Prerequisites:** Networking, Linux/Windows fundamentals

---

## Learning Philosophy

Master **~40 essential tools and concepts**.

Blue team is about detection, response, and defense. This guide shows the minimum toolkit.

---

## Certification Path

| Cert | Focus | Cost | Difficulty |
|------|-------|------|-----------|
| BTL1 | Entry-level blue team | ~$400 | Easy-Medium |
| CySA+ | Analyst | ~$400 | Medium |
| GCIH | Incident handler | ~$2500 | Hard |
| GCIA | Intrusion analyst | ~$2500 | Hard |

**Recommended order:** BTL1 → CySA+ → GCIH → GCIA

---

## Phase 1 — Log Analysis

**Essential tools: 4**

| Tool | Purpose | Example |
|------|---------|---------|
| grep | Search logs | grep "Failed" /var/log/auth.log |
| awk | Parse fields | awk '{print $1, $5}' access.log |
| journalctl | System logs | journalctl -u ssh --since "1 hour ago" |
| jq | Parse JSON logs | jq '.event' app.json |

**Practice:** Analyze 5 days of auth.log and find failed login patterns.

---

## Phase 2 — Network Monitoring

**Essential tools: 4**

| Tool | Purpose | Example |
|------|---------|---------|
| tcpdump | Capture packets | tcpdump -i eth0 -w capture.pcap |
| Wireshark | Analyze packets | Launch GUI |
| Zeek | Network analysis | zeek -i eth0 -C local |
| Suricata | IDS/IPS | suricata -i eth0 -c config.yaml |

**Practice:** Capture traffic, analyze for suspicious patterns.

---

## Phase 3 — Endpoint Detection

**Essential tools: 4**

| Tool | Purpose | Example |
|------|---------|---------|
| Wazuh | Host-based IDS | Docker: wazuh/wazuh-manager |
| auditd | Linux auditing | sudo systemctl start auditd |
| Sysmon | Windows monitoring | Install on Windows |
| osquery | SQL for OS | osqueryi "SELECT * FROM processes;" |

**Practice:** Deploy Wazuh in Docker, monitor a Linux VM.

---

## Phase 4 — Threat Hunting

**Essential tools: 4**

| Tool | Purpose | Example |
|------|---------|---------|
| Sigma | Detection rules | sigmac -t splunk rule.yml |
| YARA | Malware detection | yara rules.yar file.exe |
| Velociraptor | Endpoint visibility | Launch GUI |
| KAPE | Forensic triage | Launch GUI |

**Practice:** Write 5 Sigma rules for common attacks.

---

## Phase 5 — Incident Response

**6-Phase Process:**

| Phase | Purpose |
|-------|---------|
| 1. Preparation | Tools ready, playbooks written |
| 2. Identification | Detect the incident |
| 3. Containment | Stop the spread |
| 4. Eradication | Remove the threat |
| 5. Recovery | Restore systems |
| 6. Lessons Learned | Document and improve |

**Essential tools: 3**

| Tool | Purpose |
|------|---------|
| TheHive | Case management |
| MISP | Threat intelligence |
| RTIR | Request Tracker for IR |

**Practice:** Write an IR playbook for ransomware.

---

## Phase 6 — Forensics

**Memory forensics: 3 tools**

| Tool | Purpose | Example |
|------|---------|---------|
| Volatility | Memory analysis | vol.py -f mem.dump imageinfo |
| Rekall | Memory analysis | rekall -f mem.dump pslist |
| LiME | Linux memory capture | insmod lime.ko |

**Disk forensics: 3 tools**

| Tool | Purpose | Example |
|------|---------|---------|
| Autopsy | Disk analysis | Launch GUI |
| Sleuth Kit | CLI forensics | fls -r disk.img |
| TestDisk | Recovery | testdisk disk.img |

**Practice:** Analyze a memory dump from a Windows VM.

---

## Phase 7 — Detection Engineering

**Essential concepts:**

| Concept | Purpose |
|---------|---------|
| MITRE ATT&CK | Adversary tactics framework |
| Kill Chain | Attack phases |
| Pyramid of Pain | Indicators of compromise |
| IOC | Indicators of Compromise |

**Essential tools: 3**

| Tool | Purpose |
|------|---------|
| Sigma | Rule format |
| ATT&CK Navigator | Visualize coverage |
| Atomic Red Team | Test detections |

**Practice:** Map 10 detections to ATT&CK techniques.

---


---

## Phase 8 — TLS and Certificate Analysis

**Essential tools: 4**

| Tool | Purpose | Example |
|------|---------|---------|
| openssl | TLS inspection | openssl s_client -connect target:443 |
| sslyze | TLS scanner | sslyze target.com |
| testssl.sh | TLS tester | testssl.sh target.com |
| nmap ssl-enum-ciphers | TLS scan | nmap --script ssl-enum-ciphers -p 443 target |

**When to use:**
- Auditing web servers
- Detecting weak TLS versions
- Checking certificate validity
- Analyzing cipher suites

### Weak TLS Configurations to Flag

| Configuration | Risk |
|--------------|------|
| SSLv2, SSLv3 | Critical — broken |
| TLS 1.0, 1.1 | High — deprecated |
| RC4 cipher | High — broken |
| NULL cipher | Critical |
| Self-signed cert | Medium |
| Expired cert | High |
| Weak key (<2048-bit RSA) | High |
| SHA-1 signature | High — deprecated |

### Certificate Inspection Commands

| Command | Purpose |
|---------|---------|
| openssl s_client -connect host:443 -showcerts | View full chain |
| openssl x509 -in cert.pem -text -noout | Read certificate |
| openssl s_client -connect host:443 -tls1_2 | Force TLS 1.2 |

**Practice:**
Run testssl.sh against a known server. Identify weak ciphers. Check certificate chain validity. Document findings.

## Essential Commands Cheat Sheet

**Log analysis:**
- grep "Failed password" /var/log/auth.log
- awk -F: '{print $1}' /etc/passwd
- tail -f /var/log/syslog
- journalctl --since today

**Process analysis:**
- ps aux --sort=-%cpu
- lsof -p PID
- ss -tlnp
- netstat -antp

**File analysis:**
- file suspicious.exe
- strings suspicious.exe | head
- sha256sum suspicious.exe
- exiftool image.jpg

---

## 6-Month Study Plan

| Month | Focus | Deliverable |
|-------|-------|-------------|
| 1 | Networking + Linux logs | BTL1 prep |
| 2 | BTL1 certification | Pass BTL1 |
| 3 | Windows + Sysmon | CySA+ prep |
| 4 | Threat hunting | CySA+ cert |
| 5 | IR + Forensics | GCIH prep |
| 6 | GCIH exam | Pass GCIH |

---

## Practice Platforms

| Platform | Cost | Best For |
|----------|------|----------|
| Blue Team Labs Online | Free + Paid | BTL1 prep |
| CyberDefenders | Free | Real-world challenges |
| LetsDefend | Free + Paid | SOC simulation |
| TryHackMe | Free + Paid | Blue team rooms |
| HTB Academy | Paid | Structured courses |

**Recommendation:** Complete 30 BTL1 challenges + 20 CyberDefenders challenges before cert exams.

---

## Study Resources

| Resource | Cost | Notes |
|----------|------|-------|
| "Blue Team Handbook" (Don Murdoch) | Paid | Foundational |
| "Incident Response & Computer Forensics" | Paid | IR bible |
| "The Practice of Network Security Monitoring" | Paid | NSM guide |
| SANS Reading Room | Free | Papers |
| DFIR Diva blog | Free | Tutorials |
| SANS Blue Team Summit | Free | Talks |

---

## Integration with Elite Platform

All blue team practice happens in this lab:

- Store IR cases in /data/cybersecurity/blue-team/cases/
- Save Sigma rules in /data/cybersecurity/blue-team/sigma/
- Use /data/vm-images/ for victim VMs
- Deploy Wazuh via Docker
- Commit detections to elite-platform repo

---

## Progress Tracker

| Skill | Completed | Date |
|-------|-----------|------|
| Log analysis | [ ] 10 challenges | |
| Network monitoring | [ ] 10 challenges | |
| Endpoint detection | [ ] 10 challenges | |
| Threat hunting | [ ] 10 challenges | |
| Incident response | [ ] 5 scenarios | |
| Forensics | [ ] 5 scenarios | |
| Detection engineering | [ ] 20 rules | |

---

## Beyond BTL1/CySA+

Once core certs are done:

| Cert | Focus | Timeline |
|------|-------|----------|
| GCIH | Advanced IR | 6 months |
| GCFA | Forensics | 6 months |
| GCIA | Intrusion analysis | 6 months |
| GNFA | Network forensics | 6 months |

---

**40 tools. 6 months. Defend the enterprise. Start now.**
