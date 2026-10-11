# Linux Administrator — RHCSA Essentials

Focused guide for passing RHCSA with minimum commands.

**Target:** Red Hat Certified System Administrator (EX200)
**Base Distro:** Parrot OS (Debian-based, RHCSA is RHEL-based — 95% overlap)

---

## Learning Philosophy

Master **48 essential commands** across 10 topics.

Every topic has 4-6 commands. Practice 10 minutes daily. That is enough for RHCSA.

---

## Topic 1 — Navigation and File Operations

**5 commands.**

| # | Command | Purpose | Example |
|---|---------|---------|---------|
| 1 | cd | Change directory | cd /data/cybersecurity |
| 2 | ls | List files | ls -la |
| 3 | pwd | Show current directory | pwd |
| 4 | cp | Copy files | cp file.txt /tmp/ |
| 5 | mv | Move or rename | mv old.txt new.txt |

**Practice:**
cd into 5 different directories in /data and list contents.

---

## Topic 2 — Users and Groups

**6 commands.**

| # | Command | Purpose | Example |
|---|---------|---------|---------|
| 1 | useradd | Create user | sudo useradd -m john |
| 2 | passwd | Set password | sudo passwd john |
| 3 | usermod | Modify user | sudo usermod -aG sudo john |
| 4 | userdel | Delete user | sudo userdel -r john |
| 5 | groupadd | Create group | sudo groupadd developers |
| 6 | id | Show user info | id john |

**Practice:**
Create a test user "rhcsa", add to sudo group, verify with id, then delete.

---

## Topic 3 — Permissions

**4 commands.**

| # | Command | Purpose | Example |
|---|---------|---------|---------|
| 1 | chmod | Change permissions | chmod 755 script.sh |
| 2 | chown | Change owner | sudo chown john:john file.txt |
| 3 | chgrp | Change group | sudo chgrp developers file.txt |
| 4 | umask | Default permissions | umask 022 |

**Practice:**
Create a file, set permissions to 644, owner to yourself, group to developers.

---

## Topic 4 — Processes and Services

**5 commands.**

| # | Command | Purpose | Example |
|---|---------|---------|---------|
| 1 | ps | List processes | ps aux |
| 2 | top | Live process view | top |
| 3 | kill | Kill process | kill -9 PID |
| 4 | systemctl | Manage services | sudo systemctl restart ssh |
| 5 | journalctl | View logs | sudo journalctl -u ssh |

**Practice:**
Start, stop, restart, and check status of a service.

---

## Topic 5 — Storage and Filesystems

**5 commands.**

| # | Command | Purpose | Example |
|---|---------|---------|---------|
| 1 | df | Disk free space | df -h |
| 2 | du | Directory size | du -sh /data |
| 3 | mount | Mount filesystem | sudo mount /dev/sdb1 /mnt |
| 4 | umount | Unmount | sudo umount /mnt |
| 5 | lsblk | List block devices | lsblk |

**Practice:**
Check disk usage, list partitions, identify /data mount point.

---

## Topic 6 — Networking

**6 commands.**

| # | Command | Purpose | Example |
|---|---------|---------|---------|
| 1 | ip | Network interface | ip a |
| 2 | ping | Test connectivity | ping -c 4 google.com |
| 3 | ss | Socket statistics | ss -tlnp |
| 4 | curl | HTTP requests | curl -I https://example.com |
| 5 | wget | Download files | wget https://example.com/file |
| 6 | ssh | Remote login | ssh user@host |

**Practice:**
Check your own IP, ping a server, check open ports.

---

## Topic 7 — Package Management

**4 commands.**

| # | Command | Purpose | Example |
|---|---------|---------|---------|
| 1 | apt update | Update package list | sudo apt update |
| 2 | apt install | Install package | sudo apt install nginx |
| 3 | apt remove | Remove package | sudo apt remove nginx |
| 4 | apt search | Search packages | apt search wireshark |

**Note:** RHCSA uses dnf/yum on RHEL. Parrot uses apt. Same concept.

**Practice:**
Install, verify, then remove a small package like tree.

---

## Topic 8 — SELinux

**4 commands.**

| # | Command | Purpose | Example |
|---|---------|---------|---------|
| 1 | getenforce | Check SELinux mode | getenforce |
| 2 | setenforce | Change mode | sudo setenforce 0 |
| 3 | ls -Z | Show SELinux context | ls -Z /var/www |
| 4 | restorecon | Restore context | sudo restorecon -Rv /var/www |

**Note:** Parrot uses AppArmor by default. SELinux concepts still exam-relevant.

---

## Topic 9 — Firewall

**4 commands.**

| # | Command | Purpose | Example |
|---|---------|---------|---------|
| 1 | ufw status | Check firewall | sudo ufw status |
| 2 | ufw allow | Allow port | sudo ufw allow 22 |
| 3 | ufw deny | Deny port | sudo ufw deny 23 |
| 4 | iptables -L | List rules | sudo iptables -L |

**Practice:**
Enable firewall, allow SSH, verify rules.

---

## Topic 10 — Scheduling and Logs

**5 commands.**

| # | Command | Purpose | Example |
|---|---------|---------|---------|
| 1 | crontab -e | Edit cron jobs | crontab -e |
| 2 | crontab -l | List cron jobs | crontab -l |
| 3 | at | One-time schedule | echo ls | at now + 1 min |
| 4 | journalctl | System logs | journalctl -xe |
| 5 | tail -f | Live log view | tail -f /var/log/syslog |

**Practice:**
Schedule a cron job that writes time to /tmp/cron-test.txt every minute.

---


---

## Topic 11 — Cryptography in Linux

**6 commands.**

| # | Command | Purpose | Example |
|---|---------|---------|---------|
| 1 | md5sum | MD5 hash | md5sum file.txt |
| 2 | sha256sum | SHA-256 hash | sha256sum file.txt |
| 3 | ssh-keygen | Generate SSH key | ssh-keygen -t ed25519 |
| 4 | openssl | Crypto toolkit | openssl enc -aes-256-cbc |
| 5 | gpg | Encryption/signing | gpg --gen-key |
| 6 | base64 | Encoding | base64 file.txt |

**When to use:**
- Verify file integrity (sha256sum)
- Generate SSH keys for servers
- Sign commits and emails (gpg)
- Encrypt/decrypt files (openssl, gpg)

**Practice:**
Generate a SHA-256 hash of a file, verify it after transfer. Generate an SSH key pair, copy public key to a server. Encrypt a text file with openssl.

## Daily 10-Minute Practice

Day 1-2: Navigation, Users, Permissions
Day 3-4: Processes, Storage, Networking
Day 5-6: Packages, SELinux, Firewall
Day 7-8: Scheduling, Logs, Review
Day 9-10: Full simulation

Repeat for 4 weeks. RHCSA ready.

---

## Study Resources

| Resource | Cost | Notes |
|----------|------|-------|
| Red Hat RHCSA course (RH124, RH134) | Paid | Official |
| Sander van Vugt RHCSA Video | Paid | Best-rated |
| Linux Academy RHCSA | Paid | Video course |
| "RHCSA Red Hat Enterprise Linux 9" book (Ghori) | Paid | Comprehensive |
| Killercoda RHCSA scenarios | Free | Hands-on |
| r/redhat | Free | Community |

---

## Practice Lab Plan

1. **Setup:** Install CentOS Stream 9 in a VM (for RHEL compatibility)
2. **Daily:** 10 minutes of command practice
3. **Weekly:** 1 hour of scenario practice
4. **Monthly:** Full mock exam

Once comfortable, schedule the EX200 exam.

---

## Integration with Elite Platform

All RHCSA practice happens in this lab:
- Use /data as practice storage
- Create test users in Parrot OS
- Practice networking commands
- Use Docker containers to simulate RHEL

Real RHCSA exam runs on RHEL. Practice makes perfect.

---

## Progress Tracker

| Topic | Commands Mastered | Date Completed |
|-------|------------------|---------------|
| 1. Navigation | [ ] | |
| 2. Users | [ ] | |
| 3. Permissions | [ ] | |
| 4. Processes | [ ] | |
| 5. Storage | [ ] | |
| 6. Networking | [ ] | |
| 7. Packages | [ ] | |
| 8. SELinux | [ ] | |
| 9. Firewall | [ ] | |
| 10. Scheduling | [ ] | |

---

**Master 48 commands. Pass RHCSA. Move to OSCP.**
