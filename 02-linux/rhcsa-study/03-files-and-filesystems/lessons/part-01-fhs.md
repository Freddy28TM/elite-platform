# Module 03 — Part 01: Filesystem Hierarchy Standard (FHS)

**Date:** 2026-10-11
**Status:** Complete
**System:** Parrot Security 7.4 (Debian 13)
**Kernel:** 7.1.13+parrot7-amd64

---

## 1. Concept

Linux organizes everything under a single root directory `/`. Unlike Windows (drive letters like `C:\`), Linux presents one unified tree. Every file, device, process, and mount lives somewhere under `/`.

The **Filesystem Hierarchy Standard (FHS)** defines what each top-level directory is *for*.

> On Linux, "everything is a file" — but *where* that file lives tells you its purpose, its lifecycle, and who owns it.

---

## 2. Why It Matters

| Reason | Impact |
|--------|--------|
| Exam questions | RHCSA asks "which directory holds X?" — need instant recall |
| Troubleshooting | Knowing /var/log vs /run vs /tmp tells you what survives reboot |
| Package management | RPM/DEB place files in FHS-mandated locations |
| Security | Wrong permissions on /etc or /var = compromise |
| Mounts | Real deployments mount /home, /var on separate partitions |

---

## 3. FHS Top-Level Directories

| Directory | Purpose | Persists? | Safe to Wipe? |
|-----------|---------|-----------|---------------|
| / | Root of everything | Yes | No |
| /bin | Essential user binaries (-> usr/bin) | Yes | No |
| /sbin | Essential system binaries (-> usr/sbin) | Yes | No |
| /lib, /lib64 | Shared libraries (-> usr/lib) | Yes | No |
| /etc | System-wide configuration files | Yes | No |
| /boot | Kernel, initramfs, GRUB | Yes | No |
| /root | Home for root user | Yes | No |
| /home | User home directories | Yes | No |
| /var | Variable data (logs, spool, caches) | Yes | Risky |
| /tmp | Temporary files (tmpfs) | No | Yes |
| /run | Runtime data, PIDs, sockets (tmpfs) | No | Yes |
| /dev | Device files (virtual) | Virtual | No |
| /proc | Kernel/process info (virtual) | Virtual | No |
| /sys | Kernel/hardware info (virtual) | Virtual | No |
| /mnt | Manual mount point | Yes | Depends |
| /media | Auto-mounted removable media | Yes | Depends |
| /opt | Optional third-party software | Yes | Depends |
| /srv | Data for services (web, FTP) | Yes | Depends |
| /usr | User system resources | Yes | No |

---

## 4. Key Observations from This System

### usr-merge confirmed

/bin -> usr/bin
/sbin -> usr/sbin
/lib -> usr/lib
/lib64 -> usr/lib64
text


Standard since Debian 10. Old paths are symlinks into /usr.

### Kernel symlinks at root

/vmlinuz -> boot/vmlinuz-7.1.13+parrot7-amd64
/vmlinuz.old -> boot/vmlinuz-7.0.13+parrot7-amd64
/initrd.img -> boot/initrd.img-7.1.13+parrot7-amd64
/initrd.img.old -> boot/initrd.img-7.0.13+parrot7-amd64
text


Two kernels present: current (7.1.13) and previous (7.0.13).

### Custom mount

`/data` is a non-FHS custom partition, owned by fredrick:fredrick — the lab.

### Virtual filesystems show size 0

/proc, /sys appear as 0 bytes because they are kernel-generated, not on disk.

### Volatile directories

/tmp and /run are tmpfs (RAM-backed, cleared on reboot).

---

## 5. Command Reference

| Command | Purpose |
|---------|---------|
| ls -la / | Inspect root tree |
| ls -ld /bin /sbin /lib /lib64 | Confirm usr-merge symlinks |
| which ls | Find binary on PATH |
| readlink -f $(which ls) | Resolve symlinks to real path |
| stat -c '%n %s bytes' FILE | Show file size |
| df -h / | Disk usage on root partition |
| du -xh DIR --max-depth=1 | Space breakdown by directory |
| findmnt -no FSTYPE DIR | Show filesystem type of mount |
| mount \| grep TYPE | Filter mounts by type |
| cat /proc/version | Kernel version from proc |
| ls /sys/class/net/ | Network interfaces from sys |

---

## 6. Hands-On Practice

### Exercise 6.1 — Classify the Path

For each path, state: (a) FHS directory, (b) survives reboot?, (c) config/data/runtime?

1. /etc/ssh/sshd_config
2. /var/log/syslog
3. /run/sshd.pid
4. /home/fredrick/.bashrc
5. /usr/bin/python3
6. /boot/vmlinuz-7.1.13+parrot7-amd64
7. /tmp/session.lock
8. /proc/1/status

### Exercise 6.2 — Find the Boundary

Run and explain:

```bash
stat -c '%i %n' /bin /usr/bin    # same inode? (proves same file)
df -hT /tmp /run                  # tmpfs confirmed
sudo du -sh /var/* | sort -h | tail -5

Exercise 6.3 — FHS-Compliant App Layout

Create the correct locations for a service called widgetd:
bash

sudo mkdir -p /usr/local/bin
sudo mkdir -p /etc/widgetd
sudo mkdir -p /var/lib/widgetd
sudo mkdir -p /var/log/widgetd
sudo mkdir -p /usr/share/doc/widgetd

Question: Why /usr/local/bin and not /usr/bin?
Answer: /usr/bin is package-manager territory. /usr/local/bin is for locally-installed software apt won't touch.

## 7. Verification

Run the companion script:

    bash /data/cybersecurity/elite-platform/02-linux/rhcsa-study/03-files-and-filesystems/scripts/fhs-verify.sh

Expected: all PASS lines.

---

## 8. Key Takeaways

- Linux = single tree rooted at /
- FHS defines purpose of each top-level dir
- /bin, /sbin, /lib are symlinks to /usr/* (usr-merge)
- Virtual FS: /proc, /sys, /dev (not on disk, size 0)
- Volatile: /tmp, /run (tmpfs, cleared on reboot)
- Persistent config: /etc
- Persistent variable data: /var
- The real binary behind /bin/ls is /usr/bin/ls (158632 bytes)

---

## 9. Open Questions / Follow-up

- [ ] How does /etc differ from /usr/local/etc?
- [ ] When would you mount /var on a separate partition?
- [ ] How does systemd-tmpfiles manage /tmp cleanup?
- [ ] Why does the kernel keep .old symlinks alongside current?

---

**Lesson complete:** 2026-10-11
