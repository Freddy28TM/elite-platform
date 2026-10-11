# Lesson 01 — Final Review

**Completed:** 2026-10-11
**Total Parts:** 8/8
**Status:** ✅ COMPLETE

---

## What You Learned

### Part 1 — System Identification

| Command | Purpose |
|---------|---------|
| whoami | Current user |
| pwd | Current directory |
| hostname | Machine name |
| cat /etc/os-release | Distribution |
| uname -r | Kernel release |
| uname -a | All system info |
| uname -m | Architecture |

### Part 2 — Filesystem Exploration

| Directory | Purpose |
|-----------|---------|
| / | Filesystem root |
| /etc | Config files |
| /home | User homes |
| /var | Variable data |
| /tmp | Temporary (sticky bit) |
| /proc | Process info |
| /sys | Device info |

### Part 3 — Users & Groups

| Command | Purpose |
|---------|---------|
| id | UID, GID, groups |
| useradd | Create user |
| usermod | Modify user |
| passwd | Set/lock password |
| groups | Show membership |

### Part 4 — Processes

| Command | Purpose |
|---------|---------|
| ps aux | List processes |
| top | Live view |
| pgrep | Find PID |
| systemctl | Manage services |
| journalctl | View logs |

### Part 5 — Security Observations

| Observation | Command |
|-------------|---------|
| Shadow protection | ls -la /etc/shadow |
| Sticky bit | ls -ld /tmp |
| SUID files | find -perm -4000 |
| Listening services | ss -tlnp |

### Part 6 — Permissions

| Command | Purpose |
|---------|---------|
| chmod | Change permissions |
| chown | Change owner |
| chgrp | Change group |

### Part 7 — Verification

All 6 skill areas verified.

---

## Scripts Built

| Script | Purpose |
|--------|---------|
| system-report.sh | System identification |
| filesystem-tour.sh | Filesystem overview |
| user-info.sh | User and group info |
| rhcsa-users-lab.sh | Full users lab |
| rhcsa-processes-lab.sh | Full processes lab |
| rhcsa-security-lab.sh | Security observations |
| rhcsa-permissions-lab.sh | Full permissions lab |
| rhcsa-verification.sh | Verification |

---

## Key Skills Mastered

- [x] Identify Linux system (user, host, OS, kernel, arch)
- [x] Navigate filesystem hierarchy
- [x] Understand `/`, `/home`, `/etc`, `/usr`, `/var`, `/tmp`, `/proc`, `/sys`
- [x] Read directory permissions
- [x] Understand sticky bit
- [x] Create and manage users
- [x] Create and manage groups
- [x] Use sudo
- [x] List and manage processes
- [x] Manage system services
- [x] View logs
- [x] Identify SUID files
- [x] Set file permissions (numeric and symbolic)
- [x] Change file ownership

---

## Exam Relevance

This lesson establishes foundations for RHCSA:

- **Essential tools** — Command-line basics
- **File operations** — Navigation and management
- **Users and groups** — Account administration
- **File permissions** — Access control
- **Process inspection** — System state
- **Command-line administration** — Core skill

---

## Next Lesson

**Lesson 02 — Shell and Command Line**

Location: `02-shell-and-command-line/`

---

**Lesson 01 is complete. Move to Lesson 02.**
