# RHCSA Study Guide — Complete Learning Path

Everything you need to pass Red Hat Certified System Administrator (EX200).

**Target:** RHCSA certification
**Base Distro:** Parrot OS (Debian-based, RHCSA is RHEL-based, ~95% overlap)
**Duration:** 8 weeks
**Essential commands:** 65 total

---

## Learning Philosophy

**65 essential commands across 18 modules.**

Each module: 4-6 commands. Master these, pass RHCSA.

No overwhelm. One module at a time. Practice daily.

---

## The 18 Modules (In Order)

| # | Module | Commands | Priority |
|---|--------|----------|----------|
| 00 | orientation | Setup | Start here |
| 01 | linux-foundations | 5 | Core |
| 02 | shell-and-command-line | 6 | Core |
| 03 | files-and-filesystems | 6 | Core |
| 04 | users-groups-and-permissions | 6 | Core |
| 05 | processes-and-services | 5 | Core |
| 06 | software-management | 4 | Core |
| 07 | networking | 6 | Core |
| 08 | ssh-and-remote-administration | 5 | Core |
| 09 | storage-and-filesystems | 5 | Important |
| 10 | lvm-and-swap | 4 | Important |
| 11 | firewall-and-security | 4 | Core |
| 12 | selinux | 4 | Important |
| 13 | logs-and-troubleshooting | 5 | Core |
| 14 | scheduled-tasks | 4 | Core |
| 15 | containers | 4 | Bonus |
| 16 | bash-automation | 5 | Core |
| 17 | rhcsa-practical | Exam | Final |
| 18 | security-application | Advanced | Optional |

---

## Module 01 — Linux Foundations (5 commands)

| Command | Purpose |
|---------|---------|
| uname -a | System info |
| hostname | Show/set hostname |
| date | Date/time |
| whoami | Current user |
| history | Command history |

---

## Module 02 — Shell and Command Line (6 commands)

| Command | Purpose |
|---------|---------|
| echo | Output text |
| cat | View files |
| less | Paginated view |
| grep | Search text |
| find | Find files |
| pipe (|) | Chain commands |

---

## Module 03 — Files and Filesystems (6 commands)

| Command | Purpose |
|---------|---------|
| cd | Change directory |
| ls | List files |
| cp | Copy |
| mv | Move/rename |
| rm | Remove |
| mkdir | Create directory |

---

## Module 04 — Users, Groups, Permissions (6 commands)

| Command | Purpose |
|---------|---------|
| useradd | Create user |
| passwd | Set password |
| usermod | Modify user |
| groupadd | Create group |
| chmod | Change permissions |
| chown | Change owner |

---

## Module 05 — Processes and Services (5 commands)

| Command | Purpose |
|---------|---------|
| ps | List processes |
| top | Live processes |
| kill | Kill process |
| systemctl | Manage services |
| journalctl | View logs |

---

## Module 06 — Software Management (4 commands)

| Command | Purpose |
|---------|---------|
| dnf install | Install package |
| dnf remove | Remove package |
| dnf search | Search packages |
| rpm -qa | List installed |

---

## Module 07 — Networking (6 commands)

| Command | Purpose |
|---------|---------|
| ip a | Show IPs |
| nmcli | Network manager |
| ping | Test connectivity |
| ss -tlnp | Show ports |
| hostname -I | Show IPs |
| cat /etc/resolv.conf | DNS config |

---

## Module 08 — SSH and Remote Administration (5 commands)

| Command | Purpose |
|---------|---------|
| ssh | Remote login |
| scp | Copy over SSH |
| ssh-keygen | Generate keys |
| ssh-copy-id | Copy public key |
| systemctl status sshd | SSH daemon status |

---

## Module 09 — Storage and Filesystems (5 commands)

| Command | Purpose |
|---------|---------|
| lsblk | List block devices |
| df -h | Disk usage |
| du -sh | Directory size |
| mount | Mount filesystem |
| umount | Unmount |

---

## Module 10 — LVM and Swap (4 commands)

| Command | Purpose |
|---------|---------|
| pvcreate | Physical volume |
| vgcreate | Volume group |
| lvcreate | Logical volume |
| mkswap | Create swap |

---

## Module 11 — Firewall and Security (4 commands)

| Command | Purpose |
|---------|---------|
| firewall-cmd | Firewall rules |
| firewall-cmd --list-all | Show rules |
| ufw status | Debian firewall |
| semanage | SELinux context |

---

## Module 12 — SELinux (4 commands)

| Command | Purpose |
|---------|---------|
| getenforce | Check mode |
| setenforce | Change mode |
| ls -Z | Show context |
| restorecon | Restore context |

---

## Module 13 — Logs and Troubleshooting (5 commands)

| Command | Purpose |
|---------|---------|
| journalctl -xe | System logs |
| tail -f | Live log view |
| dmesg | Kernel logs |
| grep | Search logs |
| systemctl status | Service status |

---

## Module 14 — Scheduled Tasks (4 commands)

| Command | Purpose |
|---------|---------|
| crontab -e | Edit cron |
| crontab -l | List cron |
| at | One-time task |
| systemctl list-timers | System timers |

---

## Module 15 — Containers (4 commands)

| Command | Purpose |
|---------|---------|
| podman run | Run container |
| podman ps | List containers |
| podman images | List images |
| podman stop | Stop container |

---

## Module 16 — Bash Automation (5 commands)

| Command | Purpose |
|---------|---------|
| for loops | Iterate |
| if statements | Conditionals |
| $1, $2 | Script arguments |
| chmod +x | Make executable |
| bash script.sh | Run script |

---

## Module 17 — RHCSA Practical

Exam simulation:
- 3 hours
- Multiple systems
- Real tasks

---

## Module 18 — Security Application (Advanced)

- Applying security policies
- Auditing
- Compliance

---

## 8-Week Learning Plan

| Week | Modules | Focus |
|------|---------|-------|
| 1 | 00, 01, 02 | Foundations + shell |
| 2 | 03, 04, 05 | Files + users + processes |
| 3 | 06, 07, 08 | Packages + network + SSH |
| 4 | 09, 10 | Storage + LVM |
| 5 | 11, 12, 13 | Firewall + SELinux + logs |
| 6 | 14, 15, 16 | Tasks + containers + bash |
| 7 | 17 | Practice exam |
| 8 | 18 + review | Final prep |

---

## Daily Practice (30-45 minutes)

| Time | Activity |
|------|----------|
| 0-5 | Read module commands |
| 5-20 | Practice each command |
| 20-35 | Build something with them |
| 35-40 | Update progress tracker |
| 40-45 | Commit to git |

---

## Progress Tracker

| Week | Module | Commands Mastered | Date |
|------|--------|-------------------|------|
| 1 | 00-02 | [ ] | |
| 2 | 03-05 | [ ] | |
| 3 | 06-08 | [ ] | |
| 4 | 09-10 | [ ] | |
| 5 | 11-13 | [ ] | |
| 6 | 14-16 | [ ] | |
| 7 | 17 | [ ] | |
| 8 | 18 | [ ] | |

---

## Exam Prep

**Exam:** EX200 (RHCSA)
**Duration:** 3 hours
**Format:** Hands-on tasks

**Resources:**
- RHCSA Red Hat 9 (Ghori) — book
- Sander van Vugt video course
- Killercoda RHCSA scenarios
- r/redhat community

---

## Notes

- RHCSA uses `dnf` and `firewalld` (RHEL-based)
- Parrot uses `apt` and `ufw` (Debian-based)
- Concepts are the same. Practice on Parrot, then adapt.

---

**Master 65 commands. Pass RHCSA. Move to OSCP.**

**Last Updated:** 2026-10-11
