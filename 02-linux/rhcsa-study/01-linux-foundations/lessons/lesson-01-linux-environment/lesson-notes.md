# Lesson 01 — Linux Environment

**Started:** 2026-10-11
**Status:** In Progress

---

## Parts

| Part | Topic | Status |
|------|-------|--------|
| 1 | Linux Environment | ✅ |
| 2 | Filesystem Exploration | ✅ |
| 3 | Users & Groups | ✅ |
| 4 | Processes & State | ✅ |
| 5 | Security Observations | ⏳ |
| 6 | Permissions Lab | ⏳ |
| 7 | Verification | ⏳ |
| 8 | Final Review | ⏳ |

---

## Part 1 — System Identification

| Command | Purpose |
|---------|---------|
| whoami | Show current user |
| pwd | Show current directory |
| hostname | Show machine name |
| cat /etc/os-release | Show distribution |
| uname -r | Show kernel |
| uname -a | Show all system info |
| uname -m | Show architecture |

**System profile:**
- User: fredrick
- Host: parrot
- OS: Parrot Security 7.4
- Kernel: 7.1.13+parrot7-amd64
- Arch: x86_64

---

## Part 2 — Filesystem

| Directory | Purpose |
|-----------|---------|
| / | Root |
| /home | User homes |
| /etc | Config |
| /usr | Programs |
| /var | Variable data |
| /tmp | Temporary (sticky bit) |
| /proc | Process info |
| /sys | Device info |
| /boot | Boot files |

**Key concepts:**
- `/` and `/root` are different
- `/tmp` has sticky bit: `drwxrwxrwt`
- `/lost+found` is restricted: `drwx------`
- Symlinks: `/bin` → `/usr/bin`

---

## Part 3 — Users & Groups

**RHCSA Essential Commands:**

| Command | Purpose |
|---------|---------|
| whoami | Current user |
| id | UID, GID, groups |
| useradd | Create user |
| usermod | Modify user |
| userdel | Delete user |
| passwd | Set/lock password |
| groupadd | Create group |
| groups | Show user groups |
| sudo | Run as root |

**User files:**
- `/etc/passwd` — Users
- `/etc/group` — Groups
- `/etc/shadow` — Passwords (root only)

---


---

## Part 4 — Processes

**RHCSA Essential Commands:**

| Command | Purpose |
|---------|---------|
| ps aux | List all processes |
| top -bn1 | Live process view (batch) |
| pgrep | Find PID by name |
| kill | Kill process by PID |
| systemctl | Manage services |
| journalctl | View logs |

**Key observations:**
- 351 processes running
- PID 1 = /sbin/init (systemd)
- Load average: 0.45 (idle system)
- Memory: 11 GB used, 778 MB free
- Top process: ollama (8.3% CPU)

**Running services:**
- docker, containerd, cron, dbus, bluetooth, fwupd

---

## Scripts Built

| Script | Purpose |
|--------|---------|
| system-report.sh | System info |
| filesystem-tour.sh | Directory overview |
| user-info.sh | User info |
| rhcsa-users-lab.sh | Full users lab |
| rhcsa-processes-lab.sh | Full processes lab |

---

**Next:** Part 4 — Processes
