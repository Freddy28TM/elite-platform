# Specialized Domains — Deep Dive

Advanced domains beyond core Red/Blue team.

**Domains covered:**
- Cloud Security
- Mobile Security
- OSINT
- Drone Security
- WiFi Security
- Digital Forensics

Each domain: 3-5 essential tools, 1 certification target, hands-on practice.

---

## Domain 1 — Cloud Security

### Overview

Cloud is where modern infrastructure lives. AWS, Azure, and GCP dominate. Learn to attack and defend cloud environments.

### Essential Tools (5)

| Tool | Purpose | Example |
|------|---------|---------|
| aws-cli | AWS management | aws s3 ls |
| az-cli | Azure management | az vm list |
| ScoutSuite | Cloud audit | scoutsuite --provider aws |
| Prowler | AWS security | prowler aws |
| Pacu | AWS exploitation | pacu |

### Certification Target

| Cert | Provider | Cost | Focus |
|------|----------|------|-------|
| AWS SAA | AWS | $150 | Solutions architect |
| AWS Security Specialty | AWS | $300 | Security |
| CCSP | ISC2 | $600 | Cloud security |

**Recommended:** AWS SAA first, then Security Specialty.

### Practice

| Resource | Cost | Notes |
|----------|------|-------|
| AWS Free Tier | Free | 12 months |
| CloudGoat | Free | AWS pentesting lab |
| flaws.cloud | Free | AWS CTF |
| Cloud Security Labs | Paid | Structured |

### Study Path

Month 1: AWS fundamentals + SAA study
Month 2: AWS Security Specialty
Month 3: Cloud pentesting (Pacu, CloudGoat)
Month 4: Multi-cloud (Azure, GCP)

### In This Lab

- Store cloud configs in `/data/cybersecurity/cloud/`
- Use Docker for local cloud emulation (LocalStack)
- Save screenshots to `/data/evidence/cloud/`


---

## Domain 2 — Web Application Security

### Overview

Web apps are the #1 attack surface. Almost every bug bounty involves web apps. This domain covers attacking and defending websites, APIs, and web services.

### Essential Tools (6)

| Tool | Purpose | Example |
|------|---------|---------|
| Burp Suite | Web proxy | Launch GUI |
| ffuf | Fuzzing | ffuf -u http://target/FUZZ -w wordlist |
| nuclei | Vuln scanning | nuclei -u http://target |
| sqlmap | SQL injection | sqlmap -u "http://target?id=1" |
| WPScan | WordPress audit | wpscan --url http://target |
| Postman | API testing | Launch GUI |

### Vulnerability Classes (OWASP Top 10)

| # | Vulnerability | Tool |
|---|--------------|------|
| 1 | Broken Access Control | Burp Repeater |
| 2 | Cryptographic Failures | curl + openssl |
| 3 | Injection (SQL, NoSQL, OS) | sqlmap, Burp |
| 4 | Insecure Design | Manual review |
| 5 | Security Misconfiguration | nuclei |
| 6 | Vulnerable Components | Retire.js, nuclei |
| 7 | Auth Failures | Burp + hydra |
| 8 | Data Integrity Failures | Manual review |
| 9 | Logging Failures | Manual review |
| 10 | SSRF | Burp Collaborator |

### Certification Target

| Cert | Provider | Cost | Focus |
|------|----------|------|-------|
| OSWE | OffSec | $1599 | Web exploitation |
| Burp Suite Certified | PortSwigger | $99 | Web attacks |
| eWPTX | eLearnSecurity | ~$400 | Web pentesting |

**Recommended:** Burp Suite Certified first (cheap, practical).

### Practice

| Resource | Cost | Notes |
|----------|------|-------|
| PortSwigger Web Security Academy | Free | Best free resource |
| OWASP Juice Shop | Free | Modern vulnerable app |
| DVWA | Free | Classic target |
| HackTheBox Web challenges | Free + Paid | Real challenges |
| PentesterLab | Paid | Structured course |

### Study Path

Month 1: OWASP Top 10 theory + PortSwigger labs
Month 2: Burp Suite Certified prep
Month 3: API testing + GraphQL
Month 4: Advanced (SSRF, deserialization)

### In This Lab

- Store web findings in `/data/cybersecurity/bug-bounty/findings/`
- Run Juice Shop in Docker: `docker run -d -p 3000:3000 bkimminich/juice-shop`
- Run DVWA in Docker: `docker run -d -p 8080:80 vulnerables/web-dvwa`
- Save evidence to `/data/evidence/web/`


---

## Domain 3 — Mobile Application Security

### Overview

Mobile apps handle banking, health, and personal data. They are rich targets. This domain covers Android and iOS application testing.

### Essential Tools (5)

| Tool | Purpose | Example |
|------|---------|---------|
| jadx | APK decompiler | jadx-gui app.apk |
| apktool | APK analysis | apktool d app.apk |
| Frida | Dynamic instrumentation | frida -U -f com.app |
| Objection | Mobile runtime | objection -g com.app explore |
| MobSF | Mobile security | docker run -it mobsf/mobsf |

### Vulnerability Classes (OWASP Mobile Top 10)

| # | Vulnerability | Tool |
|---|--------------|------|
| 1 | Improper Credential Usage | jadx + grep |
| 2 | Inadequate Supply Chain Security | apktool |
| 3 | Insecure Authentication | Frida |
| 4 | Insufficient Input Validation | Manual + Frida |
| 5 | Insecure Communication | Burp + mitmproxy |
| 6 | Inadequate Privacy Controls | jadx |
| 7 | Insufficient Binary Protections | radare2 |
| 8 | Security Misconfiguration | MobSF |
| 9 | Insecure Data Storage | adb + grep |
| 10 | Insufficient Cryptography | jadx + Frida |

### Certification Target

| Cert | Provider | Cost | Focus |
|------|----------|------|-------|
| eMAPT | INE | ~$400 | Mobile pentesting |
| GMOB | GIAC | ~$2500 | Mobile security |

**Recommended:** eMAPT first (practical, affordable).

### Practice

| Resource | Cost | Notes |
|----------|------|-------|
| OWASP MASTG | Free | Comprehensive guide |
| InsecureBankv2 | Free | Vulnerable Android app |
| DVIA-v2 | Free | Vulnerable iOS app |
| Android Security Cookbook | Paid | Advanced |

### Setup

| Requirement | How |
|-------------|-----|
| Android emulator | Android Studio or Genymotion |
| Rooted device | Physical or emulator |
| Frida server | Install on device |
| Burp cert | Install on device |

### Study Path

Month 1: Android fundamentals + jadx
Month 2: Dynamic analysis with Frida
Month 3: iOS basics + eMAPT prep
Month 4: Real bug bounty on mobile apps

### In This Lab

- Store APKs in `/data/samples/mobile/`
- Use Genymotion or AVD for emulation
- Frida scripts in `/data/cybersecurity/mobile/scripts/`
- Findings in `/data/cybersecurity/bug-bounty/findings/mobile/`

---

## Domain 4 — OSINT (Open Source Intelligence)

### Overview

OSINT is intelligence from public sources. Critical for red team recon, threat intelligence, and bug bounty.

### Essential Tools (5)

| Tool | Purpose | Example |
|------|---------|---------|
| theHarvester | Email/subdomain | theHarvester -d target.com -b all |
| Sherlock | Username search | sherlock username |
| Maltego | Link analysis | Launch GUI |
| Shodan | Internet scan | shodan search apache |
| Recon-ng | Recon framework | recon-ng |

### Categories

| Category | Purpose | Tools |
|----------|---------|-------|
| People search | Find individuals | Sherlock, Pipl |
| Domain intelligence | Subdomains, DNS | theHarvester, Amass |
| Infrastructure | IPs, services | Shodan, Censys |
| Social media | Profiles, posts | Twitter API, Instagram |
| Documents | Metadata | exiftool, FOCA |
| Dark web | Threat intel | Tor, Ahmia |

### Certification Target

| Cert | Provider | Cost | Focus |
|------|----------|------|-------|
| OSINT Foundation | McAfee Institute | ~$300 | Basic OSINT |
| Certified OSINT Analyst | SANS SEC497 | ~$8000 | Advanced |
| TCM OSINT Fundamentals | TCM Security | ~$30 | Beginner |

**Recommended:** TCM OSINT Fundamentals (cheap, practical).

### Practice

| Resource | Cost | Notes |
|----------|------|-------|
| OSINT Exercises | Free | self-paced |
| Trace Labs CTF | Free | Real OSINT |
| Bellingcat guides | Free | Best tutorials |
| OSINT Dojo | Free | Structured |

### Study Path

Month 1: OSINT fundamentals + Sherlock
Month 2: Domain/intel gathering
Month 3: Social media investigation
Month 4: Advanced (dark web, blockchain)

### In This Lab

- Store investigations in `/data/cybersecurity/osint/cases/`
- Use Maltego Community Edition
- Save screenshots to `/data/evidence/osint/`
- Document IOCs in `/data/cybersecurity/osint/iocs/`


---

## Domain 5 — Drone Security

### Overview

Drones use WiFi, RF, and GPS. They are attackable and can be used as attack platforms. This domain covers drone hacking and counter-drone operations.

### Essential Tools (4)

| Tool | Purpose | Example |
|------|---------|---------|
| HackRF | SDR (Software Defined Radio) | hackrf_info |
| RTL-SDR | RF receiver | rtl_fm -f 433M |
| Wireshark | Drone telemetry | Capture wireless packets |
| Airodump-ng | WiFi drone recon | airodump-ng wlan0mon |

### Attack Vectors

| Vector | Target | Tool |
|--------|--------|------|
| WiFi hijack | Consumer drones | Aircrack-ng |
| RF replay | Fixed-frequency drones | HackRF |
| GPS spoofing | GPS-guided drones | HackRF + GPS simulator |
| Telemetry interception | DJI, Parrot | Wireshark + Wireshark dissectors |
| Firmware analysis | Drone firmware | binwalk, Ghidra |

### Hardware Needed

| Item | Cost | Purpose |
|------|------|---------|
| RTL-SDR | ~$30 | Basic RF receive |
| HackRF One | ~$350 | Full RF transmit/receive |
| WiFi adapter (monitor mode) | ~$30 | WiFi attacks |
| GPS simulator | ~$200 | GPS spoofing |

**Total entry cost:** ~$60 (RTL-SDR + WiFi adapter)

### Legal Notes

- **Never** attack drones you don't own
- Drones are aircraft - attacks may violate aviation law
- Use SDR in shielded environment or with FCC license
- Research legally via CTF or your own equipment

### Practice

| Resource | Cost | Notes |
|----------|------|-------|
| Own a drone | $50+ | Cheapest: toy drone |
| SDR tutorials (YouTube) | Free | Michael Ossmann |
| Hak5 videos | Free | Drone hacking |
| DEF CON drone talks | Free | YouTube |

### Study Path

Month 1: RF fundamentals + RTL-SDR
Month 2: WiFi + drone protocols
Month 3: SDR with HackRF
Month 4: Counter-drone techniques

### In This Lab

- Store SDR captures in `/data/cybersecurity/drone/captures/`
- Document findings in `/data/cybersecurity/drone/`
- Hardware lives outside the laptop (USB-connected)

---

## Domain 6 — WiFi Security

### Overview

WiFi is everywhere. It is a primary attack vector for red team and a common blue team concern. This domain covers WiFi auditing and hacking.

### Essential Tools (5)

| Tool | Purpose | Example |
|------|---------|---------|
| aircrack-ng | WiFi cracking | aircrack-ng capture.cap |
| airodump-ng | WiFi recon | airodump-ng wlan0mon |
| aireplay-ng | Injection | aireplay-ng --deauth 10 wlan0mon |
| wifite | Automated WiFi | wifite |
| hashcat | Hash cracking | hashcat -m 22000 hash.hc22000 wordlist |

### Attack Types

| Attack | Target | Defense |
|--------|--------|---------|
| WEP cracking | Old WiFi | Use WPA3 |
| WPA/WPA2 handshake capture | Modern WiFi | Strong passphrase |
| WPA3 Dragonblood | Newer WiFi | Patch firmware |
| Evil Twin | Users | Certificate validation |
| Deauth attack | Availability | 802.11w (PMF) |
| PMKID attack | WPA2 | WPA3 or long passphrase |

### Hardware Requirements

| Item | Cost | Purpose |
|------|------|---------|
| WiFi adapter (monitor + injection) | ~$30 | Required for attacks |
| Recommended: Alfa AWUS036ACH | ~$60 | Best for Linux |
| Recommended: TP-Link TL-WN722N (v1) | ~$15 | Cheap option |

**Note:** Your laptop's built-in WiFi (wlp1s0) likely does NOT support monitor mode. External adapter required.

### Certification Target

| Cert | Provider | Cost | Focus |
|------|----------|------|-------|
| OSWP | OffSec | $450 | WiFi pentesting |
| CWSP | CWNP | ~$400 | Wireless professional |

**Recommended:** OSWP (practical, respected).

### Practice

| Resource | Cost | Notes |
|----------|------|-------|
| Own WiFi network | Free | Best practice |
| WiFi CTF challenges | Free | Online |
| Hashcat example hashes | Free | Offline practice |
| Hak5 WiFi toolkit | Paid | Professional |

### Study Path

Month 1: WiFi theory + monitor mode
Month 2: WPA/WPA2 cracking
Month 3: Enterprise WiFi (WPA-Enterprise)
Month 4: OSWP exam prep

### In This Lab

- Store captures in `/data/cybersecurity/wifi/captures/`
- Wordlists in `/data/wordlists/wifi/`
- Save cracked hashes in `/data/cybersecurity/wifi/cracked/`


---

## Domain 7 — Digital Forensics

### Overview

Forensics is the investigation of digital evidence. Used in incident response, law enforcement, and corporate investigations.

### Essential Tools (5)

| Tool | Purpose | Example |
|------|---------|---------|
| Autopsy | Disk forensics | Launch GUI |
| Volatility | Memory forensics | vol.py -f mem.dump imageinfo |
| FTK Imager | Disk imaging | Launch GUI |
| exiftool | Metadata analysis | exiftool image.jpg |
| Sleuth Kit | CLI forensics | fls -r disk.img |

### Forensic Categories

| Category | Purpose | Tool |
|----------|---------|------|
| Disk forensics | File system analysis | Autopsy, TSK |
| Memory forensics | RAM analysis | Volatility, Rekall |
| Network forensics | Traffic analysis | Wireshark, NetworkMiner |
| Mobile forensics | Phone analysis | Cellebrite, Autopsy |
| Cloud forensics | Cloud logs | AWS CloudTrail |

### Certification Target

| Cert | Provider | Cost | Focus |
|------|----------|------|-------|
| GCFA | GIAC | ~$2500 | Advanced forensics |
| GCFE | GIAC | ~$2500 | Windows forensics |
| CHFI | EC-Council | ~$500 | Computer hacking forensic investigator |
| CCFP | IACRB | ~$400 | Cyber forensics professional |

**Recommended:** CHFI (affordable) or GCFA (premium).

### Practice

| Resource | Cost | Notes |
|----------|------|-------|
| CyberDefenders | Free | Real forensic challenges |
| DFIR.training | Free | Dataset collection |
| Volatility Labs | Free | Memory forensics |
| SANS DFIR Challenges | Free | Realistic scenarios |

### Study Path

Month 1: File system forensics
Month 2: Memory forensics with Volatility
Month 3: Network forensics
Month 4: Mobile + cloud forensics

### In This Lab

- Store cases in `/data/cybersecurity/forensics/cases/`
- Memory dumps in `/data/samples/memory/`
- Evidence in `/data/evidence/forensics/`
- Document chain of custody for each case

---

## Summary Table

| Domain | Tools | Cert Target | Cost | Priority |
|--------|-------|-------------|------|----------|
| Cloud Security | 5 | AWS SAA | $150 | High |
| Web App Security | 6 | Burp Certified | $99 | High |
| Mobile Security | 5 | eMAPT | $400 | Medium |
| OSINT | 5 | TCM OSINT | $30 | High |
| Drone Security | 4 | None | $60 (hardware) | Low |
| WiFi Security | 5 | OSWP | $450 | Medium |
| Digital Forensics | 5 | CHFI / GCFA | $400-$2500 | High |
| **TOTAL** | **35** | **7 certs** | **~$1600** | |

---

## Recommended Learning Order

1. **Linux fundamentals** (RHCSA) - baseline
2. **Networking** - build on RHCSA
3. **Web App Security** - most bug bounty work
4. **OSINT** - recon foundation
5. **Cloud Security** - modern infrastructure
6. **Digital Forensics** - blue team skills
7. **WiFi Security** - physical attacks
8. **Mobile Security** - advanced apps
9. **Drone Security** - niche hardware

---

## Hardware Shopping List

| Item | Cost | Priority |
|------|------|----------|
| WiFi adapter (monitor mode) | ~$30 | High |
| RTL-SDR | ~$30 | Medium |
| External SSD (1 TB) | ~$80 | High |
| USB drive (64 GB) | ~$15 | High |
| External GPU | ~$200 | Low (AI) |
| HackRF One | ~$350 | Low (SDR) |

**Total minimum:** ~$75 (WiFi adapter + USB + SSD)

---

## Final Notes

Each domain follows the same philosophy:
- 3-6 essential tools
- 1 certification target
- 4-month study path
- Hands-on practice in this lab

**No overwhelm. One domain at a time. Master before moving on.**

**Last Updated:** 2026-10-11
